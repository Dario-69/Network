class UserModel{

  late final String id;
  String? email;
  String? nom;
  String? prenom;
  String? phoneNumber;

  UserModel({
    required this.id,
    this.email,
    //Personal info
    this.nom,
    this.prenom,
    this.phoneNumber,
    //this.memberSince,

  });

  UserModel.fromJson(Map<dynamic, dynamic> data ){
    id = data['uid'];
    email = data['email'];
    nom = data['nom'];
    prenom = data['prenom'];
    phoneNumber = data['phoneNumber'];
    //memberSince = data['memberSince'].toString();

  }

  toJson(){
    return{

      'id': id,
      'email': email,
      'nom': nom,
      'prenom': prenom,
      'phoneNumber': phoneNumber,
      //'memberSince': memberSince,
    };
  }
}
