import 'package:flutter/material.dart';

class fowardButton extends StatelessWidget {

  final Function() onTap;

  const fowardButton({
    super.key, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}