import 'ui_component_setting_list_item.dart';

sealed class UIComponentSetting<T> {
  UIComponentSetting(this.value);
  final T value;
}

class UIComponentSettingBool extends UIComponentSetting<bool> {
  // ignore: avoid_positional_boolean_parameters
  UIComponentSettingBool(super.value);

  UIComponentSettingBool copyWith({bool? value}) {
    return UIComponentSettingBool(value ?? this.value);
  }
}

class UIComponentSettingString extends UIComponentSetting<String> {
  UIComponentSettingString(super.value);

  UIComponentSettingString copyWith({String? value}) {
    return UIComponentSettingString(value ?? this.value);
  }
}

class UIComponentSettingInt extends UIComponentSetting<int> {
  UIComponentSettingInt(super.value);

  UIComponentSettingInt copyWith({int? value}) {
    return UIComponentSettingInt(value ?? this.value);
  }
}

class UIComponentSettingDouble extends UIComponentSetting<double> {
  UIComponentSettingDouble(super.value);

  UIComponentSettingDouble copyWith({double? value}) {
    return UIComponentSettingDouble(value ?? this.value);
  }
}

class UIComponentSettingDateTime extends UIComponentSetting<DateTime> {
  UIComponentSettingDateTime(super.value);

  UIComponentSettingDateTime copyWith({DateTime? value}) {
    return UIComponentSettingDateTime(value ?? this.value);
  }
}

class UIComponentSettingList<T> extends UIComponentSetting<T> {
  UIComponentSettingList(super.value, this.list);
  final List<UIComponentSettingListItem<T>> list;

  UIComponentSettingList<T> copyWith({T? value}) {
    return UIComponentSettingList<T>(
      value ?? this.value,
      list,
    );
  }
}
