import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '../../../core/config/locator.dart';
import '../../../core/viewmodels/discoverVM.dart';
import '../../config/size.dart';
import '../../config/style.dart';
import '../../widgets/itembtn.dart';
import '../activityContent/storeDetails.dart';

class ReseauView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final db = FirebaseFirestore.instance;
    var FirebaseUser = FirebaseAuth.instance.currentUser!.uid;


    return ViewModelBuilder<DiscoverVM>.reactive(
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        viewModelBuilder: () => locator<DiscoverVM>(),
      builder: (context, model, child) => Scaffold(
      appBar: AppBar(
        title: const Text('Mon réseau', style: heading3Style,),
        automaticallyImplyLeading: false,
        backgroundColor: couleurPrincipale,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
              height: SizeConfig.screenHeight,
              child: StreamBuilder<QuerySnapshot>(
                stream: db.collection('stores').where("fav", arrayContains: FirebaseUser).snapshots(),
                builder: (BuildContext context, snapshot){
                  if (!snapshot.hasData){
                    return const Center(
                      child: CircularProgressIndicator(
                        color: couleurPrincipale,
                      ),
                    );
                  } else {
                    return ListView(
                      //scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(7),
                      children: snapshot.data!.docs.map((doc){
                        return FirstItem(
                          child: Row(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: SvgPicture.asset('assets/images/onboard.svg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(doc["nom"].toString(), style: heading2Style,),
                                    Text(doc["category"].toString(), style: paragraphStyle,),
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


                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => StoreDetailsView(item: docToMap )));

                          },
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.03),

          ],
        ),
      ),
    )
    );

  }

}