import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entities/ui_component_setting.dart';
import '../../../../domain/entities/ui_component_setting_list_item.dart';
import '../../../bloc/ui_component_settings_cubit.dart';

class UIComponentSettingsModal extends StatelessWidget {
  const UIComponentSettingsModal({super.key});

  void handleOnChanged(
    BuildContext context,
    String key,
    UIComponentSetting<dynamic> setting,
  ) {
    context.read<UIComponentSettingsCubit>().setSetting(key, setting);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<UIComponentSettingsCubit, UIComponentSettings>(
        builder: (BuildContext context, UIComponentSettings settings) {
          return Wrap(
            children: settings.keys.map(
              (String key) {
                final UIComponentSetting<dynamic> setting = settings[key]!;

                switch (setting) {
                  case UIComponentSettingBool(value: final bool value):
                    return SwitchListTile(
                      title: Text(key),
                      value: value,
                      onChanged: (bool value) => handleOnChanged(
                        context,
                        key,
                        setting.copyWith(value: value),
                      ),
                    );
                  case UIComponentSettingString(value: final String value):
                    return ListTile(
                      title: TextFormField(
                        decoration: InputDecoration(labelText: key),
                        initialValue: value,
                        onChanged: (String value) => handleOnChanged(
                          context,
                          key,
                          setting.copyWith(value: value),
                        ),
                      ),
                    );
                  case UIComponentSettingInt(value: final int value):
                    return ListTile(
                      title: TextFormField(
                        decoration: InputDecoration(labelText: key),
                        initialValue: value.toString(),
                        onChanged: (String value) => handleOnChanged(
                          context,
                          key,
                          setting.copyWith(value: int.parse(value)),
                        ),
                      ),
                    );
                  case UIComponentSettingDouble(value: final double value):
                    return ListTile(
                      title: TextFormField(
                        decoration: InputDecoration(labelText: key),
                        initialValue: value.toString(),
                        onChanged: (String value) => handleOnChanged(
                          context,
                          key,
                          setting.copyWith(value: double.parse(value)),
                        ),
                      ),
                    );
                  case UIComponentSettingList<dynamic>(
                      value: final dynamic value,
                      list: final List<UIComponentSettingListItem<dynamic>>
                          list,
                    ):
                    return ListTile(
                      title: DropdownButtonFormField<dynamic>(
                        decoration: InputDecoration(labelText: key),
                        value: value,
                        items: list.map(
                          (UIComponentSettingListItem<dynamic> selection) {
                            return DropdownMenuItem<dynamic>(
                              value: selection.value,
                              child: Text(selection.label),
                            );
                          },
                        ).toList(),
                        onChanged: (Object? value) => handleOnChanged(
                          context,
                          key,
                          setting.copyWith(value: value),
                        ),
                      ),
                    );
                  case UIComponentSettingDateTime(value: final DateTime value):
                    return ListTile(
                      title: Text(key),
                      trailing: FilledButton(
                        onPressed: () async {
                          final DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: value,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );

                          if (date != null && context.mounted) {
                            handleOnChanged(
                              context,
                              key,
                              setting.copyWith(value: date),
                            );
                          }
                        },
                        child: Text(DateFormat.yMMMMd().format(value)),
                      ),
                    );
                }
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
