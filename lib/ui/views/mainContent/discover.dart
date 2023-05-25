
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:network/core/config/routesName.dart';
import 'package:network/ui/config/style.dart';
import 'package:network/ui/widgets/itembtn.dart';
import 'package:stacked/stacked.dart';

import '../../../core/config/locator.dart';
import '../../../core/viewmodels/discoverVM.dart';
import '../../config/size.dart';
import '../../widgets/buttons.dart';
import '../activityContent/storeDetails.dart';

class DiscoverView extends StatelessWidget{
  const DiscoverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final db = FirebaseFirestore.instance;

    return ViewModelBuilder<DiscoverVM>.reactive(
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        viewModelBuilder: () => locator<DiscoverVM>(),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: couleurPrincipale,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12,),
              child: SvgPicture.asset('assets/brand/logo_blanc.svg', width: 50,),
            ),
            /*
            actions: [
              IconButton(
                icon: const Icon(FontAwesomeIcons.bell, size: 16, color: couleurSecondaire,),
                onPressed: () {
                  Navigator.pushNamed(context, NotifsViewRoute);
                }
              ),
            ],
            */
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 40),
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 2),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SearchViewRoute);
                  },
                  style: OutLineBtn,
                  child: Row(
                    children: [
                      const Icon(FontAwesomeIcons.magnifyingGlass, size: 15, color: couleurSecondaire,),
                      Padding(padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5))),
                      const Text('Recherche', style: TextStyle(color: couleurSecondaire),)
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
                    child: const Text('Les commerces à proximité', style: heading2Style,)
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
                    height: 270.0,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: db.collection('stores').where("category", isEqualTo: 'Boutique').snapshots(),
                      builder: (BuildContext context, snapshot){
                        if (!snapshot.hasData){
                          return const Center(
                            child: CircularProgressIndicator(
                              color: couleurPrincipale,
                            ),
                          );
                        } else {
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(5),
                            children: snapshot.data!.docs.map((doc){
                              return FirstItem(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      width: 300,
                                      child: Image.network(
                                          doc["imageUrl"].toString(),
                                          fit: BoxFit.cover
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //Text('Ouvert'),
                                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                                          Text(doc["nom"].toString(), style: heading2Style,),
                                          Text(doc["category"].toString(), style: paragraphStyle,),
                                          //Text('Notes'),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                press: (){
                                  //print("one document");
                                  //print(doc.runtimeType);
                                  //print("name");
                                  //print(doc["nom"]);
                                  Map<String, dynamic> docToMap = {};
                                  docToMap["id"] = doc["id"];
                                  docToMap["nom"] = doc["nom"];
                                  docToMap["days"] = doc["days"];
                                  docToMap["category"] = doc["category"];
                                  docToMap["description"] = doc["description"];
                                  docToMap["phoneNumber"] = doc["phoneNumber"];
                                  docToMap["opening"] = doc["opening"];
                                  docToMap["closure"] = doc["closure"];
                                  docToMap["products"] = doc["products"];
                                  docToMap["services"] = doc["services"];
                                  docToMap["imageUrl"] = doc["imageUrl"];

                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => StoreDetailsView(item: docToMap )));

                                },
                              );
                            }).toList(),
                          );
                        }
                      },
                    )
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
                    child: const Text('Les restaurants recommandés', style: heading2Style,)
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
                    height: 270.0,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: db.collection('stores').where("category", isEqualTo: 'Restaurant').snapshots(),
                      builder: (BuildContext context, snapshot){
                        if (!snapshot.hasData){
                          return const Center(
                            child: CircularProgressIndicator(
                              color: couleurPrincipale,
                            ),
                          );
                        } else {
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(5),
                            children: snapshot.data!.docs.map((doc){
                              return FirstItem(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      width: 300,
                                      child: Image.network(
                                          doc["imageUrl"].toString(),
                                          fit: BoxFit.cover
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //Text('Ouvert'),
                                          Text(doc["nom"].toString(), style: heading2Style,),
                                          Text(doc["category"].toString(), style: paragraphStyle,),
                                          //Text('Notes'),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                press: (){

                                  Map<String, dynamic> docToMap = {};
                                  docToMap["id"] = doc["id"];
                                  docToMap["nom"] = doc["nom"];
                                  docToMap["days"] = doc["days"];
                                  docToMap["category"] = doc["category"];
                                  docToMap["description"] = doc["description"];
                                  docToMap["phoneNumber"] = doc["phoneNumber"];
                                  docToMap["opening"] = doc["opening"];
                                  docToMap["closure"] = doc["closure"];


                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => StoreDetailsView(item: docToMap )));

                                },
                              );
                            }).toList(),
                          );
                        }
                      },
                    )
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
              ],
            ),
          ),
        )
    );

  }

}