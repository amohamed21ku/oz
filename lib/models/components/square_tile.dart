import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final VoidCallback ontap;
  const SquareTile({
    super.key,
    required this.imagePath, required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}
