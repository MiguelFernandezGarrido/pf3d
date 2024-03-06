import 'package:flutter/material.dart';
import 'package:pf3d/providers/models_provider.dart';
import 'package:provider/provider.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    ModelsProvider modelsProvider = Provider.of<ModelsProvider>(context);
    return Scaffold(
      body: Center(
          child: SizedBox(
        height: 400,
        width: 700,
        child: Column(children: [
          const Text('Añade un Nuevo Modelo',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const Expanded(child: DropdownButtonExample()),
          ElevatedButton(
            onPressed: () {
              modelsProvider.addModel();
            },
            child: const Text('Añadir'),
          )
        ]),
      )),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  @override
  Widget build(BuildContext context) {
    ModelsProvider modelsProvider = Provider.of<ModelsProvider>(context);
    String selectedItem = modelsProvider.selectedModelActive != null
        ? modelsProvider.selectedModelActive!.name
        : modelsProvider.modelsMap.keys.first;
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Selecciona un modelo:',
              style: Theme.of(context).textTheme.bodyLarge),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<String>(
              value: selectedItem,
              onChanged: (String? value) {
                // This is called when the user selects an item.
                if (value == null) return;
                setState(() {
                  selectedItem = value;
                  modelsProvider.selectedModelActive = modelsProvider.models
                      .firstWhere((element) => element.name == value);
                });
              },
              selectedItemBuilder: (BuildContext context) {
                return modelsProvider.modelsMap.values
                    .map<Widget>((String item) {
                  // This is the widget that will be shown when you select an item.
                  // Here custom text style, alignment and layout size can be applied
                  // to selected item string.
                  return Container(
                    alignment: Alignment.centerLeft,
                    constraints: const BoxConstraints(minWidth: 100),
                    child: Text(
                      item,
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600),
                    ),
                  );
                }).toList();
              },
              items: modelsProvider.modelsMap.keys
                  .map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
