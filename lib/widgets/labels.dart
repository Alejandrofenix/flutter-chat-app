import 'package:chat/helpers/color_palets.dart';
import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String text;
  final String textPregunta;
  const Labels(
      {Key? key,
      required this.ruta,
      required this.text,
      required this.textPregunta})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            this.textPregunta,
            style: TextStyle(
                color: Colors.white60,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Text(
              this.text,
              style: TextStyle(
                  color: colorPaletMorado(),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, this.ruta);
            },
          )
        ],
      ),
    );
  }
}
