import 'package:flutter/material.dart';
import '../../../../core/services/router_service/app_routes.dart';
import '../../../../core/services/router_service/router_service.dart';

class UIKitPage extends StatelessWidget {
  const UIKitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <ListTile>[
          ListTile(
            title: Text(AppRoutes.myButton.name),
            onTap: () {
              RouterService.of(context).go(AppRoutes.myButton);
            },
          ),
        ],
      ),
    );
  }
}
