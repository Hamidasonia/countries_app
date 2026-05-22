import 'package:get/get.dart';

import '../../../data/entities/country_entity.dart';
import '../../../data/repositories/country_repository.dart';

class HomeController extends GetxController {
  final CountryRepository repository = CountryRepository();

  RxBool isLoading = false.obs;

  RxList<CountryEntity> countries = <CountryEntity>[].obs;

  @override
  void onInit() {
    getCountries();
    super.onInit();
  }

  Future<void> getCountries() async {
    try {
      isLoading.value = true;

      final result = await repository.getCountries();

      countries.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}