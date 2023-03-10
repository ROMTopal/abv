import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/custom_button.dart';
import 'package:skendy/src/screens/login_screen/login_screen.dart';
import 'package:skendy/src/screens/sign_up_screen/sign_up_screen.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).splashColor,
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(MyImages.bgLeft,color: Theme.of(context).primaryColor),
                  ],
                ),
              ),
              Image.asset(MyImages.whiteLogo,width: 186,height: 49),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(MyImages.bgRight,width: 132,height: 518,color: Theme.of(context).primaryColor),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(MyStrings.skendy,style: MyStyles.white20Normal,),
                const SizedBox(
                  height: 5,
                ),
                Text(MyStrings.letsOrganize,style: MyStyles.white16regular,),
                const SizedBox(
                  height: 30,
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const LoginScreen()),);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(MyStrings.login,style: MyStyles.white16Normal.copyWith(
                        color: Theme.of(context).highlightColor
                      )),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const SignUpScreen()),);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                        color: MyColors.transparent,
                        border: Border.all(
                          color: Theme.of(context).dividerColor
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(MyStrings.signUp,style: MyStyles.white16Normal.copyWith(
                          color: MyColors.white
                      )),
                    ),
                  ),
                ),

              ],
            ),
          )
        ],
      )
    );
  }
}
