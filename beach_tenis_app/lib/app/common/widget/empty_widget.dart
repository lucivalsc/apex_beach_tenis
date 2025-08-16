import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  final bool isScreenLocked;
  const EmptyWidget({
    Key? key,
    required this.isScreenLocked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (isScreenLocked == false)
          const Text(
            'Nenhuma informação\n encontrada!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
        if (isScreenLocked == false)
          Lottie.asset(
            'lib/app/common/assets/lottie/empty.json',
            height: MediaQuery.of(context).size.width / 2,
          ),
      ],
    );
  }
}
