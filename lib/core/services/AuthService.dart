import 'package:firebase_auth/firebase_auth.dart';

import '../config/locator.dart';
import '../models/users_model.dart';
import 'fireUserService.dart';

class AuthenticationService{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FireUserService _firestoreService = locator<FireUserService>();

  //Stream
  UserModel? _userfromFirebaseUser(User? user){
    return user != null? UserModel(id: user.uid) : null;
  }
  Stream<UserModel?> get user{
    return _firebaseAuth.authStateChanges().map(_userfromFirebaseUser);
  }

  //Register With Email
  Future RegisterWithEmail({

    required String email,
    required String password,

  }) async {

    try {

      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create a new user profile on firestore
      await _firestoreService.createUser(
          UserModel(
              id: authResult.user!.uid,
              email: email
          )
      );

      return authResult.user != null;

    } catch (e) {
      return e;
    }

  }

  //Login With Email
  Future LoginWithEmail({

    required String email,
    required String password,

  }) async {

    try {

      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return authResult != null;

    } catch (e) {
      return e;
    }

  }

}

