import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:beach_tenis_app/app/common/styles/app_styles.dart';
import 'package:beach_tenis_app/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> checkIfHeroIconExists(String path) async {
  try {
    await rootBundle.load(path);
    return path;
  } catch (e) {
    return null;
  }
}

String capitalize(String string) {
  string = string.trim();
  final exceptions = ["do", "dos", "da", "das", "de"];
  final fullUpperCase = ['ltda', 'cia', 'go', 'km'];
  if (string == '') {
    return '-';
  } else if (string.split(' ').length > 1) {
    return string
        .toLowerCase()
        .split(" ")
        .map((sub) {
          if (sub == '') {
            return sub;
          } else if (fullUpperCase.contains(sub)) {
            return sub.toUpperCase();
          } else if (!exceptions.contains(sub)) {
            return sub[0].toUpperCase() + sub.substring(1);
          } else {
            return sub;
          }
        })
        .toList()
        .join(" ");
  } else {
    return string.substring(0, 1).toUpperCase() + string.substring(1);
  }
}

Future<void> startHiveStuff() async {
  await getApplicationDocumentsDirectory().then((directory) => Hive.init(directory.path));
}

buildButton(
  String title,
  String? tela,
  BuildContext context,
  IconData? icon, [
  Function? funcao,
]) {
  return InkWell(
    onTap: () {
      if (tela != null) {
        pushNamed(context, tela);
      } else {
        funcao!();
      }
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: MediaQuery.of(context).size.width / 9.5,
            color: AppStyles().blackColor,
          ),
          const SizedBox(height: 4),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppStyles().blackColor,
                  fontSize: 20,
                  fontFamily: 'serif',
                ),
                maxLines: 2,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
