import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrainerButton extends StatelessWidget {
  final String title;
 final Color leadingColor;
  final String imageAsset;
  final IconData trailingIcon;
  final VoidCallback onPressed;

  TrainerButton({
    required this.title,
  required this.imageAsset,
    required this.leadingColor,
    required this.trailingIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: Colors.blueGrey[100], // Customize button color
          padding: EdgeInsets.only(right: 5,top: 5,bottom: 5),
        ),
        child: Row(
         
          
          children: [
          Container(
            height: 40,width: 5,color: leadingColor,
          ),SizedBox(width: 20,),
          Image.asset(imageAsset,height: 30,width: 30,),
             SizedBox(width: 30),
            Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Spacer(),
            Icon(
              trailingIcon,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
