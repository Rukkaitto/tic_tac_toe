import 'package:flutter/material.dart';

import '../../../features/uikit/domain/entities/ui_component_setting.dart';
import '../../../features/uikit/presentation/bloc/ui_component_settings_cubit.dart';
import '../../../features/uikit/presentation/pages/ui_component_demo_page/ui_component_demo_page.dart';
import '../../services/router_service/app_routes.dart';
import 'my_button.dart';

class MyButtonDemoPage extends StatelessWidget {
  const MyButtonDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UIComponentDemoPage(
      title: AppRoutes.myButton.name,
      defaultSettings: <String, UIComponentSetting<dynamic>>{
        'text': UIComponentSettingString('Button'),
      },
      widgetBuilder: (UIComponentSettings parameters) {
        final String text = parameters['text']!.value as String;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: MyButton(
            text: text,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Button pressed')),
              );
            },
          ),
        );
      },
    );
  }
}
