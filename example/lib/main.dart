import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const GalleryApp());
}

class GalleryApp extends StatefulWidget {
  const GalleryApp({super.key});

  @override
  State<GalleryApp> createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  Brightness _brightness = Brightness.light;

  void _toggleBrightness() {
    setState(() {
      _brightness = _brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = _brightness == Brightness.light
        ? DSThemeData.light
        : DSThemeData.dark;

    return MaterialApp(
      title: 'Design System Gallery',
      debugShowCheckedModeBanner: false,
      home: DSTheme(
        data: themeData,
        child: GalleryScreen(onToggleBrightness: _toggleBrightness),
      ),
    );
  }
}

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key, required this.onToggleBrightness});

  final VoidCallback onToggleBrightness;

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  int _tabIndex = 0;
  bool _checked = true;
  String _radioValue = 'a';
  String? _selectValue = 'blue';

  @override
  Widget build(BuildContext context) {
    final theme = DSTheme.of(context);
    final colors = theme.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Design System Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleBrightness,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: DSContainer(
          maxWidth: 720,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: DSSpacing.xxl),
            child: DSStack(
              gap: DSSpacing.xxl,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _section(
                  context,
                  title: 'Buttons',
                  child: Wrap(
                    spacing: DSSpacing.sm,
                    runSpacing: DSSpacing.sm,
                    children: [
                      DSButton(label: 'Primary', onPressed: () {}),
                      DSButton(
                        label: 'Secondary',
                        variant: DSButtonVariant.secondary,
                        onPressed: () {},
                      ),
                      DSButton(
                        label: 'Outline',
                        variant: DSButtonVariant.outline,
                        onPressed: () {},
                      ),
                      DSButton(
                        label: 'Ghost',
                        variant: DSButtonVariant.ghost,
                        onPressed: () {},
                      ),
                      DSButton(
                        label: 'Danger',
                        variant: DSButtonVariant.danger,
                        onPressed: () {},
                      ),
                      const DSButton(label: 'Disabled', onPressed: null),
                    ],
                  ),
                ),
                _section(
                  context,
                  title: 'Badges',
                  child: Wrap(
                    spacing: DSSpacing.sm,
                    runSpacing: DSSpacing.sm,
                    children: const [
                      DSBadge(label: 'Neutral'),
                      DSBadge(label: 'Brand', tone: DSBadgeTone.brand),
                      DSBadge(label: 'Success', tone: DSBadgeTone.success),
                      DSBadge(label: 'Warning', tone: DSBadgeTone.warning),
                      DSBadge(label: 'Danger', tone: DSBadgeTone.danger),
                      DSBadge(label: 'Info', tone: DSBadgeTone.info),
                    ],
                  ),
                ),
                _section(
                  context,
                  title: 'Inputs',
                  child: DSGrid(
                    columns: 2,
                    children: [
                      const DSInput(
                        label: 'Email',
                        placeholder: 'you@example.com',
                      ),
                      DSSelect<String>(
                        label: 'Favorite color',
                        value: _selectValue,
                        options: const [
                          DSSelectOption(value: 'blue', label: 'Blue'),
                          DSSelectOption(value: 'green', label: 'Green'),
                          DSSelectOption(value: 'red', label: 'Red'),
                        ],
                        onChanged: (v) => setState(() => _selectValue = v),
                      ),
                    ],
                  ),
                ),
                _section(
                  context,
                  title: 'Selection controls',
                  child: DSStack(
                    gap: DSSpacing.sm,
                    children: [
                      DSCheckbox(
                        value: _checked,
                        label: 'Send me updates',
                        onChanged: (v) => setState(() => _checked = v),
                      ),
                      DSRadio<String>(
                        value: 'a',
                        groupValue: _radioValue,
                        label: 'Option A',
                        onChanged: (v) => setState(() => _radioValue = v),
                      ),
                      DSRadio<String>(
                        value: 'b',
                        groupValue: _radioValue,
                        label: 'Option B',
                        onChanged: (v) => setState(() => _radioValue = v),
                      ),
                    ],
                  ),
                ),
                _section(
                  context,
                  title: 'Cards',
                  child: DSGrid(
                    columns: 2,
                    children: [
                      DSCard(
                        elevated: true,
                        onTap: () {},
                        child: DSStack(
                          gap: DSSpacing.xs,
                          children: [
                            Text(
                              'Elevated card',
                              style: theme.typography.headingSmall.copyWith(
                                color: colors.textPrimary,
                              ),
                            ),
                            Text(
                              'With a shadow and tappable surface.',
                              style: theme.typography.bodyMedium.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DSCard(
                        child: DSStack(
                          gap: DSSpacing.xs,
                          children: [
                            Text(
                              'Flat card',
                              style: theme.typography.headingSmall.copyWith(
                                color: colors.textPrimary,
                              ),
                            ),
                            Text(
                              'Border only, no shadow.',
                              style: theme.typography.bodyMedium.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _section(
                  context,
                  title: 'Tabs',
                  child: DSTabs(
                    tabs: const [
                      DSTabItem(label: 'Overview', icon: Icons.dashboard),
                      DSTabItem(label: 'Activity', icon: Icons.timeline),
                      DSTabItem(label: 'Settings', icon: Icons.settings),
                    ],
                    selectedIndex: _tabIndex,
                    onChanged: (i) => setState(() => _tabIndex = i),
                  ),
                ),
                _section(context, title: 'Divider', child: const DSDivider()),
                _section(
                  context,
                  title: 'Tooltip, modal & toast',
                  child: Wrap(
                    spacing: DSSpacing.md,
                    runSpacing: DSSpacing.md,
                    children: [
                      DSTooltip(
                        message: 'This is a tooltip',
                        child: DSButton(
                          label: 'Hover me',
                          variant: DSButtonVariant.outline,
                          onPressed: () {},
                        ),
                      ),
                      DSButton(
                        label: 'Open modal',
                        variant: DSButtonVariant.secondary,
                        onPressed: () => DSModal.show(
                          context: context,
                          title: 'Confirm action',
                          child: Text(
                            'Are you sure you want to continue?',
                            style: theme.typography.bodyMedium.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                          actions: [
                            DSModalAction(
                              label: 'Cancel',
                              variant: DSButtonVariant.ghost,
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            DSModalAction(
                              label: 'Confirm',
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      ),
                      DSButton(
                        label: 'Show toast',
                        variant: DSButtonVariant.ghost,
                        onPressed: () => DSToast.show(
                          context,
                          message: 'Saved successfully',
                          tone: DSToastTone.success,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _section(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    final theme = DSTheme.of(context);
    return DSStack(
      gap: DSSpacing.md,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: theme.typography.headingSmall.copyWith(
            color: theme.colors.textPrimary,
          ),
        ),
        child,
      ],
    );
  }
}
