import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:network/core/config/routesName.dart';
import 'package:network/ui/config/style.dart';
import 'package:network/ui/widgets/buttons.dart';
import 'package:provider/provider.dart';

import '../../../core/models/users_model.dart';
import '../../config/size.dart';
import '../mainContent/home.dart';

class OnboardView extends StatelessWidget{
  const OnboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel?>(context);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SizeConfig().init(context);

    if (user == null){
      return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight * 0.03),
                      Center(
                        child: SvgPicture.asset('assets/images/onboard.svg', width: 300,),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.04),
                      SvgPicture.asset('assets/brand/naming.svg', width: 120,),
                      SizedBox(height: SizeConfig.screenHeight * 0.03),
                      const Center(
                        child: Text('Trouvez de bon commerces où faire nos achats', style: paragraphStyle, textAlign: TextAlign.center, ),
                      )
                    ],
                  )
              ),
              Positioned(
                  bottom: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pushNamed(context, RegisterViewRoute);
                        },
                        style: primaryBtn,
                        child: const Text(
                          'Commencer',
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pushNamed(context, LoginViewRoute);
                        },
                        style: secondaryBtn,
                        child: const Text(
                          'Connexion',
                          style: TextStyle(color: couleurPrincipale),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.04),

                    ],
                  )
              )
            ],
          )
      );
    }else{
      return HomeView();
    }



  }

}