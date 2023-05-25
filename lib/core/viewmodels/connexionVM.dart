import 'package:flutter/cupertino.dart';
import 'package:network/core/config/locator.dart';
import 'package:network/core/services/AuthService.dart';
import 'package:network/core/services/NavigationService.dart';
import 'package:network/core/viewmodels/baseModel.dart';
import 'package:network/ui/views/starting/createProfile.dart';

import '../config/routesName.dart';

class ConnexionVM extends BaseModel{

  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  //Register With Email
  Future register({
    required String email,
    required String password,
  }) async { setBusy(true);

    var result = await _authenticationService.RegisterWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(CreateProfileViewRoute);
      } else {

      }
    }
    else {

    }

  }

  //Login With Email
  Future login({
    required String email,
    required String password,
  }) async {setBusy(true);

  var result = await _authenticationService.LoginWithEmail(
    email: email,
    password: password,
  );

  setBusy(false);

  if (result is bool) {
    if (result) {
      _navigationService.navigateTo(HomeViewRoute);
    } else {

    }
  }
  else {

  }

  }

}




