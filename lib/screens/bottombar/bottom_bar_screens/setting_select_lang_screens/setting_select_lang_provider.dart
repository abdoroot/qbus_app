import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class SettingSelectLangProvider with ChangeNotifier {
  BuildContext? context;
  final Logger _logger = Logger();

  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
  }
}
