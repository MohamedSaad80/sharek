import 'package:sharek/core/global/const.dart';
import 'package:sharek/core/services/network_service.dart/dio_network_service.dart';

import '../models/home_model.dart';

class HomeAPI {
  static Future<HomeModel?> getHome() async {
    const request = NetworkRequest(
      type: NetworkRequestType.GET,
      path: APIKeys.home,
      data: NetworkRequestBody.empty(),
    );
    final response = await networkService.execute(
        request, (json) => HomeModel.fromJson(json));
    final data = response.maybeWhen(
      ok: (data) {
        return data;
      },
      orElse: () {},
    );
    return data;
  }
}