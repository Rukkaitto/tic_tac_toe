import 'package:flutter_test/flutter_test.dart';

abstract class Robot {
  const Robot(this.tester);

  final WidgetTester tester;
}
