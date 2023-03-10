import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skendy/auth_modules/email_pass_auth.dart';
import 'package:skendy/src/common/showLoader.dart';
import 'package:skendy/src/custom_widgets/custom_button.dart';
import 'package:skendy/src/custom_widgets/custom_textfield.dart';
import 'package:skendy/src/custom_widgets/social_media.dart';
import 'package:skendy/src/screens/login_screen/login_screen.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';
import 'package:skendy/src/utils/my_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController reEnterPass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isObscurePassword = true;
  bool isObscureRePassword = true;

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
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  MyImages.logo,
                  height: 46,
                  width: 144,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      MyStrings.createYourAccount,
                      style: MyStyles.black20Normal.copyWith(
                          color: Theme.of(context).hintColor
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  validator: (s) => MyValidation.fullNameValidation(s!),
                  controller: fullName,
                  prefixIcon: MyImages.profile,
                  prefixColor: MyColors.lightPink,
                  hint: MyStrings.fullName,
                  textInputType: TextInputType.name,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  validator: (s) => MyValidation.emailValidation(s!),
                  controller: email,
                  prefixIcon: MyImages.emailIcon,
                  prefixColor: MyColors.lightOrange,
                  hint: MyStrings.emailAddress,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 15,
                ),
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
                        child: Icon(isObscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility))),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    validator: (s) => MyValidation.reEnterPasswordValidation(s!,
                        validate: password.text),
                    controller: reEnterPass,
                    prefixIcon: MyImages.lock,
                    prefixColor: MyColors.lightGreen,
                    hint: MyStrings.reEnterPass,
                    textInputType: TextInputType.visiblePassword,
                    obscureText: isObscureRePassword,
                    suffixWidget: GestureDetector(
                        onTap: () {
                          setState(() {
                            isObscureRePassword = !isObscureRePassword;
                          });
                        },
                        child: Icon(isObscureRePassword
                            ? Icons.visibility_off
                            : Icons.visibility))),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  border: true,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      print("Form Validated successfully");
                      showLoading(context);
                      User? user = await EmailPassAuth.createUserWithEmailPass(email.text, password.text, context);
                      Navigator.of(context).pop();
                      print("user = $user");
                      if(user !=null){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
                      }
                    }
                  },
                  text: MyStrings.create,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(MyStrings.orContinue, style: MyStyles.black14Regular.copyWith(
                    color: Theme.of(context).hintColor
                )),
                const SizedBox(
                  height: 30,
                ),
                const OtherLoginOpt(),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const LoginScreen()),);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(MyStrings.alreadyHaveAnAcc,
                          style: MyStyles.black14Light.copyWith(
                              color: Theme.of(context).hintColor
                          )),
                      Text(MyStrings.login, style: MyStyles.blue14Light),
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
