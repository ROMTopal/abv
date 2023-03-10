// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skendy/auth_modules/email_pass_auth.dart';
import 'package:skendy/src/common/showLoader.dart';
import 'package:skendy/src/custom_widgets/custom_button.dart';
import 'package:skendy/src/custom_widgets/custom_textfield.dart';
import 'package:skendy/src/custom_widgets/snackbar.dart';
import 'package:skendy/src/custom_widgets/social_media.dart';
import 'package:skendy/src/screens/forgot_password/forgot_password.dart';
import 'package:skendy/src/screens/home/home.dart';
import 'package:skendy/src/screens/sign_up_screen/sign_up_screen.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';
import 'package:skendy/src/utils/my_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isObscurePassword = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Image.asset(MyImages.logo, height: 46, width: 144),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      MyStrings.loginInTo,
                      style: MyStyles.black20Normal.copyWith(color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  validator: (s) => MyValidation.emailValidation(s!),
                  controller: email,
                  prefixIcon: MyImages.emailIcon,
                  prefixColor: MyColors.lightOrange,
                  hint: MyStrings.emailAddress,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                    validator: (s) => MyValidation.passwordValidation(s!),
                    controller: password,
                    prefixIcon: MyImages.lock,
                    prefixColor: MyColors.lightGreen,
                    hint: MyStrings.password,
                    textInputType: TextInputType.visiblePassword,
                    obscureText: isObscurePassword,
                    suffixWidget: GestureDetector(
                        onTap: () {
                          setState(() {
                            isObscurePassword = !isObscurePassword;
                          });
                        },
                        child: Icon(isObscurePassword ? Icons.visibility_off : Icons.visibility))),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ForgotPassword()),
                          );
                        },
                        child: Text(
                          MyStrings.forgotPassword,
                          style: MyStyles.blue14Regular,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomButton(
                  border: true,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      print("QQQQQQQQQQQQ");
                      showLoading(context);
                      UserCredential? user = await EmailPassAuth.signInUser(email.text, password.text, context);
                      Navigator.of(context).pop();
                      print(user);
                      if (user !=null && user.user!.emailVerified) {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => Home()), (route) => false);
                      } else {
                        if(user!=null){
                          showLoading(context);
                          await EmailPassAuth.sendVerification();
                          snackBar(context, "Please verify email and try to login again");
                          Navigator.of(context).pop();

                        }
                      }
                    }
                  },
                  text: MyStrings.login,
                ),
                const SizedBox(height: 30),
                Text(MyStrings.orContinue, style: MyStyles.black14Regular.copyWith(color: Theme.of(context).hintColor)),
                const SizedBox(height: 30),
                const OtherLoginOpt(),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpScreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(MyStrings.donHaveAn, style: MyStyles.black14Light.copyWith(color: Theme.of(context).hintColor)),
                      Text(MyStrings.signUp, style: MyStyles.blue14Light),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
