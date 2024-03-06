import 'package:flutter/material.dart';
import 'package:pf3d/models/model.dart';
import 'package:provider/provider.dart';

import '../providers/models_provider.dart';

class Carde extends StatelessWidget {
  final Model model;
  const Carde({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Provider.of<ModelsProvider>(context, listen: false)
                    .selectedModel = model;
                Navigator.pushNamed(context, '/model_detail');
              },
              child: ListTile(
                leading: const Icon(Icons.format_paint_rounded),
                title: Text(model.name),
                subtitle: Text(model.src),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      Provider.of<ModelsProvider>(context, listen: false)
                          .toggleFav(model);
                    },
                    icon: Icon(
                      model.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: model.isFavorite ? Colors.red : Colors.grey,
                    )),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
