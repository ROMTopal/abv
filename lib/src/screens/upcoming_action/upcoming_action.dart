import 'package:flutter/material.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_images.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class UpcomingActions extends StatefulWidget {
  const UpcomingActions({Key? key}) : super(key: key);

  @override
  State<UpcomingActions> createState() => _UpcomingActionsState();
}

class _UpcomingActionsState extends State<UpcomingActions> {
  List<String> tabList = [MyStrings.upcoming, MyStrings.passed];
  bool isUpcomingSelected = true;
  List<bool> tabSelectList = [false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: () => Navigator.pop(context), child: Image.asset(MyImages.backIcon, color: Theme.of(context).hintColor)),
                  Text(MyStrings.actions, style: MyStyles.black18Normal.copyWith(color: Theme.of(context).hintColor)),
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(MyImages.actions, height: 24, width: 24, color: Theme.of(context).hintColor)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ToggleTab(
                            title: tabList[0],
                            isLeft: true,
                            isSelected: isUpcomingSelected,
                            onClick: () {
                              isUpcomingSelected = true;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: ToggleTab(
                            title: tabList[1],
                            isLeft: false,
                            isSelected: !isUpcomingSelected,
                            onClick: () {
                              isUpcomingSelected = false;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    if(isUpcomingSelected)...[
                      Expanded(child: ListView.builder(itemBuilder: (c, i) {
                        return  ActionTile(isDue: i%3==0,);
                      })),
                    ]else...[
                      Expanded(child: ListView.builder(itemBuilder: (c, i) {
                        return  ActionTile(isDue: i%2==0,);
                      })),
                    ]

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ToggleTab extends StatelessWidget {
  final bool isSelected;
  final String title;
  final bool isLeft;
  final VoidCallback onClick;

  ToggleTab({Key? key, required this.isSelected, required this.title, required this.isLeft, required this.onClick}) : super(key: key);

  leftRadius() => Radius.circular(isLeft ? 4 : 0);

  rightRadius() => Radius.circular(isLeft ? 0 : 4);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: isSelected ? MyColors.themeColor : MyColors.white,
            border: Border.all(color: MyColors.themeColor),
            borderRadius: BorderRadius.only(
              bottomLeft: leftRadius(),
              topLeft: leftRadius(),
              topRight: rightRadius(),
              bottomRight: rightRadius(),
            )),
        child: Center(
            child: Text(
          title,
          style: isSelected ? MyStyles.white14Regular : MyStyles.white14Regular.copyWith(color: MyColors.themeColor),
        )),
      ),
    );
  }
}

class ActionTile extends StatelessWidget {
  final bool isDue;

  const ActionTile({Key? key, this.isDue = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        // height: 85,

        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isDue ? const Color(0xffF4D5D9) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isDue?const Color(0xffF4D5D9):MyColors.darkIconClr),
        ),
        child: Row(
          children: [
            Checkbox(value: !isDue, onChanged: (c) {}),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(isDue)
                const Text("Over Due",style: TextStyle(color:Color(0xffD50000),fontWeight: FontWeight.bold),),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: RichText(
                    text: TextSpan(
                      text: 'Your premium package is going to end. You have to',
                      style: DefaultTextStyle.of(context).style,
                      children: const <TextSpan>[
                        TextSpan(text: ' PAY €15', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ' before'),
                        TextSpan(text: ' 05 FEB. ', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Text("8m ago", style: TextStyle(color: Color(0xff71717A))),
                  ],
                ),
              ],
            ),
            const Icon(Icons.more_vert, color: Color(0xff71717A)),
          ],
        ),
      ),
    );
  }
}
