import 'package:get/get.dart';

import '../../modules/home/views/home_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
    ),
  ];
}