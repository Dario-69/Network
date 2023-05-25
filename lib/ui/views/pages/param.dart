import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:network/core/config/routesName.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/config/locator.dart';
import '../../../core/services/NavigationService.dart';
import '../../config/style.dart';
import '../../widgets/buttons.dart';
import '../../widgets/itembtn.dart';

class ParamView extends StatelessWidget{

  final Uri settingsLink1 = Uri.parse('https://datkominformatics.com');
  final NavigationService _navigationService = locator<NavigationService>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 12)),
              IconBtn(
                press: (){
                  Navigator.pop(context);
                },
                icon: Icon(FontAwesomeIcons.arrowLeftLong, size: 16,),
                couleur: couleurTertiaire,
              ),
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text('Paramètres', style: heading2Style,),
              )
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FirstItem(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: const [
                            Padding(padding: EdgeInsets.only(left: 12)),
                            Text('Button'),
                            Spacer(),
                            Icon(FontAwesomeIcons.arrowRight)
                          ],
                        ),
                      ),
                      press: () async {
                        Uri url = Uri.parse('https://datkominformatics.com');
                        if(await canLaunchUrl(url)){
                          await launchUrl(url);
                        }else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    FirstItem(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: const [
                            Padding(padding: EdgeInsets.only(left: 12)),
                            Text('Button'),
                            Spacer(),
                            Icon(FontAwesomeIcons.arrowRight)
                          ],
                        ),
                      ),
                    ),
                    FirstItem(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: const [
                            Padding(padding: EdgeInsets.only(left: 12)),
                            Text('Deconnexion'),
                            Spacer(),
                            Icon(FontAwesomeIcons.powerOff)
                          ],
                        ),
                      ),
                      press: () async {
                        await FirebaseAuth.instance.signOut().then((_) {
                          _navigationService.navigateTo(LoginViewRoute);
                        });
                      },
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );

  }


}