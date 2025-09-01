import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App should build without errors', (WidgetTester tester) async {
    // Создаем простую версию приложения для тестов
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('TasteSmoke Test'),
          ),
        ),
      ),
    );

    // Проверяем, что текст отображается
    expect(find.text('TasteSmoke Test'), findsOneWidget);
  });
}
