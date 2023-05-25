import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:network/ui/config/style.dart';
import 'package:network/ui/widgets/opinion.dart';

import '../../config/size.dart';
import '../../widgets/buttons.dart';

class NoticeView extends StatelessWidget{
  final Map<String, dynamic> item;

  const NoticeView({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tous les avis', style: heading2Style,),
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeftLong, size: 12,),
          onPressed: (){
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: couleurQuaternaire,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('stores').doc(item['id']).collection('notices').snapshots(),
        builder: (BuildContext context, snapshot){
          if (!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(
                color: couleurPrincipale,
              ),
            );
          } else {
            return ListView(
              padding: const EdgeInsets.all(5),
              children: snapshot.data!.docs.map((doc){
                return opinion(
                  comm: doc["comment"],
                  datexp: doc["dateExp"],
                  datepub: doc["datePub"].toString(),
                  nom: doc["nomGivers"],
                  pnom: doc["pnomGivers"],
                  note: doc["noteExp"],
                );
              }).toList(),
            );
          }
        },
      ),
    );

  }

}
