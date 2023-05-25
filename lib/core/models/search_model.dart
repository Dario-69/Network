import 'package:cloud_firestore/cloud_firestore.dart';

class SearchModel {
  final String? nom;
  final String? category;
  final String? imageUrl;


  SearchModel({this.nom, this.category, this.imageUrl});


  List<SearchModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
      snapshot.data() as Map<String, dynamic>;

      return SearchModel(
        nom: dataMap['nom'],
        category: dataMap['category'],
        imageUrl: dataMap['imageUrl'],
      );
    }).toList();
  }
}