import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/custom_app_bar.dart';
import 'package:skendy/src/custom_widgets/scanned_card.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class RecentlyScan extends StatefulWidget {
  const RecentlyScan({Key? key}) : super(key: key);

  @override
  State<RecentlyScan> createState() => _RecentlyScanState();
}

class _RecentlyScanState extends State<RecentlyScan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomAppBar(
              title: MyStrings.scanned,
            ),
            Row(
              children: [
                Text(
                  MyStrings.recentlyScanned,
                  style: MyStyles.black20Normal.copyWith(
                      color: Theme.of(context).hintColor
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ScannedCard(
              icon: MyImages.pdfIcon,
              name: "1247655.pdf",
              category: MyStrings.job,
            ),
            ScannedCard(
              icon: MyImages.docIcon,
              name: "988765456.doc",
              category: MyStrings.healthcare,
            ),
            ScannedCard(
              icon: MyImages.pdfIcon,
              name: "987765.pdf",
              category: MyStrings.housing,
            ),
            ScannedCard(
              icon: MyImages.docIcon,
              name: "988765456.doc",
              category: MyStrings.tax,
            ),
          ],
        ),
      ),
    );
  }
}
