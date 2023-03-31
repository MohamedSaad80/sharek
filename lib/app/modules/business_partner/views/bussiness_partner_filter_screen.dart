import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sharek/core/constants/theme/colors_manager.dart';

import '../../../../core/widgets/app_text.dart';
import '../controllers/business_partner_controller.dart';
import 'business_partner_view.dart';

class BussinessPartnerFilterScreen extends GetView<BusinessPartnerController> {
  const BussinessPartnerFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تصفية'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const FiltersList(),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFE4E4E5),
                ),
              ),
              width: double.infinity,
              child: const ExpansionTile(
                leading: Icon(Iconsax.location),
                title: AppText(
                  "المنطقة",
                  fontSize: 16,
                  color: ColorsManager.black,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFE4E4E5),
                ),
              ),
              width: double.infinity,
              child: const ExpansionTile(
                leading: Icon(Iconsax.buliding),
                title: AppText(
                  "الحي",
                  fontSize: 16,
                  color: ColorsManager.black,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFE4E4E5),
                ),
              ),
              width: double.infinity,
              child: const ExpansionTile(
                leading: Icon(Iconsax.happyemoji),
                title: AppText(
                  "النوع",
                  fontSize: 16,
                  color: ColorsManager.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
