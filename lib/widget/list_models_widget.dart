import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';
import '../providers/models_provider.dart';

class ListModels extends StatelessWidget {
  final List<Model> models;
  const ListModels({
    super.key,
    required this.models,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: models.length,
        itemBuilder: (context, index) {
          final model = models[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Provider.of<ModelsProvider>(context, listen: false)
                    .selectedModel = model;
                Navigator.pushNamed(context, '/model_detail');
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: ListTile(
                  tileColor: Colors.blue.shade100,
                  title: Text(model.name,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  trailing: IconButton(
                      onPressed: () {
                        Provider.of<ModelsProvider>(context, listen: false)
                            .toggleFav(model);
                      },
                      icon: Icon(
                        model.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: model.isFavorite ? Colors.red : Colors.black,
                      )),
                ),
              ),
            ),
          );
        });
  }
}
