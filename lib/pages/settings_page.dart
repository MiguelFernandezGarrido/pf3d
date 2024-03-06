import 'package:flutter/material.dart';
import 'package:pf3d/shared_prefs/user_prefs.dart';
import 'package:pf3d/widget/settings_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Column(
          children: [
            const Text('Activar/Desactivar Tutorial',
                style: TextStyle(fontSize: 20)),
            const SwitchTutorial(),
            const Text('Resetear Modelos Originales',
                style: TextStyle(fontSize: 20)),
            IconButton(
                onPressed: () {
                  UserPrefs.resetModels();
                },
                icon: const Icon(Icons.shield_moon_rounded, size: 50)),
          ],
        ),
      )),
    );
  }
}
