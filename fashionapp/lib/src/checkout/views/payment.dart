import 'package:fashionapp/src/cart/controllers/cart_notifier.dart';
import 'package:fashionapp/src/checkout/views/failed_payment.dart';
import 'package:fashionapp/src/checkout/views/successful_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'dart:io' show Platform;
import 'package:webview_windows/webview_windows.dart' as win_webview;

class PaymentWebView extends StatefulWidget {
  const PaymentWebView({super.key});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;
  win_webview.WebviewController? _windowsController;
  bool _isWindows = false;

  @override
  void initState() {
    final cartNotifier = Provider.of<CartNotifier>(context, listen: false);
    super.initState();

    if (Platform.isWindows) {
      _isWindows = true;
      _initWindowsWebView(cartNotifier);
    } else {
      _initMobileWebView(cartNotifier);
    }
  }

  Future<void> _initWindowsWebView(CartNotifier cartNotifier) async {
    try {
      _windowsController = win_webview.WebviewController();
      await _windowsController!.initialize();
      await _windowsController!.loadUrl(cartNotifier.paymentUrl);

      _windowsController!.url.listen((url) {
        debugPrint('Windows WebView URL changed: $url');
        cartNotifier.setSuccessUrl(url);
      });

      if (!mounted) return;
      setState(() {});
    } catch (e) {
      debugPrint('Error initializing Windows WebView: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Không thể khởi tạo thanh toán trên nền tảng Windows. Vui lòng thử trên thiết bị di động.'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  void _initMobileWebView(CartNotifier cartNotifier) {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            cartNotifier.setSuccessUrl(url);
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            cartNotifier.setSuccessUrl(change.url.toString());
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(cartNotifier.paymentUrl));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  void dispose() {
    if (_isWindows && _windowsController != null) {
      _windowsController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(
      builder: (context, cartNotifier, child) {
        if (cartNotifier.success.contains('checkout-success')) {
          return const SuccessfulPayment();
        } else if (cartNotifier.success.contains('cancel')) {
          return const FailedPayment();
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.only(top: 60.h),
            child: _buildWebView(),
          ),
        );
      },
    );
  }

  Widget _buildWebView() {
    if (_isWindows) {
      if (_windowsController != null &&
          _windowsController!.value.isInitialized) {
        return win_webview.Webview(_windowsController!);
      } else {
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Đang khởi tạo thanh toán...'),
            ],
          ),
        );
      }
    } else {
      return WebViewWidget(controller: _controller);
    }
  }
}
