import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movil181/app/domain/models/models.dart';

class CategoriesService extends ChangeNotifier {
  final String _baseUrl = 'categorias-app-default-rtdb.firebaseio.com';
  final List<Categorias> listaCategorias = [];
  final List<Categorias> productos = [];
  final List<Categorias> servicios = [];
  final List<Stores> listaTiendas = [];

  bool isLoading = true;

  CategoriesService() {
    loadCategories();
  }

  Future<List<Categorias>> loadCategories() async {
    final url = Uri.https(_baseUrl, '/categorias.json');
    final resp = await http.get(url);
    final Map<String, dynamic> categoriesMap = json.decode(resp.body);
    print(categoriesMap);

    categoriesMap.forEach((key, value) {
      final tempCategory = Categorias.fromMap(value);
      tempCategory.nombre = key;
      listaCategorias.add(tempCategory);
      print(tempCategory.nombre);

      //listaTiendas.add(tempCategory.store!);
      if (tempCategory.tipo == true) {
        productos.add(tempCategory);
      } else {
        servicios.add(tempCategory);
      }
    });
    isLoading = false;
    notifyListeners();
    return listaCategorias;
  }
}
