import 'package:IntelliHome/constants/app_colors.dart';
import 'package:flutter/material.dart';

class editItem extends StatelessWidget {

  final Widget widget;
  final String title;

  const editItem({
    super.key, required this.widget, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: AppColor.grey
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          flex: 4,
          child: widget
        )
      ],
    );
  }
}