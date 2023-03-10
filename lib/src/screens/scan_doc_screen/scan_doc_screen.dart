import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/custom_app_bar.dart';
import 'package:skendy/src/custom_widgets/custom_button.dart';
import 'package:skendy/src/custom_widgets/scan_doc_row.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class ScanDocScreen extends StatefulWidget {
  const ScanDocScreen({Key? key}) : super(key: key);

  @override
  State<ScanDocScreen> createState() => _ScanDocScreenState();
}

class _ScanDocScreenState extends State<ScanDocScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomAppBar(
              widget: Container(
                height: 25,
                width: 47,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xffEAF3FB)),
                child: Center(
                  child: Text(MyStrings.skip, style: MyStyles.blue10Normal),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 7,
                      color: Colors.black.withOpacity(.1))
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  ScanDocRow(
                    onTap: () {},
                    icon: MyImages.ibanIcon,
                    text: MyStrings.iban,
                    color: MyColors.lightBlue,
                    divider: true,
                  ),
                  ScanDocRow(
                    onTap: () {},
                    icon: MyImages.amount,
                    text: MyStrings.amount,
                    color: MyColors.lightPink,
                    divider: true,
                  ),
                  ScanDocRow(
                    onTap: () {},
                    icon: MyImages.descriptionIcon,
                    text: MyStrings.description,
                    color: MyColors.lightGreen,
                    divider: true,
                  ),
                  ScanDocRow(
                    onTap: () {},
                    icon: MyImages.receiverIcon,
                    text: MyStrings.receiver,
                    color: MyColors.lightOrange,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
            child: CustomButton(
              onTap: (){},
              text: MyStrings.approve,
              border: true,
            ),
          )
        ],
      ),
    );
  }
}
