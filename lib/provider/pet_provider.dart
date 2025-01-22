import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:poc/model/pet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetProvider extends ChangeNotifier {
  List<PetModel> _pet = [


    PetModel(
        name: "Rabbit",
        age: 8,
        price: 999,
        image:"https://images.pexels.com/photos/2883510/pexels-photo-2883510.jpeg?auto=compress&cs=tinysrgb&w=1200",
        isAvailable: true,
        category: "rabbit"),
    PetModel(
        name: "Rabbit",
        age: 8,
        price: 400,
        image:"https://images.pexels.com/photos/372166/pexels-photo-372166.jpeg?auto=compress&cs=tinysrgb&w=1200",
        isAvailable: true,
        category: "rabbit"),
    PetModel(
        name: "Rabbit",
        age: 8,
        price: 999,
        image:"https://images.pexels.com/photos/1462636/pexels-photo-1462636.jpeg?auto=compress&cs=tinysrgb&w=1200",
        isAvailable: true,
        category: "rabbit"),
    PetModel(
        name: "Reading Rabbit",
        age: 8,
        price: 999,
        image:"https://images.pexels.com/photos/4588428/pexels-photo-4588428.jpeg?auto=compress&cs=tinysrgb&w=1200",
        isAvailable: true,
        category: "rabbit"),
    PetModel(
        name: "Standing Rabbit",
        age: 8,
        price: 999,
        image:"https://images.pexels.com/photos/4588055/pexels-photo-4588055.jpeg?auto=compress&cs=tinysrgb&w=1200",
        isAvailable: true,
        category: "rabbit"),PetModel(
        name: "Boll Rabbit",
        age: 8,
        price: 999,
        image:"https://images.pexels.com/photos/6897433/pexels-photo-6897433.jpeg?auto=compress&cs=tinysrgb&w=1200",
        isAvailable: true,
        category: "rabbit"),
    PetModel(
        name: "Golden Retriever",
        age: 7,
        price: 999,
        image:
            'https://cdn.shopify.com/s/files/1/1708/4041/files/custom_resized_CG_480x480.jpg',
        isAvailable: true,
        category: "dog"),
    PetModel(
        name: "Labrador",
        price: 800,
        age: 10,
        image:
            'https://cdn.shopify.com/s/files/1/1708/4041/files/custom_resized_lab_480x480.jpg',
        isAvailable: true,
        category: "dog"),
    PetModel(
        name: "German Shepherd",
        age: 5,
        price: 999,
        image:
            'https://cdn.shopify.com/s/files/1/1708/4041/files/custom_resized_German_shep_480x480.jpg',
        isAvailable: true,
        category: "dog"),
    PetModel(
        name: "Pug",
        age: 7,
        price: 900,
        image:
            'https://cdn.shopify.com/s/files/1/1708/4041/files/custom_resized_pug_480x480.jpg',
        isAvailable: true,
        category: "dog"),
    PetModel(
        name: "Dachshund",
        age: 3,
        price: 999,
        image:
            'https://cdn.shopify.com/s/files/1/1708/4041/files/custom_resized_Dasch_480x480.jpg',
        isAvailable: true,
        category: "dog"),
    PetModel(
        name: "Doberman",
        age: 8,
        price: 999,
        image:
            'https://cdn.shopify.com/s/files/1/1708/4041/files/custom_resized_Doberman_480x480.jpg',
        isAvailable: true,
        category: "dog"),
    PetModel(
        name: "Bombay Cat",
        age: 8,
        price: 999,
        image:
            'https://t4.ftcdn.net/jpg/03/03/62/45/240_F_303624505_u0bFT1Rnoj8CMUSs8wMCwoKlnWlh5Jiq.jpg',
        isAvailable: true,
        category: "cat"),
    PetModel(
        name: "Curl Cat",
        age: 8,
        price: 800,
        image:
            'https://t4.ftcdn.net/jpg/03/03/62/45/240_F_303624505_u0bFT1Rnoj8CMUSs8wMCwoKlnWlh5Jiq.jpg',
        isAvailable: true,
        category: "cat"),
    PetModel(
        name: "Bengal Cat",
        age: 8,
        price: 850,
        image:
           'https://t4.ftcdn.net/jpg/03/03/62/45/240_F_303624505_u0bFT1Rnoj8CMUSs8wMCwoKlnWlh5Jiq.jpg',
        isAvailable: true,
        category: "cat"),
    PetModel(
        name: "Chartreux",
        age: 8,
        price: 999,
        image:"https://t4.ftcdn.net/jpg/03/03/62/45/240_F_303624505_u0bFT1Rnoj8CMUSs8wMCwoKlnWlh5Jiq.jpg",
            isAvailable: true,
        category: "cat"),
  ];

  List<PetModel> get pet => _pet;

  Future<void> buyItem(PetModel product) async {
    final PetModel item =
        _pet.firstWhere((element) => element.id == product.id);
    item.isAvailable = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedList = json.encode(_pet.map((item) => item.toMap()).toList());
    await prefs.setString('petList', encodedList);
    notifyListeners();
  }

  // Loading the history from shared preferences
  Future<void> loadState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonList = prefs.getString('petList');
    if (jsonList != null) {
      List<dynamic> decodedList = json.decode(jsonList);
      _pet = decodedList.map((item) => PetModel.fromMap(item)).toList();
    }
    notifyListeners();
  }
}
