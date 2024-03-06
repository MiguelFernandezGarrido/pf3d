import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/models_provider.dart';
import '../widget/card_widget.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ModelsProvider modelsProvider = Provider.of<ModelsProvider>(context);

    return Column(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Buscar',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              modelsProvider.searchModels(value);
            },
          ),
        ),
      ),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: modelsProvider.getFilteredModels().isEmpty
            ? const Center(child: CircularProgressIndicator())
            : StackedCardCarousel(
                items: modelsProvider
                    .getFilteredModels()
                    .map((modelo) => Carde(
                          model: modelo,
                        ))
                    .toList()),
      ))
    ]);
  }
}
