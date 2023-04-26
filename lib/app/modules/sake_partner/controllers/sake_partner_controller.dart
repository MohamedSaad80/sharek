import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/service_type.dart';
import '../../../data/remote_data_source/serifice_apis.dart';
import '../../../routes/app_pages.dart';

class SakePartnerController extends GetxController {
  ScrollController scrollController = ScrollController();

  //====================================================================
  int? sacrificePartner;
  changeSacrificePartnerState(int val) {
    sacrificePartner = val;
    update();
  }

  String? titleSearch;
  TextEditingController searchController = TextEditingController();
  onChangedSearch(String value) {
    if (value.trim().isNotEmpty) {
      searchController.text = value;
      titleSearch = value;
    } else {
      titleSearch = value;
    }
    searchController.value = searchController.value.copyWith(
      text: value,
      selection: TextSelection.fromPosition(
        TextPosition(offset: value.length),
      ),
    );
    update();
  }

//======================================================================
  List<ServiceTypeModel> sacrificeType = [
    ServiceTypeModel(name: "حاشي", serviceTypeId: 1),
    ServiceTypeModel(name: "خروف", serviceTypeId: 2),
    ServiceTypeModel(name: "عجل", serviceTypeId: 3),
    ServiceTypeModel(name: "تيس", serviceTypeId: 4),
  ];
  ServiceTypeModel? sacrificeTypeItem;
  changeSacrificeTypeState(ServiceTypeModel val) {
    sacrificeTypeItem = val;
    update();
  }

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
          await SarificeAPIS.createSerificeComment(id: id, comment: comment);
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

  //========================================================================
  clearSakeQuantityData() {
    sacrificeReservation = null;
    sacrificeReservationId = null;
  }

  String? sacrificeReservation;
  int? sacrificeReservationId;
  changesacrificeReservationState(String val, int id) {
    sacrificeReservation = val;
    sacrificeReservationId = id;
    update();
  }

  Future createSacrificeReservation({
    required AnimationController animationController,
    required int id,
    required String quantity,
  }) async {
    animationController.forward();
    try {
      final res =
          await SarificeAPIS.sacrificeReservation(id: id, quantity: quantity);
      if (res?.status == true) {
        animationController.reset();
        BotToast.showText(text: res?.message ?? "");
      } else {
        animationController.reset();
        BotToast.showText(text: res?.message ?? "");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //===============================================================
  List<File>? createPhotos;
  GlobalKey<FormState> createFormKey = GlobalKey<FormState>();
  TextEditingController createPhoneCtr = TextEditingController();
  TextEditingController createTitlePartnersCtr = TextEditingController();
  TextEditingController createDescriptionPartnersCtr = TextEditingController();

//========================================================================
  void pickCreateAdsImages() async {
    List<XFile> pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages.isEmpty) return;
    createPhotos = pickedImages.map((e) => File(e.path)).toList();
    update();
  }

//========================================================================

  clearCreateData() {
    createPhotos = null;
    createPhoneCtr.clear();
    createTitlePartnersCtr.clear();
    createDescriptionPartnersCtr.clear();
    createSacrificePartner = 8;
    createSacrificeTypeItem = ServiceTypeModel(
      name: "حاشي",
      serviceTypeId: 1,
    );
    update();
  }

  int createSacrificePartner = 8;
  changeCreateSacrificePartnerState(int val) {
    createSacrificePartner = val;
    update();
  }

  ServiceTypeModel createSacrificeTypeItem = ServiceTypeModel(
    name: "حاشي",
    serviceTypeId: 1,
  );

  changeCreateSacrificeTypeState(ServiceTypeModel val) {
    createSacrificeTypeItem = val;
    update();
  }

  int quarter = 0;
  int third = 0;
  int half = 0;
  int eighth = 0;
  TextEditingController createQuarterPriceCtr = TextEditingController();
  TextEditingController createThirdPriceCtr = TextEditingController();
  TextEditingController createHalfPriceCtr = TextEditingController();
  TextEditingController createEighthPriceCtr = TextEditingController();
  void icreaseQuarter() {
    quarter++;
    update();
  }

  void dereaseQuarter() {
    if (quarter == 0) {
      quarter = 0;
    } else {
      quarter--;
    }
    update();
  }

  void icreaseThird() {
    third++;
    update();
  }

  void dereaseThird() {
    if (third == 0) {
      third = 0;
    } else {
      third--;
    }
    update();
  }

  void icreaseHalf() {
    half++;
    update();
  }

  void dereaseHalf() {
    if (half == 0) {
      half = 0;
    } else {
      half--;
    }
    update();
  }

  void icreaseEighth() {
    eighth++;
    update();
  }

  void dereaseEighth() {
    if (eighth == 0) {
      eighth = 0;
    } else {
      eighth--;
    }
    update();
  }

  //========================================================================
  Future createSakeAds({
    required AnimationController animationController,
    int? servicesTypeid,
    String? location,
    String? neighborhood,
    String? description,
    String? title,
    String? phone,
    String? sacrificeType,
    List<File>? photos,
    int? eighthPrice,
    int? eighthQuantity,
    int? thirdPrice,
    int? thirdQuantity,
    int? quarterPrice,
    int? quarterQuantity,
    int? halfPrice,
    int? halfQuantity,
  }) async {
    animationController.forward();
    try {
      final res = await SarificeAPIS.createSerificeAds(
        servicesTypeid: servicesTypeid,
        phone: phone,
        photos: photos,
        description: description,
        location: location,
        neighborhood: neighborhood,
        title: title,
        eighthPrice: eighthPrice,
        eighthQuantity: eighthQuantity,
        halfPrice: halfPrice,
        halfQuantity: halfQuantity,
        quarterPrice: quarterPrice,
        quarterQuantity: quarterQuantity,
        sacrificeType: sacrificeType,
        thirdPrice: thirdPrice,
        thirdQuantity: thirdQuantity,
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

  //=================================Filter==============================
  ServiceTypeModel? filterQuantityItem;
  List<ServiceTypeModel> filterQuantityType = [
    ServiceTypeModel(name: "ثمن", serviceTypeId: 1),
    ServiceTypeModel(name: "ربع", serviceTypeId: 2),
    ServiceTypeModel(name: "ثلث", serviceTypeId: 3),
    ServiceTypeModel(name: "نصف", serviceTypeId: 4),
  ];
  changefilterQuantityTypeState(ServiceTypeModel val) {
    filterQuantityItem = val;
    update();
  }

  //======================================================================
  List<ServiceTypeModel> filterSacrificeType = [
    ServiceTypeModel(name: "حاشي", serviceTypeId: 1),
    ServiceTypeModel(name: "خروف", serviceTypeId: 2),
    ServiceTypeModel(name: "عجل", serviceTypeId: 3),
    ServiceTypeModel(name: "تيس", serviceTypeId: 4),
  ];
  ServiceTypeModel? filterSacrificeTypeItem;
  changeFilterSacrificeTypeState(ServiceTypeModel val) {
    filterSacrificeTypeItem = val;
    update();
  }

  int filterSacrificePartner = 8;
  changeFilterSacrificePartnerState(int val) {
    filterSacrificePartner = val;
    update();
  }

  clearFilterData() {
    filterSacrificePartner = 8;
    filterSacrificeTypeItem = null;
    filterQuantityItem = null;
    update();
  }
  //====================================================================
}
