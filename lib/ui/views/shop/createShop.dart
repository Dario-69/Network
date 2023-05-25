import 'package:address_search_field/address_search_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:network/ui/config/size.dart';
import 'package:network/ui/config/style.dart';
import 'package:network/ui/views/shop/completeShopInfo.dart';
import 'package:network/ui/widgets/buttons.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:stacked/stacked.dart';

import '../../../core/config/locator.dart';
import '../../../core/config/routesName.dart';
import '../../../core/models/stores_model.dart';
import '../../../core/services/NavigationService.dart';
import '../../../core/services/fireUserService.dart';
import '../../../core/viewmodels/createVM.dart';

class CreateShopView extends StatefulWidget{
  const CreateShopView({Key? key}) : super(key: key);

  @override
  CreateShopState createState() => CreateShopState();

}

class CreateShopState extends State<CreateShopView>{

  //FireBase
  final firestoreInstance = FirebaseFirestore.instance;
  var FirebaseUser = FirebaseAuth.instance.currentUser;

  //Service
  final FireUserService _firestoreService = locator<FireUserService>();
  final NavigationService _navigationService = locator<NavigationService>();

  //Geo
  Coords? coords;
  Address? initialAddress;

  //Categorie
  final List<Map<String, dynamic>> _Categorie_items = [
    {
      'value': 'Boutique',
      'label': 'Boutique',
    },
    {
      'value': 'Restaurant',
      'label': 'Restaurant',
    },
  ];
  late String storeCategory = '';


  //Controller
  final nomController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final adressController = TextEditingController();
  var updatedPhone;



  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<CreateVM>.reactive(
      viewModelBuilder: () => CreateVM(),
      builder: (context, model, child) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: couleurTertiaire,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: IconBtn(
            couleur: couleurQuaternaire,
            icon: const Icon(FontAwesomeIcons.arrowLeftLong, size: 16, color: Colors.black,),
            press: (){
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text('Créer un établissement', style: TextStyle(color: couleurPrincipale, fontSize: 13)),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Informations principales', style: heading1Style,),
              SizedBox(height: getProportionateScreenHeight(10)),
              TextFormField(
                controller: nomController,
                decoration: InputDecoration(
                    hintText: 'Nom de l\'établissement',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: couleurTertiaire),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: couleurPrincipale),
                      borderRadius: BorderRadius.circular(15),
                    )),
                ),
              SizedBox(height: getProportionateScreenHeight(10)),
              SelectFormField(
                controller: categoryController,
                type: SelectFormFieldType.dropdown, // or can be dialog
                //initialValue: 'circle',
                items: _Categorie_items,
                onChanged: (val) => val,
                onSaved: (val) => storeCategory,
                decoration: InputDecoration(
                    hintText: 'Catégorie de l\'établissement',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: couleurTertiaire),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: couleurPrincipale),
                      borderRadius: BorderRadius.circular(15),
                    )),
                ),
              SizedBox(height: getProportionateScreenHeight(10)),
              TextFormField(
                controller: descriptionController,
                minLines: 2,
                maxLines: 6,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: 'Description de l\'établissement',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: couleurTertiaire),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: couleurPrincipale),
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              IntlPhoneField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  hintText: 'Numéro de téléphone de l\'établissement',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: couleurTertiaire),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: couleurPrincipale),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                initialCountryCode: 'TG',
                onChanged: (phone){
                  updatedPhone = phone.completeNumber;
                  //when phone number country code is changed
                  (phone.completeNumber); //get complete number
                  (phone.countryCode); // get country code only
                  (phone.number); // only phone number
                },
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              /*
              TextFormField(
                controller: adressController,
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AddressSearchDialog(
                    controller: adressController,
                    geoMethods: geoMethods,
                    onDone: (Address address) => initialAddress = address,
                  ),
                ),
                decoration: InputDecoration(
                    hintText: 'L\'adresse de l\'établissement',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: couleurTertiaire),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: couleurPrincipale),
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              */
              const Divider(),
              SizedBox(height: getProportionateScreenHeight(10)),
              SubmitButton(
                  title: 'Suivant',
                  onPressed: () async {
                    String storeId = FirebaseFirestore.instance.collection('stores').doc().id;
                    await _firestoreService.createShop(
                        StoreModel(
                          propId: FirebaseUser!.uid,
                          //id: FirebaseFirestore.instance.collection('stores').,
                          id: storeId,
                          nom: nomController.text,
                          category: categoryController.text,
                          description: descriptionController.text,
                          phoneNumber: updatedPhone,
                        )
                    ).then((_){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CompleteShopInfoView(idStore: storeId)));

                      //_navigationService.navigateTo(CompleteShopInfoRoute);
                    });
                  }
              )
            ],
          ),
        ),
      ),
    )
    );

  }

}

