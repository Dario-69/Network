class StoreModel{

  late final String propId;
  late final String id;
  String? nom;
  String? category;
  String? description;
  //
  String? phoneNumber;
  String? days;
  String? opening;
  String? closure;
  String? imageUrl;
  //
  List<String>? fav;
  List<String>? products;
  List<String>? services;

  StoreModel({
    required this.propId,
    required this.id,
    //Personal info
    this.nom,
    this.category,
    this.description,
    //
    this.phoneNumber,
    //
    this.days,
    this.opening,
    this.closure,
    this.fav,
    this.products,
    this.services,
    //
    this.imageUrl

  });

  StoreModel.fromJson(Map<dynamic, dynamic> data ){
    propId = data['propId'];
    id = data['id'];

    nom = data['nom'];
    category = data['category'];
    description = data['description'];

    phoneNumber = data['phoneNumber'];

    days = data['days'] == null ? [] : data['days'].data<String>((i) => i as String).toList();

    fav = data['fav'] == null ? [] : data['fav'].data<String>((i) => i as String).toList();
    products = data['products'] == null ? [] : data['products'].data<String>((i) => i as String).toList();
    services = data['services'] == null ? [] : data['services'].data<String>((i) => i as String).toList();

    opening = data['opening'];
    closure = data['closure'];

    imageUrl = data['imageUrl'];

  }

  toJson(){
    return{

      'propId': propId,
      'id': id,

      'nom': nom,
      'category': category,
      'description': description,

      'phoneNumber': phoneNumber,

      'days': days,
      'opening': opening,
      'closure': closure,
      'fav': fav,
      'products': products,
      'services': services,

      'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/network-e8d6.appspot.com/o/assets%2Fdefaultcover.jpg?alt=media&token=59978359-473d-4e72-a286-5cfe7da096ca',


    };
  }

}

class NoticeModel{


  late final String id;
  late final String nomGivers;
  late final String pnomGivers;
  String? comment;
  late final String dateExp;
  String? datePub;
  String? noteExp;



  NoticeModel({
    required this.id,
    //Personal info
    required this.nomGivers,
    required this.pnomGivers,
    this.comment,
    required this.dateExp,
    this.datePub,
    this.noteExp


  });

  NoticeModel.fromJson(Map<dynamic, dynamic> data ){
    id = data['id'];

    nomGivers = data['nomGivers'];
    pnomGivers = data['pnomGivers'];

    comment = data['comment'];

    dateExp = data['dateExp'];
    datePub = data['datePub'];

    noteExp = data['noteExp'];

  }

  toJson(){
    return{

      'id': id,

      'nomGivers': nomGivers,
      'pnomGivers': pnomGivers,
      'comment': comment,
      'dateExp': dateExp,
      'datePub': datePub,
      'noteExp': noteExp,

    };
  }

}

class ChipData {
  // an id is useful when deleting chip
  final String id;
  final String name;
  ChipData({required this.id, required this.name});
}