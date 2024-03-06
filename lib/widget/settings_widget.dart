import 'package:flutter/material.dart';
import 'package:pf3d/shared_prefs/user_prefs.dart';

class SwitchTutorial extends StatefulWidget {
  const SwitchTutorial({super.key});

  @override
  State<SwitchTutorial> createState() => __SwitchTutorialState();
}

class __SwitchTutorialState extends State<SwitchTutorial> {
  bool showTutorial = UserPrefs.getShowTutorial();
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: showTutorial,
      onChanged: (value) {
        setState(() {
          showTutorial = value;
          UserPrefs.setShowTutorial(showTutorial);
        });
      },
    );
  }
}
