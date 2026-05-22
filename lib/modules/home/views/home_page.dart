import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.countries.isEmpty) {
            return const Center(
              child: Text('No countries found'),
            );
          }

          return RefreshIndicator(
            onRefresh: controller.getCountries,
            child: ListView.builder(
              itemCount: controller.countries.length,
              itemBuilder: (context, index) {
                final country = controller.countries[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    leading: country.flag.isNotEmpty
                        ? Image.network(
                            country.flag,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 50,
                                height: 50,
                                color: Colors.grey[300],
                                child: const Icon(Icons.flag),
                              );
                            },
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey[300],
                            child: const Icon(Icons.flag),
                          ),
                    title: Text(
                      country.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text('Capital: ${country.capital}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}