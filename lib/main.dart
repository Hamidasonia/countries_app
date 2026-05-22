import 'package:flutter/material.dart';
import 'data/repositories/country_repository.dart';
import 'data/models/country_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countries App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CountriesPage(),
    );
  }
}

class CountriesPage extends StatefulWidget {
  const CountriesPage({super.key});

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  late Future<List<CountryModel>> _countries;
  final CountryRepository _repository = CountryRepository();

  @override
  void initState() {
    super.initState();
    _countries = _repository.getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<CountryModel>>(
        future: _countries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No countries found'));
          }

          final countries = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: countries.length,
            itemBuilder: (context, index) {
              final country = countries[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: country.flag.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(country.flag),
                              fit: BoxFit.cover,
                              onError: (_, __) {},
                            )
                          : null,
                    ),
                    child: country.flag.isEmpty
                        ? const Center(child: Icon(Icons.flag))
                        : null,
                  ),
                  title: Text(country.name),
                  subtitle: Text('Capital: ${country.capital}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}