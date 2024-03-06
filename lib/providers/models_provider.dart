import 'package:flutter/material.dart';
import 'package:pf3d/models/model.dart';
import 'package:pf3d/services/favourites_service.dart';
import 'package:pf3d/shared_prefs/user_prefs.dart';

class ModelsProvider extends ChangeNotifier {
  List<Model> models = [
    Model(
      id: '1',
      src: 'assets/models/low_poly_cat.glb',
      name: 'Gatito',
      isFavorite: false,
      isActive: true,
    ),
    Model(
      id: '2',
      src: 'assets/models/pepe_-_monkas.glb',
      name: 'Pepe',
      isFavorite: false,
      isActive: true,
    ),
    Model(
      id: '3',
      src: 'assets/models/digimon_linkz_-_renamon.glb',
      name: 'Renamon',
      isFavorite: false,
      isActive: true,
    ),
    Model(
      id: '4',
      src: 'assets/models/house_elf.glb',
      name: 'Dobby',
      isFavorite: false,
      isActive: true,
    ),
    Model(
      id: '5',
      src: 'assets/models/legendary_pokemon_reshiram.glb',
      name: 'Reshiram',
      isFavorite: false,
      isActive: false,
    ),
    Model(
      id: '6',
      src: 'assets/models/km_salamence.glb',
      name: 'Salamence',
      isFavorite: false,
      isActive: false,
    ),
    Model(
      id: '7',
      src: 'assets/models/madoka_machida.glb',
      name: 'Madoka',
      isFavorite: false,
      isActive: false,
    ),
    Model(
      id: '8',
      src: 'assets/models/pulpo_platano.glb',
      name: 'Platano',
      isFavorite: false,
      isActive: false,
    ),
    Model(
      id: '9',
      src: 'assets/models/silver_dragonkin_mir4.glb',
      name: 'Dragonkin',
      isFavorite: false,
      isActive: false,
    ),
    Model(
      id: '10',
      src: 'assets/models/vampire_slayer_greatsword.glb',
      name: 'Vampire',
      isFavorite: false,
      isActive: false,
    )
  ];
  List<Model> favs = [];
  FavouritesService favsService = FavouritesService();
  Model? selectedModel;
  List<Model> filteredModels = [];
  Map<String, String> modelsMap = {};
  List<Model> modelsActive = [];
  Model? selectedModelActive;
  ModelsProvider() {
    _load();
  }

// TODO: comprobar si es así o con los favs
  List<Model> getFavorites() {
    return models.where((element) => element.isFavorite).toList();
  }

  List<Model> getModels() {
    return models;
  }

  List<Model> getFilteredModels() {
    return filteredModels;
  }

  List<Model> getModelsInactive() {
    return models.where((element) => !element.isActive).toList();
  }

  void _load() async {
    // Favs
    favs = await favsService.getFavs();
    await favsService.putFavs(favs);
    for (Model fav in favs) {
      for (Model model in models) {
        if (model.id == fav.id) {
          model.name = fav.name;
          model.isFavorite = true;
        }
      }
    }

    // Actives
    // modelsActive = models.where((element) => element.isActive).toList();
    if (UserPrefs.getModels().isNotEmpty) {
      for (Model model in models) {
        if (UserPrefs.getModels().contains(model.name)) {
          model.isActive = true;
        }
      }
    }
    modelsActive = models.where((element) => element.isActive).toList();

    // Filtered
    filteredModels = modelsActive;

    // AddModel
    for (Model model in models) {
      if (!model.isActive) {
        modelsMap[model.name] = model.name;
      }
    }
    selectedModelActive = models.firstWhere((element) => !element.isActive,
        orElse: () => models.first);
    notifyListeners();
  }

  void toggleFav(Model model) {
    model.isFavorite = !model.isFavorite;
    if (model.isFavorite) {
      favs.add(model);
      filteredModels
          .firstWhere((element) => element.name == model.name)
          .isFavorite = true;
    } else {
      favs.removeWhere((element) => element.name == model.name);
      filteredModels
          .firstWhere((element) => element.name == model.name)
          .isFavorite = false;
    }
    favsService.putFavs(favs);
    notifyListeners();
  }

  void searchModels(String query) {
    if (query.isNotEmpty) {
      List<Model> result = [];
      for (Model model in models) {
        if (model.name.toLowerCase().contains(query.toLowerCase())) {
          result.add(model);
        }
      }
      filteredModels = result;
    } else {
      filteredModels = models;
    }
    notifyListeners();
  }

  void addModel() {
    models.add(selectedModelActive!);
    UserPrefs.setModels(selectedModelActive!.name);
    filteredModels.add(selectedModelActive!);
    modelsMap.removeWhere((key, value) => key == selectedModelActive!.name);
    selectedModelActive = models.firstWhere((element) => !element.isActive);

    notifyListeners();
  }
}
