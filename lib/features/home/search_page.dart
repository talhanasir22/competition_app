import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stem_vault/Core/apptext.dart';

import '../../Core/appColors.dart';

class SearchPage extends StatefulWidget{
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
        title: Text("Find Courses",style: AppText.mainHeadingTextStyle(),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left:18.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.90,
          height: 40,
          child: TextField(
            style: TextStyle(fontSize: 14),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              hintText: "Find Course",
              hintStyle: AppText.hintTextStyle(),
              prefixIcon: Icon(Icons.search, color: AppColors.hintIconColor),
              filled: true,
              fillColor: AppColors.textFieldColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}