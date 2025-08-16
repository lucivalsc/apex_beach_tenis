import 'dart:convert';

import 'package:beach_tenis_app/app/common/styles/app_styles.dart';
import 'package:beach_tenis_app/app/common/widget/app_widgets.dart';
import 'package:beach_tenis_app/app/common/widget/input_text.dart';
import 'package:beach_tenis_app/app/layers/presenter/providers/auth_provider.dart';
import 'package:beach_tenis_app/app/layers/presenter/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Config extends StatefulWidget {
  const Config({Key? key}) : super(key: key);

  static const String route = "config";

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  final appStyles = AppStyles();
  final appWidgets = AppWidgets();
  bool isScreenLocked = false;
  late AuthProvider authProvider;
  late ConfigProvider configProvider;
  late Future<void> future;
  TextEditingController host = TextEditingController();
  TextEditingController port = TextEditingController();
  Future<void> initScreen() async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    configProvider = Provider.of<ConfigProvider>(context, listen: false);

    await Future.delayed(const Duration(milliseconds: 200));

    var value = await configProvider.loadConfig();
    var data = jsonDecode(value);
    host.text = data['ip'] ?? '';
    port.text = data['port'] ?? '';
  }

  @override
  void initState() {
    super.initState();
    future = initScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CONFIGURAÇÃO')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        reverse: true,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              appStyles.loginPath,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            const Column(children: []),
            InputText(
              controller: host,
              labeltext: 'IP',
              typeKeyboard: TextInputType.name,
            ),
            InputText(
              controller: port,
              labeltext: 'Porta',
              typeKeyboard: TextInputType.number,
            ),
            appWidgets.buildPrimaryButton(
              () async {
                setState(() => isScreenLocked = true);
                FocusManager.instance.primaryFocus?.unfocus();
                await configProvider.saveConfig(
                  jsonEncode(
                    {
                      "ip": host.text,
                      "port": port.text,
                    },
                  ),
                );
                setState(() => isScreenLocked = false);
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              label: "SALVAR",
              enable: true,
              processing: isScreenLocked,
              buttonColor: appStyles.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
