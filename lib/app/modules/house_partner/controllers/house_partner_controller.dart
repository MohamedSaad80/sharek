import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sharek/app/data/remote_data_source/house_ads_apis.dart';
import 'package:sharek/core/widgets/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/remote_data_source/favorites_and_report_apis.dart';
import '../../../routes/app_pages.dart';

class HousePartnerController extends GetxController {
  ScrollController scrollController = ScrollController();

  int? housePartner;
  changeHousePartnerState(int? val) {
    housePartner = val;
    update();
  }

  TextEditingController filterNumberPartnersCtr = TextEditingController();
  TextEditingController filterNationalityPartnersCtr = TextEditingController();
  //===============================Comment==================================
  TextEditingController createCommentCtr = TextEditingController();
  bool isText = false;
  onChangedComment(String value) {
    if (value.trim().isNotEmpty) {
      createCommentCtr.text = value;
      isText = true;
    } else {
      isText = false;
    }
    createCommentCtr.value = createCommentCtr.value.copyWith(
      text: value,
      selection: TextSelection.fromPosition(
        TextPosition(offset: value.length),
      ),
    );
    update();
  }

  //========================================================================
  Future createComment({
    required int id,
    required String comment,
  }) async {
    try {
      BotToast.showLoading();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      final res =
          await HousePartnerAPI.createHouseComment(id: id, comment: comment);
      if (res?.status == true) {
        update();
        createCommentCtr.clear();
        BotToast.closeAllLoading();
        BotToast.showText(text: res?.message ?? "");
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: res?.message ?? "");
      }
    } catch (e) {
      BotToast.closeAllLoading();
      log(e.toString());
    }
  }

//==============================createTripAds=============================
  List<File>? createPhotos;
  GlobalKey<FormState> createFormKey = GlobalKey<FormState>();
  TextEditingController createPhoneCtr = TextEditingController();
  TextEditingController createNumberPartnersCtr = TextEditingController();
  TextEditingController createNationalityPartnersCtr = TextEditingController();
  TextEditingController createTitlePartnersCtr = TextEditingController();
  TextEditingController createDescriptionPartnersCtr = TextEditingController();

//========================================================================

//========================================================================

  void pickCreateHouseAdsImages() async {
    await ImagePickerDialog().pickGalleryImages(
      maxImage: 10,
      context: Get.context!,
      onGet: (value) {
        for (int i = 0; i < value.length; i++) {
          createPhotos = [...createPhotos ?? [], File(value[i].path ?? "")];
        }
      },
    );
    update();
  }

//========================================================================
  int addHousePartner = 10;
  changeAddHousePartnerState(int val) {
    addHousePartner = val;
    update();
  }

  clearCreateData() {
    addHousePartner = 10;
    createPhotos = null;
    createPhoneCtr.clear();
    createNumberPartnersCtr.clear();
    createNationalityPartnersCtr.clear();
    createTitlePartnersCtr.clear();
    createDescriptionPartnersCtr.clear();
    update();
  }
//========================================================================

  Future createHouseAds({
    required AnimationController animationController,
    int? servicesTypeid,
    String? location,
    int? numberPartners,
    String? neighborhood,
    String? nationality,
    String? description,
    String? title,
    String? phone,
    List<File>? photos,
  }) async {
    animationController.forward();
    try {
      final res = await HousePartnerAPI.createHouseAds(
        servicesTypeid: servicesTypeid,
        nationality: nationality,
        phone: phone,
        photos: photos,
        description: description,
        location: location,
        neighborhood: neighborhood,
        numberPartners: numberPartners,
        title: title,
      );
      if (res?.status == true) {
        animationController.reset();
        BotToast.showText(text: res?.message ?? "");
        Get.offAllNamed(Routes.BOTTOM_NAV_BAR);
        clearCreateData();
      } else {
        animationController.reset();
        BotToast.showText(text: res?.message ?? "");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //===============================report==================================
  TextEditingController reportCtr = TextEditingController();
  Future createReport({
    required int id,
    required String report,
    required AnimationController animationController,
  }) async {
    try {
      animationController.forward();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      final res = await FavoritesAndReportAPIS.createReport(
        type: Partners.housingAds,
        id: id,
        report: report,
      );
      if (res?.status == true) {
        animationController.forward();
        Future.delayed(1.milliseconds, () {
          animationController.reverse();
          Get.back();
        });
        reportCtr.clear();
        BotToast.showText(text: res?.message ?? "");
      } else {
        animationController.reset();
        BotToast.showText(text: res?.message ?? "");
      }
    } catch (e) {
      log(e.toString());
    }
  }

//========================================================================
  Future addToFavorites({
    required int id,
  }) async {
    try {
      BotToast.showLoading();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      final res = await FavoritesAndReportAPIS.addToFavorites(
        type: Partners.housingAds,
        id: id,
      );
      if (res?.status == true) {
        BotToast.closeAllLoading();
        BotToast.showText(text: res?.message ?? "");
        Get.forceAppUpdate();
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: res?.message ?? "");
      }
    } catch (e) {
      BotToast.closeAllLoading();
      log(e.toString());
    }
  }

  void makePhoneCall(String phone) async {
    var url = 'tel:$phone';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  String? textSearch;
  TextEditingController searchController = TextEditingController();
  onChangedSearch(String value) {
    if (value.trim().isNotEmpty) {
      searchController.text = value;
      textSearch = value;
    } else {
      textSearch = value;
    }
    searchController.value = searchController.value.copyWith(
      text: value,
      selection: TextSelection.fromPosition(
        TextPosition(offset: value.length),
      ),
    );
    update();
  }

  Future deleteAds({
    required int id,
  }) async {
    try {
      BotToast.showLoading();
      var res = await HousePartnerAPI.deleteHouseAdsById(id);
      if (res?.status == true) {
        BotToast.closeAllLoading();
        BotToast.showText(text: res?.message ?? "");
        Get.forceAppUpdate();
        Get.back();
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: res?.message ?? "");
      }
    } catch (e) {
      BotToast.closeAllLoading();
      log(e.toString());
    }
  }
}
