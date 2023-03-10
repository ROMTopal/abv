import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/custom_button.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class SuccessOne extends StatefulWidget {
  const SuccessOne({Key? key}) : super(key: key);

  @override
  State<SuccessOne> createState() => _SuccessOneState();
}

class _SuccessOneState extends State<SuccessOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              height: 391,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 7,
                        color: Colors.black.withOpacity(.1))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(MyImages.successFullyIcon,width: 158,height: 158,),
                  Text(MyStrings.successFullyFiled,style: MyStyles.black16Normal.copyWith(
                    color: Theme.of(context).hintColor
                  ),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 75),
                    child: CustomButton(
                      onTap: (){},
                      text: "Continue",
                      border: true,
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
