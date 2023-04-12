// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sharek/core/extensions/export.dart';

import '../../../../core/constants/theme/font_manager.dart';
import '../../../../core/constants/theme/sizes_manager.dart';
import '../../../../core/widgets/app_text.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    Key? key,
    this.onTap,
    required this.title,
    this.isLast = false,
    this.trailing,
  }) : super(key: key);
  final Function()? onTap;
  final String title;
  final bool? isLast;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          trailing: trailing ??
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF7D848D),
              ),
          title: AppText(
            title,
            fontSize: Sizes.size16.h(context),
            fontWeight: FontWeights.regular,
            color: const Color(0xFF212121),
          ),
        ),
        isLast == true
            ? const SizedBox()
            : const Divider(color: Color(0xFFF7F7F9)),
      ],
    );
  }
}