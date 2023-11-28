import 'dart:convert';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:fitpage_assignment/data_model.dart';
import 'package:fitpage_assignment/details_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(15, 76, 117, 1),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        primaryColor: const Color.fromRGBO(27, 38, 44, 1),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
          titleSmall: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto',
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto',
          ),
          bodySmall: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Items> items = [];
  bool isDataLoading = false;

  getData() async {
    setState(() {
      isDataLoading = true;
    });
    final response = await http.get(Uri.parse('http://coding-assignment.bombayrunning.com/data.json'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        items.addAll(data.map<Items>((json) => Items.fromJson(json)).toList());
        isDataLoading = false;
      });
    }
    debugPrint(response.body);
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
        ),
      ),
      body: isDataLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                color: Theme.of(context).primaryColor,
                child: ListView.separated(
                  itemCount: items.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: DottedDecoration(
                      shape: Shape.line,
                      linePosition: LinePosition.bottom,
                      color: Colors.white,
                    ),
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                              item: item,
                            ),
                          ),
                        );
                      },
                      title: Text(
                        item.name,
                        style: Theme.of(context).textTheme.titleMedium!.merge(
                              const TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              ),
                            ),
                      ),
                      subtitle: Text(
                        item.tag,
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              TextStyle(
                                color: item.color == 'red'
                                    ? const Color.fromRGBO(255, 0, 0, 1)
                                    : item.color == 'green'
                                        ? const Color.fromRGBO(0, 255, 0, 1)
                                        : const Color.fromRGBO(0, 0, 255, 1),
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              ),
                            ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
