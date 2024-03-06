import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_whatsapp/share_whatsapp.dart';

import '../models/model.dart';
import '../providers/models_provider.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ModelDetail extends StatelessWidget {
  const ModelDetail({super.key});
  @override
  Widget build(BuildContext context) {
    final Model? model = Provider.of<ModelsProvider>(context).selectedModel;
    if (model == null) {
      return const Scaffold(
          body: Center(
        child: Text('No model selected'),
      ));
    }
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 206, 196, 196),
        appBar: AppBar(
          title: Text(model.name, style: const TextStyle(color: Colors.black)),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop()),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(model.src, style: const TextStyle(color: Colors.black)),
                AspectRatio(
                  aspectRatio: 16 / 7,
                  child: ModelViewer(
                    src: model.src,
                    backgroundColor: const Color.fromARGB(255, 206, 196, 196),
                    alt: 'A 3D model',
                    ar: true,
                    arModes: const ['scene-viewer', 'webxr', 'quick-look'],
                    autoRotate: true,
                    disableZoom: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Compartir por Whatsapp",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    IconButton(
                        onPressed: () {
                          shareWhatsapp.share(text: model.name);
                        },
                        icon: const Icon(Icons.share, color: Colors.black)),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
