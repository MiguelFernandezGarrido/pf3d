import 'package:http/http.dart' as http;
import 'package:pf3d/models/model.dart';

class FavouritesService {
  static const String urlFav =
      'https://modelos3d-89e35-default-rtdb.firebaseio.com/modelFavs';
  static const String json = '.json';

  Future<List<Model>> getFavs() async {
    final response = await http.get(Uri.parse(urlFav + json));
    return modelsFromJson(response.body);
  }

  Future<bool> putFavs(List<Model> models) async {
    final response = await http.put(
      Uri.parse(urlFav + json),
      body: modelsToJson(models),
    );
    return response.statusCode == 200;
  }
}
