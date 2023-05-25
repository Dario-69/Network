
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:network/core/viewmodels/baseModel.dart';

import '../config/locator.dart';
import '../services/NavigationService.dart';

class EditVM extends BaseModel{

  final NavigationService _navigationService = locator<NavigationService>();
  final firestoreInstance = FirebaseFirestore.instance;

  Future UpdateProfile({

    required String Firstname,
    required String Lastname,
    required String PhoneNumber,

  }) async {

    setBusy(true);

    var FirebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.collection('users').doc(FirebaseUser?.uid).update({
      "nom": Lastname, "prenom": Firstname, "phoneNumber": PhoneNumber,
    }).then((_) {
      _navigationService.pop();
    });

    setBusy(false);

  }

}