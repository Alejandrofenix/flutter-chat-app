import 'package:chat/helpers/color_palets.dart';
import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;

  final VoidCallback?
      onPressed; //En elevationbutton se utiliza VoidCall en lugar de Function

  const BotonAzul({Key? key, required this.text, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shadowColor: colorPaletMorado(),
          primary: colorPaletMorado(),
          onSurface: Colors.blue,
          shape: StadiumBorder(),
        ),
        onPressed: this.onPressed,
        child: Container(
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text(
              this.text,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ));
  }
}
