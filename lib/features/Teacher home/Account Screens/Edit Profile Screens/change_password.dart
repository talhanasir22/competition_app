import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Core/appColors.dart';
import '../../../../Core/apptext.dart';
import '../../../../Shared/LoadingIndicator.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.theme,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios))
      ),
      backgroundColor: AppColors.theme,
      body: SingleChildScrollView( // Prevents overflow issues
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text("Change\nPassword?", style: AppText.authHeadingStyle()),
            ),
            SizedBox(height: 20),

            // Wrap TextFormField inside Form
            Form(
              key: _formKey,
              child: Center(
                child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.87,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.textFieldColor,
                      prefixIcon: Icon(Icons.email, color: AppColors.hintIconColor),
                      hintText: "Enter a new password",
                      hintStyle: AppText.hintTextStyle(),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) => (value == null || value.isEmpty) ? 'Please enter your email' : null,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.87,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "* ",
                          style: AppText.hintTextStyle().copyWith(color: AppColors.bgColor),
                        ),
                        TextSpan(
                          text: "Password must be 8 digits long",
                          style: AppText.hintTextStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.87,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.black,
                  ),
                  child: _isLoading ? LoadingIndicator() : Text("Submit", style: AppText.buttonTextStyle()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
