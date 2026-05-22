import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/services/session_service.dart';
import '../../../data/entities/country_entity.dart';
import '../../../data/repositories/country_repository.dart';

class HomeController extends GetxController {
  final CountryRepository repository = CountryRepository();

  RxBool isLoading = false.obs;

  RxList<CountryEntity> countries = <CountryEntity>[].obs;
  RxList<CountryEntity> filteredCountries = <CountryEntity>[].obs;
  RxString searchQuery = ''.obs;
  
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    getCountries();
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> getCountries() async {
    try {
      isLoading.value = true;

      final result = await repository.getCountries();

      countries.assignAll(result);
      filteredCountries.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void searchCountries(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredCountries.assignAll(countries);
    } else {
      final results = countries
          .where((country) =>
              country.name.toLowerCase().contains(query.toLowerCase()) ||
              country.capital.toLowerCase().contains(query.toLowerCase()))
          .toList();
      filteredCountries.assignAll(results);
    }
  }

  Future<void> logout() async {
    try {
      await SessionService.logout();
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar('Error', 'Gagal logout: ${e.toString()}');
    }
  }
}