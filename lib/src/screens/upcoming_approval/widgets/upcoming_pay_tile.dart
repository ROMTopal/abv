import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/icon_card.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_style.dart';

class UpcomingPayTile extends StatelessWidget {
  final String? date;
  final String? title;
  final VoidCallback? onTap;
  final bool check;
  final ValueChanged<bool?>? onChanged;

  const UpcomingPayTile({Key? key, this.date, this.title, this.onTap, required this.check, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: MyColors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                        height: 24,
                        child: Checkbox(value: check, onChanged: onChanged)),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title!, style: MyStyles.black16Regular.copyWith(color: Theme.of(context).hintColor)),
                        const SizedBox(height: 10),
                        Text(date!, style: MyStyles.black14Light.copyWith(color: MyColors.grayFont)),
                      ],
                    ),
                    const Spacer(),
                    Image.asset(MyImages.editIcon, height: 24, width: 24, color: Theme.of(context).canvasColor)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
