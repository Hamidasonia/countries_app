import 'package:dio/dio.dart';

import '../../core/constants/api_constant.dart';
import '../../core/services/dio_client.dart';
import '../models/country_model.dart';

class CountryRepository {
  final Dio dio = DioClient.dio;

  Future<List<CountryModel>> getCountries() async {
    try {
      final Response response = await dio.get(
        ApiConstant.countriesUrl,
      );

      return (response.data as List)
          .map((e) => CountryModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}