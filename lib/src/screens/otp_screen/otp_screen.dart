import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:skendy/src/custom_widgets/custom_button.dart';
import 'package:skendy/src/screens/change_password/change_password.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  PinTheme defaultPinTheme = PinTheme(
      height: 60,
      width: 65,
      textStyle: TextStyle(
          fontSize: 20, color: MyColors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: MyColors.white,
        border: Border.all(color: MyColors.gray.withOpacity(0.5), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20));

  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                MyStrings.otpVerification,
                style: MyStyles.black20Normal.copyWith(
                    color: Theme.of(context).hintColor
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                MyStrings.weHaveSend,
                style: MyStyles.gray16Light,
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Pinput(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter OTP";
                    }
                    return null;
                  },
                  controller: codeController,
                  defaultPinTheme: defaultPinTheme.copyWith(
                    textStyle: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).dividerColor
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor
                    )
                  ),
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  length: 6,
                  // onCompleted: (pin) => print(pin),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                border: true,
                text: MyStrings.submit,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const ChangePassword()),);
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(MyStrings.donReceive,style: MyStyles.black14Light.copyWith(
                      color: Theme.of(context).hintColor
                  )),
                  Text(MyStrings.resend,style: MyStyles.blue14Light),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
