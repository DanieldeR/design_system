import 'package:flutter_test/flutter_test.dart';

import 'package:design_system_example/main.dart';

void main() {
  testWidgets('Gallery app renders section headings', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const GalleryApp());
    await tester.pumpAndSettle();

    expect(find.text('Buttons'), findsOneWidget);
    expect(find.text('Cards'), findsOneWidget);
    expect(find.text('Tabs'), findsOneWidget);
  });
}
