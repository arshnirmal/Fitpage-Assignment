import 'dart:convert';

import 'package:fitpage_assignment/variable_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Items {
  int id;
  String name;
  String tag;
  String color;
  List<Criteria> criteria;

  Items.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        tag = json['tag'],
        color = json['color'],
        criteria = json['criteria'].map<Criteria>((json) => Criteria.fromJson(json)).toList();

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'tag': tag, 'color': color, 'criteria': criteria};
}

class Criteria {
  String type;
  String text;
  Map<String, dynamic>? variable;

  Criteria.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        text = json['text'],
        variable = json['variable'];

  Map<String, dynamic> toJson() => {'type': type, 'text': text, 'variable': variable};
}

List<TextSpan> getCriteria(Criteria criteria, BuildContext context) {
  String text = utf8.decode(criteria.text.runes.toList());
  if (criteria.type == 'plain_text') {
    return [TextSpan(text: text)];
  }
  if (criteria.type == 'variable') {
    Map<String, dynamic>? variable = criteria.variable;
    if (variable == null) return [TextSpan(text: text)];

    List<TextSpan> textSpans = [];
    RegExp variablePattern = RegExp(r'\$(\w+)');

    int currentIndex = 0;

    variablePattern.allMatches(text).forEach(
      (match) {
        String variableName = match.group(1)!;
        text.replaceFirst('\$$variableName', '($variableName)');

        debugPrint("Found variable: $variableName in text: $text");

        int startIndex = match.start;
        int endIndex = match.end;

        if (startIndex > currentIndex) {
          textSpans.add(
            TextSpan(
              text: text.substring(
                currentIndex,
                startIndex,
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
              ),
            ),
          );
        }

        if (criteria.variable!['\$$variableName']['type'] == 'value') {
          textSpans.add(
            TextSpan(
              text: '(${criteria.variable!['\$$variableName']['values'][0]})',
              style: const TextStyle(
                color: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VariablesPage(
                        variable: criteria.variable!['\$$variableName'],
                      ),
                    ),
                  );
                },
            ),
          );
        }
        if (criteria.variable!['\$$variableName']['type'] == 'indicator') {
          textSpans.add(
            TextSpan(
              text: '(${criteria.variable!['\$$variableName']['default_value']})',
              style: const TextStyle(
                color: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VariablesPage(
                        variable: criteria.variable!['\$$variableName'],
                      ),
                    ),
                  );
                },
            ),
          );
        }

        currentIndex = endIndex;
      },
    );

    if (currentIndex < text.length) {
      textSpans.add(
        TextSpan(
          text: text.substring(
            currentIndex,
          ),
        ),
      );
    }

    return textSpans;
  }
  return [const TextSpan(text: '')];
}
