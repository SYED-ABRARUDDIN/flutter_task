import 'package:flutter/material.dart';
import 'package:newstask/models/constants/colors.dart';
import 'package:newstask/models/constants/myfonts.dart';

class CustomAlert extends StatelessWidget {
 final String title;
  final Color color;
  final String header;
  CustomAlert(this.title, this.color, this.header);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      child: Center(
          child: AlertDialog(
            content: SizedBox(
          
          child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$header",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: AppColors.black,
                      fontFamily: AppFonts.regular),
                ),
                Text("$title",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: color,
                        fontFamily: AppFonts.regular)),
                GestureDetector(
                    child: Container(
                      height: 25,
                      width: 70,
                      //color: Colors.blueAccent,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(color: AppColors.bluecolor),
                        borderRadius: BorderRadius.all(Radius.circular(
                                15) //                 <--- border radius here
                            ),
                      ),
                      child: Center(
                        child: Text("Ok",
                            style: TextStyle(
                                fontFamily: AppFonts.regular, color: Colors.white)),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context, false);
                    }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
