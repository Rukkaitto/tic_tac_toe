import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/ui_component_setting.dart';

typedef UIComponentSettings = Map<String, UIComponentSetting<dynamic>>;

class UIComponentSettingsCubit extends Cubit<UIComponentSettings> {
  UIComponentSettingsCubit(super.defaultSettings);

  void setSettings(UIComponentSettings settings) {
    emit(settings);
  }

  void setSetting(String key, UIComponentSetting<dynamic> setting) {
    final Map<String, UIComponentSetting<dynamic>> newSettings =
        <String, UIComponentSetting<dynamic>>{
      ...state,
      key: setting,
    };
    emit(newSettings);
  }
}
