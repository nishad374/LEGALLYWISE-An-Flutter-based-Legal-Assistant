import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SquareTile extends StatelessWidget {
  final Function()? onTap;
  final Color color;
  final String assets_path;

  const SquareTile(
      {super.key,
      required this.onTap,
      required this.color,
      required this.assets_path});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 100,
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color)),
        child: SvgPicture.asset(assets_path, height: 50, width: 50),
      ),
    );
  }
}
