import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stem_vault/Core/apptext.dart';
import 'package:stem_vault/features/home/Account%20Screens/Edit%20Profile%20Screens/change_password.dart';

import 'change_user_name.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Widget _buildTextButton(String text, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: AppText.mainSubHeadingTextStyle().copyWith(fontSize: 16),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text("Update Your Profile", style: AppText.mainHeadingTextStyle().copyWith(fontSize: 20)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextButton("Change Password", () {
              Navigator.push(context,
              PageTransition(type: PageTransitionType.rightToLeft,
              child: ChangePassword()
              ));
            }),
            _buildTextButton("Change Username", () {
              Navigator.push(context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                      child: ChangeUserName(),
                  ));
            }),
          ],
        ),
      ),
    );
  }
}
