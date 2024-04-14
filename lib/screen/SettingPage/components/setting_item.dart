import 'package:IntelliHome/constants/app_colors.dart';
import 'package:IntelliHome/screen/SettingPage/components/forward_button.dart';
import 'package:flutter/material.dart';

class settingItem extends StatelessWidget {

  final String title;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final Function() onTap;
  final String? value;

  const settingItem({
    super.key,
    required this.title,
    required this.iconColor,
    required this.icon,
    required this.onTap,
    this.value,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor
            ),
            child: Icon(
              icon,
              color: iconColor
            ),
          ),
          SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
          Spacer(),
          value != null
              ? Text(
                  value!,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.grey
                  ),
                )
              : SizedBox(),
          SizedBox(width: 10),
          fowardButton(
            onTap: onTap,
          )
        ],
      ),
    );
  }
}