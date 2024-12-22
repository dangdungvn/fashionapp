import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/custom_button.dart';
import 'package:fashionapp/common/widgets/email_textfield.dart';
import 'package:fashionapp/common/widgets/password_field.dart';
import 'package:fashionapp/const/resource.dart';
import 'package:fashionapp/src/auth/controllers/auth_notifier.dart';
import 'package:fashionapp/src/auth/models/registration_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final TextEditingController _usernameController =
      TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final FocusNode _passwordNode = FocusNode();
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBackButton(),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 100.h,
          ),
          Lottie.asset(
            R.ASSETS_ANIMATIONS_REGISTER_JSON,
            width: 200.w,
            height: 200.h,
          ),
          Text(
            "4o Shop",
            textAlign: TextAlign.center,
            style: appStyle(
              24,
              Kolors.kPrimary,
              FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Hi! Welcome Back",
            textAlign: TextAlign.center,
            style: appStyle(13, Kolors.kGray, FontWeight.normal),
          ),
          SizedBox(
            height: 25.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                EmailTextField(
                  radius: 25,
                  // focusNode: _passwordNode,
                  hintText: "Username",
                  controller: _usernameController,
                  prefixIcon: const Icon(
                    CupertinoIcons.profile_circled,
                    size: 20,
                    color: Kolors.kGray,
                  ),
                  keyboardType: TextInputType.name,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                ),
                SizedBox(
                  height: 25.h,
                ),
                EmailTextField(
                  radius: 25,
                  focusNode: _passwordNode,
                  hintText: "Email",
                  controller: _emailController,
                  prefixIcon: const Icon(
                    CupertinoIcons.mail,
                    size: 20,
                    color: Kolors.kGray,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                ),
                SizedBox(
                  height: 25.h,
                ),
                PasswordField(
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  radius: 25,
                ),
                SizedBox(
                  height: 20.h,
                ),
                context.watch<AuthNotifier>().isRLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Kolors.kPrimary,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Kolors.kWhite),
                        ),
                      )
                    : CustomButton(
                        onTap: () {
                          RegistrationModel model = RegistrationModel(
                            password: _passwordController.text,
                            username: _usernameController.text,
                            email: _emailController.text,
                          );
                          String data = registrationModelToJson(model);
                          // print(data);
                          context
                              .read<AuthNotifier>()
                              .registrationFunc(data, context);
                        },
                        text: "S I G N  U P",
                        btnWidth: ScreenUtil().screenWidth,
                        btnHieght: 40.h,
                        radius: 20,
                      ),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: SizedBox(
      //   height: 130.h,
      //   child: Center(
      //     child: Padding(
      //       padding: const EdgeInsets.only(bottom: 110.0),
      //       child: GestureDetector(
      //         onTap: () {},
      //         child: Text(
      //           "Don't have an account? Sign Up",
      //           style: appStyle(12, Colors.blue, FontWeight.normal),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
