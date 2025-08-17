import 'package:apex_sports/app/layers/presenter/providers/config_provider.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  late ConfigProvider configProvider;
  UserProvider();
  void setConfigProvider(ConfigProvider provider) => configProvider = provider;
}
