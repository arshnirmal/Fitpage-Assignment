import 'package:fitpage_assignment/data_model.dart';
import 'package:fitpage_assignment/details_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group(
    'DetailsPage Widget testing',
    () {
      testWidgets(
        'DetailsPage has a title and a back button',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: DetailsPage(
                item: Items(
                  id: 1,
                  name: 'Top gainers',
                  tag: 'Intraday Bullish',
                  color: 'green',
                  criteria: [
                    Criteria(
                      type: 'plain_text',
                      text: 'Sort - %price change in descending order',
                    ),
                  ],
                ),
              ),
            ),
          );

          expect(find.widgetWithText(AppBar, 'Top gainers'), findsOneWidget);
          expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
        },
      );
    },
  );

  group(
    'getCriteria test',
    () {
      Matcher equalsIgnoreDebugLabel(TextSpan expected) {
        return predicate(
          (TextSpan actual) {
            return actual.text == expected.text && actual.style == expected.style;
          },
          'TextSpan matches (ignoring debugLabel)',
        );
      }

      test(
        'getCriteria handles plain_text correctly',
        () {
          final criteria = Criteria(type: 'plain_text', text: 'Sort - %price change in descending order');
          final result = getCriteria(criteria, MockBuildContext());

          expect(result, [const TextSpan(text: 'Sort - %price change in descending order')]);
        },
      );

      test(
        'getCriteria handles variable correctly',
        () {
          final criteria = Criteria(
            type: 'variable',
            text: 'Max of last 5 days close > Max of last 120 days close by \$1 %',
            variable: {
              "\$1": {
                "type": "value",
                "values": [2, 1, 3, 5]
              }
            },
          );

          final result = getCriteria(criteria, MockBuildContext());

          expect(
            result,
            [
              TextSpan(
                text: 'Max of last 5 days close > Max of last 120 days close by ',
                style: Theme.of(MockBuildContext()).textTheme.bodyMedium,
              ),
              TextSpan(
                text: '(2)',
                style: Theme.of(MockBuildContext()).textTheme.bodyMedium!.merge(
                      const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                      ),
                    ),
                recognizer: TapGestureRecognizer(),
              ),
              TextSpan(
                text: ' %',
                style: Theme.of(MockBuildContext()).textTheme.bodyMedium,
              ),
            ].map(equalsIgnoreDebugLabel),
          );
        },
      );

      test(
        'getCriteria handles indicator correctly',
        () {
          final criteria = Criteria(
            type: 'variable',
            text: 'RSI \$4 > 20',
            variable: {
              "\$4": {
                "type": "indicator",
                "study_type": "rsi",
                "parameter_name": "period",
                "min_value": 1,
                "max_value": 99,
                "default_value": 14,
              }
            },
          );

          final result = getCriteria(criteria, MockBuildContext());

          expect(
            result,
            [
              TextSpan(
                text: 'RSI ',
                style: Theme.of(MockBuildContext()).textTheme.bodyMedium,
              ),
              TextSpan(
                text: '(14)',
                style: Theme.of(MockBuildContext()).textTheme.bodyMedium!.merge(
                      const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                      ),
                    ),
                recognizer: TapGestureRecognizer(),
              ),
              TextSpan(
                text: ' > 20',
                style: Theme.of(MockBuildContext()).textTheme.bodyMedium,
              ),
            ].map(equalsIgnoreDebugLabel),
          );
        },
      );
    },
  );
}

class MockBuildContext extends Mock implements BuildContext {}
