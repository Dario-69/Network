import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:network/core/config/routesName.dart';
import 'package:network/ui/config/style.dart';
import 'package:network/ui/widgets/buttons.dart';
import 'package:network/ui/widgets/opinion.dart';

import '../../config/size.dart';

class MyShopView extends StatelessWidget{
  const MyShopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: couleurPrincipale,
              height: 300,
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  children: [
                    IconBtn(
                      press: (){
                        Navigator.pop(context);
                      },
                      couleur: couleurSecondaire,
                      icon: const Icon(FontAwesomeIcons.arrowLeftLong, size: 15,),
                    ),
                    const Spacer(),
                    IconBtn(
                      press: (){
                        Navigator.pushNamed(context, EditShopViewRoute);
                      },
                      couleur: couleurSecondaire,
                      icon: const Icon(FontAwesomeIcons.penToSquare, size: 15,),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Categorie', style: paragraphStyle,),
                  const Text('Nom', style: h1Style,),
                  const Text('Description', style: paragraphStyle,),
                  const Divider(),
                  const Text('Informations pratiques', style: heading1Style,),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        children: const [
                          Icon(FontAwesomeIcons.mapPin, size: 16, color: couleurPrincipale,),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Text('Adresse'),
                        ],
                      ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      children: const [
                        Icon(FontAwesomeIcons.phone, size: 16, color: couleurPrincipale,),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Text('Adresse'),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(FontAwesomeIcons.calendar, size: 16, color: couleurPrincipale,),
                            Padding(padding: EdgeInsets.only(left: 20)),
                            Text('Nos horaires'),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(5)),
                        const Text('Lundi, Mardi, Mercredi, Jeudi, Vendredi, Samedi, Dimanche', style: paragraph2Style,),
                        SizedBox(height: getProportionateScreenHeight(5)),
                        const Text('De 08:00 à 17:00', style: paragraph2Style,),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  const Text('Produits', style: heading1Style,),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text('Produits list', style: paragraphStyle,),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  const Text('Services', style: heading1Style,),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text('Produits list', style: paragraphStyle,),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  const Text('Photos', style: heading1Style,),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  //Row Photos
                  const Divider(),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  const Text('Avis', style: heading1Style,),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  const opinion(
                    nom: 'Abalo',
                    pnom: 'Aimé',
                    comm: 'Belle expérience',
                    datepub: '29/06/2022',
                    datexp: '26/06/2022',
                  ),
                  SizedBox(height: getProportionateScreenHeight(5)),
                  Center(
                    child: OutlinedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, NoticeViewRoute);
                      },
                      style: AutreAvisBtn,
                      child: const Text('Voir d\'autres avis'),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                ],
              ),
            ),
          ],
        ),
      )
    );
    
  }
  
}