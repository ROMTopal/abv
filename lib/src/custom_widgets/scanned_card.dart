import 'package:flutter/material.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class ScannedCard extends StatefulWidget {

  final String? icon;
  final String? name;
  final String? category;

  const ScannedCard({Key? key, this.icon, this.name, this.category})
      : super(key: key);

  @override
  State<ScannedCard> createState() => _ScannedCardState();
}

class _ScannedCardState extends State<ScannedCard> {
  List<PopupMenuItem<String>> get dropdownItems {
    List<PopupMenuItem<String>> menuItems = [
      PopupMenuItem<String>(
          value: MyStrings.rename,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(MyImages.renameIcon,width: 16,height: 16,color: Theme.of(context).hintColor),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  MyStrings.rename,
                  style: const TextStyle(fontSize: 16),
                )
              ])),
      PopupMenuItem<String>(
          value: MyStrings.copy,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(MyImages.copyIcon,width: 16,height: 16,color: Theme.of(context).hintColor),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  MyStrings.copy,
                  style: const TextStyle(fontSize: 16),
                )
              ])),
      PopupMenuItem<String>(
          value: MyStrings.move,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(MyImages.moveIcon,width: 16,height: 16,color: Theme.of(context).hintColor),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  MyStrings.move,
                  style: const TextStyle(fontSize: 16),
                )
              ])),
      PopupMenuItem<String>(
          value: MyStrings.delete,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(MyImages.deleteIcon,width: 16,height: 16,color: Theme.of(context).hintColor),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  MyStrings.delete,
                  style: const TextStyle(fontSize: 16),
                )
              ])),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 72,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Image.asset(widget.icon!, height: 40, width: 40,),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(widget.name!, style: MyStyles.black16Normal.copyWith(
                            color: Theme.of(context).hintColor
                        ),),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 22,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Theme.of(context).hoverColor),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15),
                              child: Text(widget.category!,
                                  style: MyStyles.blue12Regular),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text("14 dec, 2022 at 14:54 Pm | 2.9 MB",
                      style: MyStyles.gray12Light,)
                  ],
                ),
                const Spacer(),
                // const Icon(Icons.more_vert)
                Container(
                  height: 40,
                  width: 35,
                  color: MyColors.transparent,
                  child: PopupMenuButton(
                    elevation: 3.2,
                    // initialValue: dropdownItems[1].value,
                    onCanceled: () {
                      print('You have not chossed anything');
                    },
                    tooltip: 'This is tooltip',
                    // onSelected: _select,
                    itemBuilder: (BuildContext context) {
                      return dropdownItems;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
