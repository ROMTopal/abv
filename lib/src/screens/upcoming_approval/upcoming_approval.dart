import 'package:flutter/material.dart';
import 'package:skendy/src/screens/home/home.dart';
import 'package:skendy/src/screens/upcoming_approval/widgets/upcoming_pay_tile.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class UpcomingApproval extends StatefulWidget {
  const UpcomingApproval({Key? key}) : super(key: key);

  @override
  State<UpcomingApproval> createState() => _UpcomingApprovalState();
}

class _UpcomingApprovalState extends State<UpcomingApproval> {
  List<bool> payList = List.generate(3, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_back_outlined, color: MyColors.black),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
                    },
                    child: Container(
                      height: 36,
                      width: 95,
                      decoration: BoxDecoration(color: MyColors.themeColor, borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Text(MyStrings.approved, style: MyStyles.white14Regular)),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25),
              Text("Would you like to add it to your upcoming actions?", style: MyStyles.black20Normal.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              Column(
                children: List.generate(payList.length, (index) {
                  return UpcomingPayTile(
                    title: "Pay the internet bills €15",
                    date: "18 Feb 2023",
                    check: payList[index],
                    onTap: () {},
                    onChanged: (c) {
                      payList[index] = !payList[index];
                      setState(() {});
                    },
                  );
                }),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    primary: MyColors.themeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add, color: MyColors.white),
                        const SizedBox(width: 10),
                        Text("Add new action", style: MyStyles.black16Normal.copyWith(fontWeight: FontWeight.w600, color: MyColors.white)),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
