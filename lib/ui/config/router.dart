import 'package:flutter/material.dart';
import 'package:network/ui/views/activityContent/storeDetails.dart';
import 'package:network/ui/views/pages/notice.dart';
import 'package:network/ui/views/shop/createShop.dart';
import 'package:network/ui/views/shop/editShop.dart';
import 'package:network/ui/views/shop/myShop.dart';
import 'package:network/ui/views/starting/loginOTP.dart';
import 'package:network/ui/views/starting/registerOTP.dart';

import '../../core/config/routesName.dart';
import '../views/activityContent/chat.dart';
import '../views/activityContent/editProfile.dart';
import '../views/mainContent/home.dart';
import '../views/pages/notifications.dart';
import '../views/pages/param.dart';
import '../views/searchContent/search.dart';
import '../views/shop/completeShopInfo.dart';
import '../views/starting/createProfile.dart';
import '../views/starting/login.dart';
import '../views/starting/loginOTP.dart';
import '../views/starting/onboard.dart';
import '../views/starting/otp.dart';
import '../views/starting/register.dart';
import '../views/starting/registerOTP.dart';

Route<dynamic> generateRoute(RouteSettings settings){

  switch (settings.name){

    case OnboardViewRoute:
      return _getPageRoute(
        viewToShow: OnboardView(),
      );

    //Login & Register OTP
    case LoginViewRoute:
      return _getPageRoute(
        viewToShow: LoginView(),
      );

    case RegisterViewRoute:
      return _getPageRoute(
        viewToShow: RegisterView(),
      );

    //Login & Register Email
    case LoginOTPViewRoute:
      return _getPageRoute(
        viewToShow: LoginOTPView(),
      );

    case RegisterOTPViewRoute:
      return _getPageRoute(
        viewToShow: RegisterOTPView(),
      );

    //OTP & Create account
    case OTPViewRoute:
      return _getPageRoute(
        viewToShow: OTPView(),
      );

    case CreateProfileViewRoute:
      return _getPageRoute(
        viewToShow:  CreateProfileView(),
      );

    //Home
    case HomeViewRoute:
      return _getPageRoute(
        viewToShow: const HomeView(),
      );

    //Pages
    case NotifsViewRoute:
      return _getPageRoute(
        viewToShow: NotifsView(),
      );

    case ParamViewRoute:
      return _getPageRoute(
        viewToShow: ParamView(),
      );

    case NoticeViewRoute:
      return _getPageRoute(
        viewToShow: const NoticeView(item: {},),
      );

   //Search
    case SearchViewRoute:
      return _getPageRoute(
        viewToShow: const SearchView(),
      );

    //Activity
    case ChatViewRoute:
      return _getPageRoute(
        viewToShow: ChatView(),
      );

    case StoreDetailsViewRoute:
      return _getPageRoute(
        viewToShow: StoreDetailsView(item: const {},),
      );

    case EditProfilViewRoute:
      return _getPageRoute(
        viewToShow: EditProfilView(),
      );

    //Shop
    case CreateShopViewRoute:
      return _getPageRoute(
        viewToShow: CreateShopView(),
      );

    case CompleteShopInfoRoute:
      return _getPageRoute(
        viewToShow: const CompleteShopInfoView(idStore: '',),
      );

    case EditShopViewRoute:
      return _getPageRoute(
        viewToShow: EditShopView(),
      );

    case MyShopViewRoute:
      return _getPageRoute(
        viewToShow: MyShopView(),
      );

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
                child: Text('No route defined for ${settings.name}')),
          ));
  }
}

PageRoute _getPageRoute({ required Widget viewToShow}) {

  return MaterialPageRoute(

      builder: (_) => viewToShow

  );
}