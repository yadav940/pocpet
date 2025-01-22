import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:poc/model/pet_model.dart';
import 'package:poc/pages/history_screen.dart';
import 'package:provider/provider.dart';
import 'package:poc/components/history_item.dart';
import 'package:poc/model/history_model.dart';
import 'package:poc/provider/history_provider.dart';

// Generate mock classes using Mockito
@GenerateMocks([HistoryProvider])
import 'history_screen.mocks.dart';

void main() {
  late MockHistoryProvider mockHistoryProvider;

  setUp(() {
    mockHistoryProvider = MockHistoryProvider();
  });

  Widget createTestWidget() {
    return ChangeNotifierProvider<HistoryProvider>.value(
      value: mockHistoryProvider,
      child: const MaterialApp(
        home: HistoryScreen(),
      ),
    );
  }

  testWidgets('Displays history items when HistoryProvider has data', (WidgetTester tester) async {
    // Mock history data
    final historyItems = [
      HistoryItemModel(petModel: PetModel(name: 'Dog', image: 'image.png', price: 50.0, age: 23, isAvailable: false)),
      HistoryItemModel(petModel: PetModel(name: 'Cat', image: 'cat.png', price: 30.0, age: 23, isAvailable: true)),
    ];

    when(mockHistoryProvider.historyList).thenReturn(historyItems);
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify HistoryItem widgets
      expect(find.byType(HistoryItem), findsNWidgets(historyItems.length));
      expect(find.text('Dog'), findsOneWidget);
      expect(find.text('Cat'), findsOneWidget);
    });
  });


}