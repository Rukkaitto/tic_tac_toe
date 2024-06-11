import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/ui_component_settings_cubit.dart';

import 'widgets/ui_component_settings_modal.dart';

class UIComponentDemoPage extends StatelessWidget {
  const UIComponentDemoPage({
    required this.title,
    required this.defaultSettings,
    required this.widgetBuilder,
    super.key,
  });
  final String title;
  final UIComponentSettings defaultSettings;
  final Widget Function(UIComponentSettings settings) widgetBuilder;

  void handleSettingsPressed(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return BlocProvider<UIComponentSettingsCubit>.value(
          value: BlocProvider.of<UIComponentSettingsCubit>(context),
          child: const UIComponentSettingsModal(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UIComponentSettingsCubit>.value(
      value: UIComponentSettingsCubit(defaultSettings),
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => handleSettingsPressed(context),
              child: const Icon(Icons.settings),
            ),
            body: Center(
              child: BlocBuilder<UIComponentSettingsCubit, UIComponentSettings>(
                builder: (BuildContext context, UIComponentSettings state) {
                  return widgetBuilder(state);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
