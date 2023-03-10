import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/custom_button.dart';
import 'package:skendy/src/custom_widgets/custom_textfield.dart';
import 'package:skendy/src/screens/home/home.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';
import 'package:skendy/src/utils/my_validator.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  MyStrings.changePassword,
                  style: MyStyles.black20Normal.copyWith(
                      color: Theme.of(context).hintColor
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  MyStrings.youCanResetPass,
                  style: MyStyles.gray16Light,
                ),
                const SizedBox(
                  height: 20,
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
                  height: 20,
                ),
                CustomTextField(
                    validator: (s) => MyValidation.reEnterPasswordValidation(s!,validate: password.text),
                    controller: reEnterPass,
                    prefixIcon: MyImages.blueLock,
                    prefixColor: MyColors.lightBlue,
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
                  height: 50,
                ),
                CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Home()),
                              (route) => false);
                    }
                  },
                  text: MyStrings.changePassword,
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
