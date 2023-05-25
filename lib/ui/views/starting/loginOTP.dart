import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:network/core/config/routesName.dart';
import 'package:network/ui/config/style.dart';

import '../../config/size.dart';
import '../../widgets/buttons.dart';

class LoginOTPView extends StatelessWidget{


  final TextEditingController adressEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              IconBtn(
                press: (){
                  Navigator.pop(context);
                },
                icon: Icon(FontAwesomeIcons.arrowLeftLong, size: 16,),
                couleur: couleurTertiaire,
              ),// GoBackBtn
              SizedBox(height: SizeConfig.screenHeight * 0.03), // 5%
              const Text("Content de vous revoir", style: heading1Style,),
              SizedBox(height: SizeConfig.screenHeight * 0.01),
              const Text(
                "Continuez avec l'adresse mail",
                style: paragraphStyle,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Form(
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(FontAwesomeIcons.envelope, color: couleurTertiaire,),
                          hintText: 'nom@mail.com',
                          labelText: 'Votre adresse email',
                        ),
                        controller: adressEmail,
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.03),
                      SubmitButton(
                        title: 'Se connecter',
                        onPressed: () {
                          Navigator.pushNamed(context, OTPViewRoute);
                        },
                      )
                    ],
                  )
              ),
              SizedBox(height: getProportionateScreenHeight(50)),
              Center(
                child: const TermConditionText(),
              )
            ],
          ),
        ),
      ),
    );

  }

}