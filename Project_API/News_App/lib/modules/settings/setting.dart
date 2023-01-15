import 'package:flutter/material.dart';

import '../../cubit/cubittheme.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Theme Mode",
                  style: TextStyle(fontSize: 25.0),
                ),
                const SizedBox(width: 150.0),
                IconButton(
                  icon: const Icon(
                    Icons.brightness_4_outlined,
                    size: 25.0,
                  ),
                  onPressed: () {
                    ThemeCubit.get(context).changeAppMode();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
