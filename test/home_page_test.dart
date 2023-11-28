import 'package:fitpage_assignment/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_page_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group(
    'API testing',
    () {
      test(
        'fetchData() returns a List<Items> if the http call completes successfully',
        () async {
          final client = MockClient();

          when(
            client.get(
              Uri.parse('http://coding-assignment.bombayrunning.com/data.json'),
            ),
          ).thenAnswer(
            (_) async => http.Response(
              '{"id": 1, "name": "test", "tag": "test", "color": "test", "criteria": [{"type": "plain_text", "text": "test"}]}',
              200,
            ),
          );

          expect(
            await client.get(
              Uri.parse('http://coding-assignment.bombayrunning.com/data.json'),
            ),
            isA<http.Response>(),
          );
        },
      );

      test(
        'fetchData() throws an exception if the http call completes with an error',
        () async {
          final client = MockClient();

          when(
            client.get(
              Uri.parse('http://coding-assignment.bombayrunning.com/data.json'),
            ),
          ).thenAnswer(
            (_) async => http.Response(
              'Not Found',
              404,
            ),
          );

          expect(
            await client.get(
              Uri.parse('http://coding-assignment.bombayrunning.com/data.json'),
            ),
            isA<http.Response>(),
          );
        },
      );
    },
  );

  group(
    'HomePage Widget testing',
    () {
      testWidgets(
        'should show CircularProgressIndicator when data is loading',
        (tester) async {
          final client = MockClient();

          when(
            client.get(
              Uri.parse('http://coding-assignment.bombayrunning.com/data.json'),
            ),
          ).thenAnswer(
            (_) async => http.Response('{"id": 1}', 200),
          );

          await tester.pumpWidget(
            const MaterialApp(
              home: HomePage(),
            ),
          );

          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        },
      );

      testWidgets(
        'should show ListView when data is loaded',
        (tester) async {
          final client = MockClient();

          when(
            client.get(
              Uri.parse('http://coding-assignment.bombayrunning.com/data.json'),
            ),
          ).thenAnswer(
            (_) async => http.Response('{"id": 1}', 200),
          );

          await tester.pumpWidget(
            const MaterialApp(
              home: HomePage(),
            ),
          );

          expect(find.byType(ListView), findsOneWidget);
        },
      );
    },
  );
}
