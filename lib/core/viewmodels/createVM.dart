import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:network/core/models/stores_model.dart';
import 'package:network/core/viewmodels/baseModel.dart';

import '../config/locator.dart';
import '../config/routesName.dart';
import '../services/NavigationService.dart';

class CreateVM extends BaseModel{

  final NavigationService _navigationService = locator<NavigationService>();
  final firestoreInstance = FirebaseFirestore.instance;


  StoreModel? _storeID;
  StoreModel? get id => _storeID;



  //Create User Account or Profile
  Future CreateProfile({
    required String Firstname,
    required String Lastname,
    required String PhoneNumber,

  }) async {

    setBusy(true);

    var FirebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.collection('users').doc(FirebaseUser?.uid).update({
      "nom": Lastname, "prenom": Firstname, "phoneNumber": PhoneNumber,
    }).then((_) {
      _navigationService.navigateTo(HomeViewRoute);
    });

    setBusy(false);

    //_navigationService.navigateTo(WelcomeViewRoute);

  }


}

