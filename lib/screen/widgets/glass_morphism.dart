import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:IntelliHome/constants/app_colors.dart';

class GlassMorphism extends StatelessWidget {
  const GlassMorphism({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10, sigmaY: 10
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.fgColor.withOpacity(0.9),
                AppColor.black.withOpacity(0.5),
                AppColor.fgColor.withOpacity(0.5)
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))
          ),
          child: child,
        ),
      ),
    );
  }
}