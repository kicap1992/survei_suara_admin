import 'package:flutter/material.dart';

import '../../app/themes/app_colors.dart';

class TopContainer extends StatelessWidget {
  const TopContainer({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.background,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(
                color: fontGrey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(
              ':',
              style: TextStyle(
                color: fontGrey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(
                color: fontGrey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Icon(
            icon,
            color: fontGrey,
          ),
        ],
      ),
    );
  }
}
