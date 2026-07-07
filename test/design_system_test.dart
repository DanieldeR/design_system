import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:design_system/design_system.dart';

Widget _wrap(Widget child) {
  return MaterialApp(home: DSTheme(child: Scaffold(body: Center(child: child))));
}

void main() {
  testWidgets('DSButton renders label and responds to taps', (tester) async {
    var pressed = false;
    await tester.pumpWidget(
      _wrap(DSButton(label: 'Continue', onPressed: () => pressed = true)),
    );

    expect(find.text('Continue'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    expect(pressed, isTrue);
  });

  testWidgets('DSCheckbox toggles value', (tester) async {
    var checked = false;
    await tester.pumpWidget(
      _wrap(
        DSCheckbox(
          value: checked,
          label: 'Accept terms',
          onChanged: (v) => checked = v,
        ),
      ),
    );

    await tester.tap(find.text('Accept terms'));
    expect(checked, isTrue);
  });

  testWidgets('DSBadge renders its label', (tester) async {
    await tester.pumpWidget(_wrap(const DSBadge(label: 'New')));
    expect(find.text('New'), findsOneWidget);
  });

  testWidgets('DSTabs highlights the selected tab', (tester) async {
    var selected = 0;
    await tester.pumpWidget(
      _wrap(
        DSTabs(
          tabs: const [DSTabItem(label: 'One'), DSTabItem(label: 'Two')],
          selectedIndex: selected,
          onChanged: (i) => selected = i,
        ),
      ),
    );

    expect(find.text('One'), findsOneWidget);
    expect(find.text('Two'), findsOneWidget);
    await tester.tap(find.text('Two'));
    expect(selected, 1);
  });
}
