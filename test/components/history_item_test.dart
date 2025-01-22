import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:poc/components/history_item.dart';
import 'package:poc/model/history_model.dart';
import 'package:poc/model/pet_model.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  colorScheme: ColorScheme.light(
    primary: Colors.grey.shade300,
    secondary: Colors.grey.shade200,
    surface: Colors.grey.shade900,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey[900],
  colorScheme: ColorScheme.dark(
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    surface: Colors.grey.shade100,
  ),
);

class MockHistoryItemModel extends Mock implements HistoryItemModel {}

void main() {
  testWidgets('HistoryItem matches golden file in light mode',
      (WidgetTester tester) async {
    // Mock the HistoryItemModel
    final mockHistoryItemModel = MockHistoryItemModel();
    when(() => mockHistoryItemModel.petModel).thenReturn(
      PetModel(
        image: 'https://example.com/test-image.png',
        name: 'Buddy',
        price: 9.99, age: 23, isAvailable: true,
      ),
    );

    // Mock network image loading
    await mockNetworkImagesFor(() async {
      // Build the widget with light mode
      await tester.pumpWidget(
        MaterialApp(
          theme: lightMode,
          home: Scaffold(
            body: HistoryItem(
              historyItem: mockHistoryItemModel,
            ),
          ),
        ),
      );

      // Ensure animations complete
      await tester.pumpAndSettle();

      // Perform a golden test
      await expectLater(
        find.byType(HistoryItem),
        matchesGoldenFile('goldens/history_item_light_mode.png'),
      );
    });
  });

  testWidgets('HistoryItem matches golden file in dark mode',
      (WidgetTester tester) async {
    // Mock the HistoryItemModel
    final mockHistoryItemModel = MockHistoryItemModel();
    when(() => mockHistoryItemModel.petModel).thenReturn(
      PetModel(
        image: 'https://example.com/test-image.png',
        name: 'Buddy',
        price: 29.99,
        age: 20,
        isAvailable: true,
      ),
    );

    // Mock network image loading
    await mockNetworkImagesFor(() async {
      // Build the widget with dark mode
      await tester.pumpWidget(
        MaterialApp(
          theme: darkMode,
          home: Scaffold(
            body: HistoryItem(
              historyItem: mockHistoryItemModel,
            ),
          ),
        ),
      );

      // Ensure animations complete
      await tester.pumpAndSettle();

      // Perform a golden test
      await expectLater(
        find.byType(HistoryItem),
        matchesGoldenFile('goldens/history_item_dark_mode.png'),
      );
    });
  });
}
