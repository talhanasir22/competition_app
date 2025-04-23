import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallActionButton extends StatelessWidget{
  const SmallActionButton({super.key, required this.btnName, required this.btnIcon});

  final String btnName;
  final IconData btnIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 61,
      height: 24,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6)
      )
      ,
      child: Row(
        children: [
          Text(btnName,style: TextStyle(color: Colors.black),),
          Spacer(),
          Icon(btnIcon,color: Colors.black,size: 18,)
        ],
      ),
    );
  }

}