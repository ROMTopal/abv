import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skendy/src/constants/theme_constant.dart';
import 'package:skendy/src/custom_widgets/custom_app_bar.dart';
import 'package:skendy/src/custom_widgets/switch_card.dart';
import 'package:skendy/src/database_helper/database_helper.dart';
import 'package:skendy/src/database_helper/update_methods.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  bool normalSwitch = false;
  bool darkSwitch = false;
  bool systemSwitch = false;
  User? user = FirebaseAuth.instance.currentUser;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection(DatabaseHelper.collectionUserPreferences).doc(user!.uid).snapshots(),
          builder: (_, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(child: Text('Error'));
              } else if (snapshot.hasData) {
                return Column(
                  children: [
                    CustomAppBar(
                      title: MyStrings.theme,
                    ),
                    SwitchCard(
                      text: MyStrings.normal,
                      value: normalSwitch,
                      onTap: (bool s) {
                        setState(() {
                          normalSwitch = s;
                          print(normalSwitch);
                        });
                      },
                    ),
                    SwitchCard(
                      text: MyStrings.dark,
                      value: snapshot.data!.get(DatabaseHelper.fieldTheme) == ThemeConstant.darkTheme,
                      onTap: (value) async {
                        final provider = Provider.of<ThemeProvider>(context, listen: false);
                        provider.toggleTheme(value);

                        Map<String, dynamic> map = updateTheme(value);
                        await DatabaseHelper.updateUserPrefParticularValue(user!, map);
                      },
                    ),
                    SwitchCard(
                      text: MyStrings.system,
                      value: systemSwitch,
                      onTap: (bool s) {
                        setState(() {
                          systemSwitch = s;
                          print(systemSwitch);
                        });
                      },
                    ),
                  ],
                );
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ),
      ),
    );
  }
}
