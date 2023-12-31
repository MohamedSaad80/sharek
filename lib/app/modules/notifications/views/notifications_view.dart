import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/constants/theme/theme_export.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../data/models/notifications_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'التنبيهات',
          style: StylesManager.semiBold(
            color: ColorsManager.black,
            fontSize: FontSize.xlarge,
          ),
        ),
        centerTitle: false,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return controller.refreshNotifications();
        },
        child: FutureBuilder<NotificationsModel?>(
          future: controller.notifications,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final notification = snapshot.data?.data?.reversed.toList() ?? [];
              if (notification.isEmpty) {
                return Center(
                  child: Text(
                    "لا توجد اشعارات",
                    style: StylesManager.medium(fontSize: FontSize.xXlarge),
                  ),
                );
              }
              return ListView.builder(
                itemCount: notification.length,
                itemBuilder: (context, index) {
                  var item = notification[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(
                        thickness: 1,
                        height: 1,
                      ),
                      ListTile(
                        onTap: () {
                          Get.toNamed(
                            Routes.ANOTHER_USER_PROFILE,
                            arguments: {
                              "userId": Random().nextInt(10) + 1,
                            },
                          );
                        },
                        tileColor: (item.isRead == 1)
                            ? ColorsManager.white
                            : const Color(0xFFF4F4FF),
                        trailing: Text(
                          timeago
                              .format(
                                  DateTime.tryParse(
                                        item.createdAt ?? "",
                                      ) ??
                                      DateTime.now(),
                                  locale: "ar")
                              .toString(),
                          style: StylesManager.light(),
                        ),
                        subtitle: Text(
                          item.content ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            color: ColorsManager.veryDarkGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        title: Text(
                          item.title ?? "",
                          style: StylesManager.bold(
                            fontSize: FontSize.large,
                            color: ColorsManager.charcoal,
                          ),
                        ),
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: AppCachedNetworkImage(
                              imageUrl: item.avatar ?? "",
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(ColorsManager.primary),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
