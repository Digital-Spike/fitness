import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ProfileButton extends StatelessWidget {
  final IconData icon;
  final SvgAssetLoader Svg;
  final String text;
  final String subtext;
  const ProfileButton({super.key,required this.icon,required this.Svg, required this.text, required this.subtext});

 

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      subtitle: Text(subtext),
      trailing: SvgPicture.asset(Svg as String),
    );
  }
}