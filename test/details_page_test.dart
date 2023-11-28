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

      // testWidgets(
      //   'DetailsPage getCriteria() displays the correct text in RichText',
      //   (WidgetTester tester) async {
      //     await tester.pumpWidget(
      //       MaterialApp(
      //         home: DetailsPage(
      //           item: Items(
      //             id: 1,
      //             name: 'Top gainers',
      //             tag: 'Intraday Bullish',
      //             color: 'green',
      //             criteria: [
      //               Criteria(
      //                 type: 'plain_text',
      //                 text: 'Sort - %price change in descending order',
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     );

      //     expect(
      //       find.descendant(
      //         of: find.byType(ListView),
      //         matching: find.widgetWithText(
      //           RichText,
      //           'Sort - %price change in descending order',
      //         ),
      //       ),
      //       findsOneWidget,
      //     );
      //   },
      // );
    },
  );

  group(
    'getCriteria test',
    () {
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
            text: 'Today\'s open < yesterday\'s low by \$1 %',
            variable: {
              "\$1": {
                "type": "value",
                "values": [-3, -1, -2, -5, -10]
              }
            },
          );

          final result = getCriteria(criteria, MockBuildContext());

          expect(
            result,
            [
              TextSpan(
                text: 'Today\'s open < yesterday\'s low by ',
                style: Theme.of(MockBuildContext as BuildContext).textTheme.bodyMedium,
              ),
              TextSpan(
                text: '(-3)',
                style: Theme.of(MockBuildContext as BuildContext).textTheme.bodyMedium!.merge(
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
                style: Theme.of(MockBuildContext as BuildContext).textTheme.bodyMedium,
              ),
            ],
          );
        },
      );
    },
  );
}

class MockBuildContext extends Mock implements BuildContext {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
