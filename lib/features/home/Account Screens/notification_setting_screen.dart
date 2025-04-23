import 'package:flutter/material.dart';
import 'package:stem_vault/Core/apptext.dart';
import 'package:stem_vault/Core/appColors.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() => _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  bool isNotificationsOn = true; // Toggle state

  void _showEditDialog(String title, String hint, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: AppText.mainHeadingTextStyle()),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle saving logic here
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.bgColor,
              ),
              child: Text("Submit", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
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
        title: Text("Notification Settings", style: AppText.mainHeadingTextStyle()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Notifications Toggle Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notifications",
                  style: AppText.mainSubHeadingTextStyle().copyWith(fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Switch(
                  value: isNotificationsOn,
                  onChanged: (value) {
                    setState(() {
                      isNotificationsOn = value;
                    });
                  },
                  activeColor: Colors.white,
                  inactiveTrackColor: Colors.transparent,
                  activeTrackColor: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
