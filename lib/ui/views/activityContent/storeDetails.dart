import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:network/core/config/routesName.dart';
import 'package:network/core/models/stores_model.dart';
import 'package:network/core/viewmodels/discoverVM.dart';
import 'package:network/ui/views/mainContent/reseau.dart';
import 'package:network/ui/views/pages/notice.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/config/locator.dart';
import '../../../core/services/NavigationService.dart';
import '../../../core/services/fireUserService.dart';
import '../../config/size.dart';
import '../../config/style.dart';
import '../../widgets/buttons.dart';
import '../../widgets/opinion.dart';

class StoreDetailsView extends StatelessWidget{
  final Map<String, dynamic> item;
  late StoreModel store;

  StoreDetailsView({Key? key, required this.item}) : super(key: key);

  final NavigationService _navigationService = locator<NavigationService>();
  final FireUserService _firestoreService = locator<FireUserService>();
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  String? currentUserNom;
  String? currentUserPnom;
  void showDisplayName() async {
    var collection = FirebaseFirestore.instance.collection('users');
    //userUid is the current auth user
    var docSnapshot = await collection.doc(firebaseUser?.uid).get();

    Map<String, dynamic> data = docSnapshot.data()!;

    currentUserNom = data['nom'];
    currentUserPnom = data['prenom'];
  }

  final commentController = TextEditingController();
  final dateExpController = TextEditingController();
  String valueChanged3 = '';
  double noteExperience = 0.0;

  @override
  Widget build(BuildContext context) {

    Image profil = Image.network('${item["imageUrl"]}');
    Uri appelMoi = Uri.parse('tel://${item["phoneNumber"]}');
    final List<dynamic> lesproduits = item['products'];
    final List<dynamic> lesServices = item['services'];
    final List<dynamic> lesDays = item['days'];

    showDisplayName();

      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                //color: couleurPrincipale,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: profil.image,
                    fit: BoxFit.cover
                  )
                ),
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
                          //Navigator.pushNamed(context, EditShopViewRoute);
                        },
                        couleur: couleurSecondaire,
                        icon: const Icon(FontAwesomeIcons.share, size: 15,),
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
                    Text('${item["category"]}', style: paragraphStyle,),
                    Text('${item["nom"]}', style: h1Style,),
                    Text('${item["description"]}', style: paragraphStyle,),
                    const Divider(),
                    SizedBox(height: getProportionateScreenHeight(5)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconBtn(
                          couleur: couleurPrincipale,
                          icon: const Icon(FontAwesomeIcons.message, size: 14, color: couleurSecondaire,),
                          press: () async {

                            Uri url = Uri.parse('whatsapp://send?phone=${item["phoneNumber"]}&text=hello');

                           if(await canLaunchUrl(url)){
                              await launchUrl(url);
                            }else {

                             throw 'Could not launch $url';
                           }


                          },
                        ),
                        IconBtn(
                          couleur: couleurTertiaire,
                          icon: const Icon(FontAwesomeIcons.phone, size: 14, color: couleurPrincipale,),
                          press: ()=> launchUrl(appelMoi),
                        ),
                        IconBtn(
                          couleur: couleurTertiaire,
                          icon: const Icon(FontAwesomeIcons.locationArrow, size: 14, color: couleurPrincipale,),
                          press: (){},
                        ),
                        IconBtn(
                          couleur: couleurPrincipale,
                          icon: const Icon(FontAwesomeIcons.heart, size: 14, color: couleurSecondaire,),
                          press: () async {
                            await firestoreInstance.collection('stores').doc(item['id']).update(
                              {
                                'fav': FieldValue.arrayUnion([firebaseUser!.uid])
                              }
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(5)),
                    const Divider(),
                    const Text('Informations pratiques', style: heading1Style,),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    /*
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
                    */
                    SizedBox(height: getProportionateScreenHeight(15)),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        children: [
                          const Icon(FontAwesomeIcons.phone, size: 16, color: couleurPrincipale,),

                          const Padding(padding: EdgeInsets.only(left: 20)),
                          Text('${item["phoneNumber"]}'),
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
                          Wrap(
                            spacing: 6,
                            runSpacing: 0,
                            children: lesDays
                            .map((chip) => Chip(
                              label: Text(chip.toString(), style: const TextStyle(color: couleurSecondaire),),
                              backgroundColor: couleurPrincipale,
                            )).toList(),
                          ),
                          SizedBox(height: getProportionateScreenHeight(5)),
                          Row(
                            children: [
                              const Icon(FontAwesomeIcons.clock, size: 16, color: couleurPrincipale,),
                              SizedBox(width: getProportionateScreenWidth(10),),
                              const Text("De ", style: paragraph2Style,),
                              Text('${item['opening']}', style: const TextStyle(color: couleurPrincipale), ),
                              const Text(" à ", style: paragraph2Style,),
                              Text('${item['closure']}', style: const TextStyle(color: couleurPrincipale), ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    const Text('Produits', style: heading1Style,),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      //child: Text('${item['products']}', style: paragraphStyle,),
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 0,
                        children: lesproduits
                        .map((chip) => Chip(
                          label: Text(chip.toString(), style: const TextStyle(color: couleurSecondaire),),
                          backgroundColor: couleurPrincipale,
                        )).toList(),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    const Text('Services', style: heading1Style,),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 0,
                        children: lesServices
                        .map((chip) => Chip(
                          label: Text(chip.toString(), style: const TextStyle(color: couleurSecondaire),),
                          backgroundColor: couleurPrincipale,
                        )).toList(),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    //const Text('Photos', style: heading1Style,),
                    //SizedBox(height: getProportionateScreenHeight(15)),
                    //Row Photos
                    const Divider(),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    const Text('Avis', style: heading1Style,),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    /*
                    const opinion(
                      nom: 'Abalo',
                      pnom: 'Aimé',
                      comm: 'Belle expérience',
                      datepub: '29/06/2022',
                      datexp: '26/06/2022',
                    ),
                    */
                    Center(
                      child: Column(
                        children: [
                          OutlinedButton(
                            style: AutreAvisBtn,
                            onPressed: (){

                              Map<String, dynamic> docToMap = {};
                              docToMap["id"] = item['id'];
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoticeView(item: docToMap )));

                            },
                            child: const Text('Tous les avis'),
                          ),
                          OutlinedButton(
                            style: AutreAvisBtn,
                            onPressed: (){
                              showStickyFlexibleBottomSheet(
                                minHeight: 0,
                                initHeight: 0.8,
                                maxHeight: 1,
                                headerHeight: 50,
                                context: context,
                                bottomSheetColor: couleurSecondaire,
                                headerBuilder: (BuildContext context, double bottomSheetOffset){
                                  return const Center(
                                    child: Text('Donner un avis'),
                                  );
                                },
                                bodyBuilder: (BuildContext context, double bottomSheetOffset) {

                                  return SliverChildListDelegate(
                                      <Widget>[
                                        Form(
                                            child: Padding(
                                              padding: const EdgeInsets.all(14),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text('${item["nom"]}', style: heading1Style,),
                                                  Text('${item["category"]}', style: paragraphStyle,),
                                                  SizedBox(height: getProportionateScreenHeight(20)),
                                                  DateTimePicker(
                                                      type: DateTimePickerType.date,
                                                      controller: dateExpController,
                                                      firstDate: DateTime(1960),
                                                      lastDate: DateTime.now(),
                                                      decoration: const InputDecoration(
                                                        prefixIcon: Icon(Icons.calendar_today_outlined),
                                                        hintText: "la date de votre experience ?",
                                                        hintStyle: TextStyle(color: Colors.grey),
                                                        //suffixIcon: Icon(Icons.cake_outlined),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.grey, width: 1),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: couleurPrincipale, width: 1),
                                                        ),
                                                      ),
                                                      locale: const Locale('fr', 'FR'),
                                                      onChanged: (val) =>  valueChanged3 = val
                                                  ),
                                                  SizedBox(height: getProportionateScreenHeight(20)),
                                                  const Text('Qu\'avez-vous pensez de votre expérience ?', style: paragraphStyle,),
                                                  SizedBox(height: getProportionateScreenHeight(10)),
                                                  Center(
                                                    child: RatingBar(
                                                      emptyColor: couleurTertiaire,
                                                      filledIcon: FontAwesomeIcons.circleCheck,
                                                      emptyIcon: FontAwesomeIcons.circle,
                                                      //onRatingChanged: (value) => debugPrint('$value'),
                                                      onRatingChanged: (value) => noteExperience = value,
                                                      initialRating: 0,
                                                      maxRating: 6,
                                                      filledColor: couleurPrincipale,
                                                      alignment: Alignment.center,
                                                    ),
                                                  ),
                                                  SizedBox(height: getProportionateScreenHeight(20)),
                                                  TextFormField(
                                                    controller: commentController,
                                                    minLines: 2,
                                                    maxLines: 6,
                                                    keyboardType: TextInputType.multiline,
                                                    decoration: InputDecoration(
                                                        hintText: 'Ajoutez un commentaire',
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: const BorderSide(width: 1, color: couleurTertiaire),
                                                          borderRadius: BorderRadius.circular(15),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: const BorderSide(width: 1, color: couleurPrincipale),
                                                          borderRadius: BorderRadius.circular(15),
                                                        )),
                                                  ),
                                                  SizedBox(height: getProportionateScreenHeight(15)),
                                                  SubmitButton(title: 'Enregistrer', onPressed: () async {

                                                    await firestoreInstance.collection('stores').doc(item['id']).collection('notices').doc().set({
                                                      'comment' : commentController.text,
                                                      'dateExp' : dateExpController.text,
                                                      'datePub' : DateTime.now().toString(),
                                                      'noteExp' : noteExperience,
                                                      'nomGivers' : currentUserNom,
                                                      'pnomGivers' : currentUserPnom,
                                                    }).then((_) {
                                                      _navigationService.pop();
                                                      commentController.clear();
                                                    });

                                                  })

                                                ],
                                              ),
                                            )
                                        )
                                      ]
                                  );

                                },

                              );
                            },
                            child: const Text('Donnez un avis'),
                          )
                        ],
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

