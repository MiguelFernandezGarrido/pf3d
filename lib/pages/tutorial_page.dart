import 'package:flutter/material.dart';
import 'package:pf3d/shared_prefs/user_prefs.dart';

import 'tutorial1.dart';
import 'tutorial2.dart';
import 'tutorial3.dart';

class Tutorial extends StatelessWidget {
  const Tutorial({super.key});
  final List<Widget> pages = const [Tutorial1(), Tutorial2(), Tutorial3()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorial'),
      ),
      body: Stack(
        children: [
          PageView.builder(
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    pages[index],
                    ElevatedButton(
                        onPressed: () {
                          UserPrefs.setShowTutorial(false);
                          Navigator.pushNamed(context, '/');
                        },
                        child: const Text('Next'))
                  ],
                );
              }),
        ],
      ),
    );
  }
}
