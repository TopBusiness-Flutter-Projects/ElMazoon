import 'package:flutter/material.dart';

class ContainerTextWithTwoColorWidget extends StatelessWidget {
  const ContainerTextWithTwoColorWidget({Key? key, required this.title, required this.color1, required this.color2, required this.textColor, required this.degree}) : super(key: key);


  final String title;
  final String degree;
  final Color color1;
  final Color color2;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                color1,
                color2,
              ],
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [

              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: Text(
                    maxLines: 1,
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Text(
                degree,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
