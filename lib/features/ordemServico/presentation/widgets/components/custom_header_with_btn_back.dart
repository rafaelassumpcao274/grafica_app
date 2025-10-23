import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../core/theme.dart';

class CustomHeaderWithBtnBack extends StatelessWidget {

  final String text;

  const CustomHeaderWithBtnBack({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.arrow_back, color: AppColors.textDark, size: 22),
            ),
          ),
          SizedBox(width: 16),
          Text(
            text,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
