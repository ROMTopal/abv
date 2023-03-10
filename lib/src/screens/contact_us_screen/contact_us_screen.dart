import 'package:flutter/material.dart';
import 'package:skendy/src/custom_widgets/custom_app_bar.dart';
import 'package:skendy/src/utils/my_colors.dart';
import 'package:skendy/src/utils/my_strings.dart';
import 'package:skendy/src/utils/my_style.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomAppBar(
              title: MyStrings.contactUs,
            ),
            Text(
              """Lorem ipsum dolor sit amet consectetur adi pisicing elit. Maxime mollitia, mole stiae quas vel sint commodi repudiandae conse quuntur voluptatum laborum numquam blan ditiis harum quisquam eius sed odit fug iat iusto fug a praesentium optio, eaque rerum!

Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat""",
              style: MyStyles.gray16Light,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              """Commodi minima excepturi repudiandae velit hic maxime dolore mque. Quaerat pro vident commodi consectetur veniam similique ad earum omnis ipsum saepe.

voluptas, hic voluptates pariatur est explicabo fugiat, dolorum eligendi quam cupiditate excepturi mollitia maiores labore suscipit quas?""",
              style: MyStyles.gray16Light,
            )
          ],
        ),
      ),
    );
  }
}
