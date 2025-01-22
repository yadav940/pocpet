import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:poc/components/pet_card.dart';
import 'package:poc/components/pet_hero_image.dart';
import 'package:poc/model/pet_model.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  colorScheme: ColorScheme.light(
    primary: Colors.grey.shade300,
    secondary: Colors.grey.shade200,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey[900],
  colorScheme: ColorScheme.dark(
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
  ),
);

class MockPetModel extends Mock implements PetModel {}

void main() {
  late PetModel availablePet;
  late PetModel adoptedPet;

  setUp(() {
    availablePet = PetModel(
      name: "Golden Retriever",
      image: "https://example.com/test-pet-image.png",
      isAvailable: true, age: 20, price: 4334,
    );
    adoptedPet = PetModel(
      name: "Bulldog",
      image: "https://example.com/test-pet-image.png",
      isAvailable: false,age: 20, price: 4334,
    );
  });

  testWidgets('PetCard renders correctly for available pet (light mode)', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          theme: lightMode,
          home: Scaffold(
            body: PetCard(product: availablePet),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(PetCard),
        matchesGoldenFile('goldens/pet_card_available_light.png'),
      );
    });
  });

  testWidgets('PetCard renders correctly for adopted pet (light mode)', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          theme: lightMode,
          home: Scaffold(
            body: PetCard(product: adoptedPet),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(PetCard),
        matchesGoldenFile('goldens/pet_card_adopted_light.png'),
      );
    });
  });

  testWidgets('PetCard renders correctly for available pet (dark mode)', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          theme: darkMode,
          home: Scaffold(
            body: PetCard(product: availablePet),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(PetCard),
        matchesGoldenFile('goldens/pet_card_available_dark.png'),
      );
    });
  });

  testWidgets('PetCard renders correctly for adopted pet (dark mode)', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          theme: darkMode,
          home: Scaffold(
            body: PetCard(product: adoptedPet),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(PetCard),
        matchesGoldenFile('goldens/pet_card_adopted_dark.png'),
      );
    });
  });
}
