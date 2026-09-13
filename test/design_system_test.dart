import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:design_system/design_system.dart';

Widget _wrap(Widget child) {
  return MaterialApp(home: DSTheme(child: Scaffold(body: Center(child: child))));
}

Widget _wrapScreen(Widget child) {
  return MaterialApp(home: DSTheme(child: child));
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

  testWidgets('DSAuthScaffold renders header, mark and actions', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrapScreen(
        DSAuthScaffold(
          icon: Icons.lock_outline,
          title: 'Welcome back',
          subtitle: 'Sign in to continue',
          children: [DSButton(label: 'Sign in', onPressed: () {})],
        ),
      ),
    );

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Sign in to continue'), findsOneWidget);
    expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
  });

  testWidgets('DSAuthScaffold shows the error banner above its actions', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrapScreen(
        DSAuthScaffold(
          title: 'Welcome back',
          errorMessage: 'Wrong password',
          children: [DSButton(label: 'Sign in', onPressed: () {})],
        ),
      ),
    );

    expect(find.byType(DSAuthErrorBanner), findsOneWidget);
    expect(find.text('Wrong password'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline), findsOneWidget);

    final bannerY = tester.getTopLeft(find.byType(DSAuthErrorBanner)).dy;
    final buttonY = tester.getTopLeft(find.text('Sign in')).dy;
    expect(bannerY, lessThan(buttonY));
  });

  testWidgets('DSAuthScaffold hides the error banner when there is no error', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrapScreen(
        DSAuthScaffold(
          title: 'Welcome back',
          children: [DSButton(label: 'Sign in', onPressed: () {})],
        ),
      ),
    );

    expect(find.byType(DSAuthErrorBanner), findsNothing);
  });

  testWidgets('an expanded DSButton truncates instead of overflowing', (
    tester,
  ) async {
    // 90px is narrower than the label at any size; the row must not throw.
    await tester.pumpWidget(
      _wrap(
        SizedBox(
          width: 90,
          child: DSButton(
            label: 'A label far too long for this width',
            expand: true,
            onPressed: () {},
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    final text = tester.widget<Text>(find.byType(Text));
    expect(text.overflow, TextOverflow.ellipsis);
  });
}
