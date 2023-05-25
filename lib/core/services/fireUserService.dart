import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:network/core/models/stores_model.dart';
import '../models/users_model.dart';

class FireUserService{

  final CollectionReference _usersCollectionReference = FirebaseFirestore.instance.collection('users');
  final CollectionReference _storeCollectionReference = FirebaseFirestore.instance.collection('stores');

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  //Create User
  Future createUser(UserModel user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      return e;
    }
  }

  //Create Shop
  Future createShop(StoreModel store) async {
    try {
      await _storeCollectionReference.doc(store.id).set(store.toJson());
    } catch (e) {
      return e;
    }
  }

  /*Ajout de commentaire
  Future<void> ajoutCommentaire(uId, nom, prenom, msgCmtr) async {
    String idCmtr = _commentaireCollectionReference.doc().id;
    return await _commentaireCollectionReference.doc(msgCmtr)
        .collection('notices').doc(idCmtr).set({
      'idCmtr' : idCmtr,
      'uId' : uId,
      'nom' : nom,
      'prenom' : prenom,
      'msgCmtr' : msgCmtr,
      'timestamp' : FieldValue.serverTimestamp()
    });
  }

   */
  Future addFavorite(StoreModel store) async {
    try {
      await _storeCollectionReference.doc(store.id).update(store.toJson());
    } catch (e) {
      return e;
    }
  }
}