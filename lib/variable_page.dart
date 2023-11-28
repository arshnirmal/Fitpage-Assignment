import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

class VariablesPage extends StatelessWidget {
  final Map<String, dynamic> variable;
  const VariablesPage({super.key, required this.variable});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(15, 76, 117, 1),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          color: const Color.fromRGBO(27, 38, 44, 1),
          child:ListView.separated(
            shrinkWrap: true,
            itemCount: variable['values'].length,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            separatorBuilder: (context, index) => Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: DottedDecoration(
                shape: Shape.line,
                linePosition: LinePosition.bottom,
                color: Colors.white,
              ),
            ),
            itemBuilder: (context, index) {
              final List<int> values = variable['values'].cast<int>();
              values.sort((a, b) => b.compareTo(a));

              debugPrint("Values: $values");
              return Text(
                '${values[index]}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
