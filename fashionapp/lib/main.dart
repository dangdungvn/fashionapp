import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/src/addresses/controllers/address_notifier.dart';
import 'package:fashionapp/src/auth/controllers/auth_notifier.dart';
import 'package:fashionapp/src/auth/controllers/password_notifier.dart';
import 'package:fashionapp/src/cart/controllers/cart_notifier.dart';
import 'package:fashionapp/src/categories/controllers/category_notifier.dart';
import 'package:fashionapp/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:fashionapp/src/home/controller/home_tab_notifier.dart';
import 'package:fashionapp/src/notification/controllers/notification_notifier.dart';
import 'package:fashionapp/src/products/controller/colors_sizes_notifier.dart';
import 'package:fashionapp/src/products/controller/product_notifier.dart';
import 'package:fashionapp/src/reviews/controllers/rating_notifier.dart';
import 'package:fashionapp/src/search/controllers/search_notifier.dart';
import 'package:fashionapp/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fashionapp/common/utils/app_routes.dart';
import 'package:fashionapp/common/utils/environment.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/src/onboarding/controllers/onboarding_notifier.dart';
import 'package:fashionapp/src/splashscreen/views/splashscreen_screen.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform;

// Thêm import cho package window_manager trên Windows
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cấu hình window_manager cho Windows
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();

    // Kích thước của Oppo A94 (dp)
    const double width = 430; // Tương đương với dp của Oppo A94
    const double height = 840; // Tương đương với dp của Oppo A94

    // Thiết lập kích thước cố định cho cửa sổ
    WindowOptions windowOptions = const WindowOptions(
      size: Size(width, height),
      center: true,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      title: AppText.kAppName,
      minimumSize: Size(width, height),
      maximumSize: Size(width, height), // Cố định kích thước tối đa
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager
          .setResizable(false); // Không cho phép thay đổi kích thước
    });
  }

  await dotenv.load(fileName: Environment.fileName);
  await GetStorage.init();
  final isFirstRun = checkFirstRun();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingNotifier()),
        ChangeNotifierProvider(create: (_) => TabIndexNotifier()),
        ChangeNotifierProvider(create: (_) => CategoryNotifier()),
        ChangeNotifierProvider(create: (_) => HomeTabNotifier()),
        ChangeNotifierProvider(create: (_) => ProductNotifier()),
        ChangeNotifierProvider(create: (_) => ColorsSizesNotifier()),
        ChangeNotifierProvider(create: (_) => PasswordNotifier()),
        ChangeNotifierProvider(create: (_) => AuthNotifier()),
        ChangeNotifierProvider(create: (_) => SearchNotifier()),
        ChangeNotifierProvider(create: (_) => WishlistNotifier()),
        ChangeNotifierProvider(create: (_) => CartNotifier()),
        ChangeNotifierProvider(create: (_) => AddressNotifier()),
        ChangeNotifierProvider(create: (_) => NotificationNotifier()),
        ChangeNotifierProvider(create: (_) => RatingNotifier()),
      ],
      child: MyApp(
        isFirstRun: isFirstRun,
      ),
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.top,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarContrastEnforced: true,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

bool checkFirstRun() {
  final box = GetStorage();
  bool isFirstRun = box.read('isFirstRun') ?? true; // Mặc định là true
  if (isFirstRun) {
    box.write('isFirstRun', false); // Đánh dấu không còn là lần đầu tiên
  }
  return isFirstRun;
}

class MyApp extends StatelessWidget {
  final bool isFirstRun;
  const MyApp({super.key, required this.isFirstRun});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Storage().setBool('firstOpen', checkFirstRun());
    return ScreenUtilInit(
      // Sử dụng kích thước thiết kế cố định thay vì theo màn hình hiện tại
      designSize:
          const Size(375, 812), // Kích thước thiết kế tiêu chuẩn iPhone X
      minTextAdapt: true,
      splitScreenMode: true, // Cải thiện xử lý trên tablet và màn hình lớn
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppText.kAppName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Kolors.kPrimary,
              primary: Kolors.kPrimary,
              secondary: Kolors.kAccent,
              tertiary: Kolors.kAccent2,
              background: Kolors.kOffWhite,
              surface: Kolors.kWhite,
              error: Kolors.kRed,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
            fontFamily: GoogleFonts.poppins().fontFamily,
            textTheme: TextTheme(
              displayLarge: TextStyle(
                color: Kolors.kDark,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
              displayMedium: TextStyle(
                color: Kolors.kDark,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
              displaySmall: TextStyle(
                color: Kolors.kDark,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
              bodyLarge: TextStyle(
                color: Kolors.kDark,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
              bodyMedium: TextStyle(
                color: Kolors.kGray,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Kolors.kWhite,
              elevation: 0,
              centerTitle: true,
              iconTheme: const IconThemeData(
                color: Kolors.kDark,
              ),
              titleTextStyle: TextStyle(
                color: Kolors.kDark,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Kolors.kPrimary,
                foregroundColor: Kolors.kWhite,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ),
            cardTheme: CardTheme(
              color: Kolors.kWhite,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Kolors.kWhite,
              contentPadding: const EdgeInsets.all(16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Kolors.kGrayLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Kolors.kGrayLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Kolors.kPrimary),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Kolors.kRed),
              ),
              hintStyle: TextStyle(
                color: Kolors.kGray,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            navigationBarTheme: NavigationBarThemeData(
              backgroundColor: Kolors.kWhite,
              indicatorColor: Kolors.kPrimary.withOpacity(0.2),
              labelTextStyle: WidgetStateProperty.all(TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              )),
              iconTheme: WidgetStateProperty.all(const IconThemeData(
                size: 24,
              )),
            ),
          ),
          routerConfig: router,
        );
      },
      child: const SplashScreen(),
    );
  }
}
