import 'package:fitpage_assignment/variable_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Variable Page testing',
    () {
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
          await tester.pumpWidget(
            const MaterialApp(
              home: VariablesPage(
                variable: {
                  'type': 'indicator',
                  'study_type': 'rsi',
                  'parameter_name': 'period',
                  'default_value': 14,
                  'min_value': 1,
                  'max_value': 99,
                },
              ),
            ),
          );

          expect(find.text('RSI'), findsOneWidget);
          expect(find.text('Period'), findsOneWidget);
        },
      );

      testWidgets(
        'Test TextFormField Widget',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: VariablesPage(
                  variable: {
                    'type': 'indicator',
                    'study_type': 'rsi',
                    'parameter_name': 'period',
                    'default_value': 14,
                    'min_value': 1,
                    'max_value': 99,
                  },
                ),
              ),
            ),
          );

          expect(find.byType(TextFormField), findsOneWidget);
          expect(find.text('14'), findsOneWidget);
          await tester.enterText(find.byType(TextFormField), '57');
          await tester.pump();
          expect(find.text('57'), findsOneWidget);
        },
      );
    },
  );
}
