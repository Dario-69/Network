import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:network/core/config/routesName.dart';
import 'package:network/core/models/stores_model.dart';
import 'package:network/ui/config/style.dart';
import 'package:network/ui/widgets/buttons.dart';

import '../../../core/config/locator.dart';
import '../../../core/services/NavigationService.dart';
import '../../../core/services/fireUserService.dart';
import '../../config/size.dart';
import '../../widgets/itembtn.dart';

class ProfileView extends StatelessWidget{

  final firestoreInstance = FirebaseFirestore.instance;
  var FirebaseUser = FirebaseAuth.instance.currentUser;

  final NavigationService _navigationService = locator<NavigationService>();

  ProfileView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: firestoreInstance.collection('users').doc(FirebaseUser?.uid).snapshots(),
        builder: (context, streamSnapshot) {
          if(streamSnapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(
                color: couleurPrincipale,
              ),
            );
          }
          else{
            return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: couleurPrincipale,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: SvgPicture.asset('assets/brand/logo_blanc.svg', width: 20,),
                  ),
                  actions: [
                    /*
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: IconBtn(
                        couleur: couleurSecondaire,
                        icon: const Icon(FontAwesomeIcons.gear, size: 10, color: couleurPrincipale,),
                        press:(){
                          Navigator.pushNamed(context, ParamViewRoute);
                        },
                      ),
                    )
                    */
                    IconButton(
                        icon: const Icon(FontAwesomeIcons.gear, size: 16, color: couleurSecondaire,),
                        onPressed: () {
                          Navigator.pushNamed(context, ParamViewRoute);
                        }
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Mon profil', style: paragraphStyle, ),
                          Row(
                            children: [
                              Text(streamSnapshot.data!['nom'] + ' ' + streamSnapshot.data!['prenom'] , style: heading1Style,),
                              const Spacer(),
                              IconButton(
                                  onPressed: (){
                                    Navigator.pushNamed(context, EditProfilViewRoute);
                                  },
                                  icon: const Icon(FontAwesomeIcons.penToSquare, size: 16, color: couleurPrincipale,))
                            ],
                          ),
                          const Text('Numéro de téléphone', style: paragraphStyle,),
                          Text(streamSnapshot.data!['phoneNumber'],),
                          const Padding(padding: EdgeInsets.all(5)),
                          const Text('Adresse Email', style: paragraphStyle,),
                          Text(streamSnapshot.data!['email'],),
                          const Padding(padding: EdgeInsets.all(5)),
                          const Text('Membre depuis', style: paragraphStyle,),
                        //Text(streamSnapshot.data!['memberSince'].toString(),),
                          Row(
                            children: [

                              Text((FirebaseUser?.metadata.creationTime?.day).toString()),
                              Text(" - "),
                              Text((FirebaseUser?.metadata.creationTime?.month).toString()),
                              Text(" - "),
                              Text((FirebaseUser?.metadata.creationTime?.year).toString())
                            ],
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          const Divider(),
                          const Padding(padding: EdgeInsets.all(5)),
                          Row(
                            children: [
                              const Text('Mes établissements', style: paragraphStyle, ),
                              const Spacer(),
                              IconBtn(
                                icon: const Icon(FontAwesomeIcons.plus, size: 14, color: couleurSecondaire,),
                                couleur: couleurPrincipale,
                                press: ()  {
                                  _navigationService.navigateTo(CreateShopViewRoute);
                                },
                              )
                            ],
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          SizedBox(
                              //padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
                              height: 310,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: firestoreInstance.collection('stores').where("propId", isEqualTo: FirebaseUser?.uid).snapshots(),
                                builder: (BuildContext context, snapshot){
                                  if (!snapshot.hasData){
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: couleurPrincipale,
                                      ),
                                    );
                                  } else {
                                    return ListView(
                                      //padding: const EdgeInsets.all(5),
                                      children: snapshot.data!.docs.map((doc){
                                        return FirstItem(
                                          child: Row(
                                            children: [
                                              //SvgPicture.asset('assets/images/onboard.svg', width: 100,),
                                              Image.network( doc["imageUrl"].toString(),width: 100),
                                              Padding(padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(4))),
                                              Expanded(
                                                flex: 8,
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(doc["nom"].toString(), style: heading2Style,),
                                                      Text(doc["category"].toString(), style: paragraphStyle,)
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }
                                },
                              )
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 10)),

                        ],
                      ),
                    )
                )
            );

          }
        },
      ),
    );

  }

}