import 'package:fitpage_assignment/variable_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Variable Page testing',
    () {
      setUp(() async {
        // Add any setup code here if needed
      });

      testWidgets(
        'VariablesPage displays values correctly',
        (WidgetTester tester) async {
          final Map<String, dynamic> variable = {
            'type': 'value',
            'values': [1, 3, 2],
          };

          await tester.pumpWidget(
            MaterialApp(
              home: VariablesPage(variable: variable),
            ),
          );

          expect(find.text('1'), findsOneWidget);
          expect(find.text('2'), findsOneWidget);
          expect(find.text('3'), findsOneWidget);
        },
      );

      testWidgets(
        'VariablesPage displays indicator correctly',
        (WidgetTester tester) async {
          final Map<String, dynamic> variable = {
            'type': 'indicator',
            'study_type': 'Some Study',
            'parameter_name': 'someParameter',
            'default_value': 42,
            'min_value': 0,
            'max_value': 100,
          };

          await tester.pumpWidget(
            MaterialApp(
              home: VariablesPage(variable: variable),
            ),
          );

          expect(find.text('SOME STUDY'), findsOneWidget);
          expect(find.text('SomeParameter'), findsOneWidget);
        },
      );
    },
  );
}
