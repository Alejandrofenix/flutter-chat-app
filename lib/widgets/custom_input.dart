import 'package:chat/helpers/color_palets.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeHolder;
  final TextEditingController textController;
  final TextInputType keyworType;
  final bool isPassword;

  const CustomInput(
      {Key? key,
      required this.icon,
      required this.placeHolder,
      required this.textController,
      this.keyworType = TextInputType.text,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      decoration: BoxDecoration(
          color: colorPaletGris(),
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(.05),
                offset: Offset(0, 5),
                blurRadius: 5),
          ]),
      child: TextField(
          controller: this.textController,
          style: TextStyle(color: Colors.white),
          autocorrect: false,
          keyboardType: this.keyworType,
          obscureText: isPassword,
          decoration: InputDecoration(
            prefixIcon: Icon(
              this.icon,
              color: colorPaletMorado(),
            ),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: this.placeHolder,
            hintStyle: TextStyle(color: Colors.white60),
          )),
    );
  }
}
