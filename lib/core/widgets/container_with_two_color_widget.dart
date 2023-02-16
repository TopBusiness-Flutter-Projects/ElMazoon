import 'package:flutter/material.dart';

class ContainerWithTwoColorWidget extends StatelessWidget {
  const ContainerWithTwoColorWidget({Key? key, required this.imagePath, required this.title, required this.color1, required this.color2, required this.textColor}) : super(key: key);

  final String imagePath;
  final String title;
  final Color color1;
  final Color color2;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              color1,
              color2,
            ],
          )),
      child: Column(
        children: [
          const Spacer(),
          Image.asset(imagePath),
          const Spacer(),
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
