import 'dart:ffi';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:network/ui/config/style.dart';

import '../config/size.dart';

class opinion extends StatelessWidget{

  final String? nom, pnom, comm, datepub, datexp;
  final double? note;

  const opinion({super.key, this.nom, this.pnom, this.comm, this.datepub, this.datexp, this.note});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(15),
      color: couleurTertiaire,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(FontAwesomeIcons.user, color: couleurQuaternaire,),
              const Padding(padding: EdgeInsets.only(left: 10)),
              Text('${nom!} ${pnom!}', style: heading2Style,),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          Text(comm!, style: const TextStyle(fontSize: 13),),
          Row(children: [
            Text('Noté '),
            Text('$note', style: TextStyle(color: couleurPrincipale)),
            Text('/6.0'),
          ]),
          SizedBox(height: getProportionateScreenHeight(15)),
          Row(
            children: [
              const Text('Expérience du '),
              Text(datexp!, style: const TextStyle(color: couleurPrincipale, fontSize: 11),),
              const Spacer(),
              Text(datepub!, style: const TextStyle(color: couleurQuaternaire, fontSize: 11),)
            ],
          )
        ],
      ),

    );

  }

}