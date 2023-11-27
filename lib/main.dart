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
      ),
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

  getData() async{
    final response = await http.get(Uri.parse('http://coding-assignment.bombayrunning.com/data.json'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: const Color.fromRGBO(15, 76, 117, 1),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        color: const Color.fromRGBO(27, 38, 44, 1),
        
      ),
    );
  }
}
