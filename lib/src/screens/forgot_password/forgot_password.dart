import 'package:flutter/material.dart';
import 'package:skendy/auth_modules/email_pass_auth.dart';
import 'package:skendy/src/custom_widgets/custom_button.dart';
import 'package:skendy/src/custom_widgets/custom_textfield.dart';
import 'package:skendy/src/custom_widgets/snackbar.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';
import 'package:skendy/src/utils/my_validator.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController email = TextEditingController();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(MyStrings.forgotPassword,style: MyStyles.black20Normal.copyWith(
                    color: Theme.of(context).hintColor
                ),),
                const SizedBox(
                  height: 10,
                ),
                Text(MyStrings.pleaseEnterYour,style: MyStyles.gray16Light,),
                const SizedBox(
                  height: 20,
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
                  height: 50,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      print("VALIDATED");
                      await EmailPassAuth.resetPassword(email.text, context, () {
                        print("QQQQQQQQQ");
                        Navigator.of(context).pop();
                        snackBar(context,"Reset password link is sent, reset password their and login",duration: Duration(seconds: 5));

                      });
                      print('WOWOWOW');
                     /* Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const OtpScreen()),
                              (route) => false);*/
                    }
                  },
                  text: MyStrings.submit,
                  border: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
