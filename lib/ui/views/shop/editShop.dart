import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../config/size.dart';
import '../../config/style.dart';
import '../../widgets/buttons.dart';

class EditShopView extends StatelessWidget{

  final List<Map<String, dynamic>> _Categorie_items = [
    {
      'value': 'boutique',
      'label': 'Boutique',
    },
    {
      'value': 'restaurant',
      'label': 'Restaurant',
    },
  ];

  final TextEditingController phoneNumber = TextEditingController();
  var updatedPhone;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: couleurTertiaire,
        leading: Padding(
          padding: EdgeInsets.all(12),
          child: IconBtn(
            couleur: couleurQuaternaire,
            icon: const Icon(FontAwesomeIcons.arrowLeftLong, size: 16, color: Colors.black,),
            press: (){
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text('Modifier mon établissement', style: TextStyle(color: couleurPrincipale, fontSize: 13)),
        actions: const [
          Padding(
            padding: EdgeInsets.all(12),
            child: IconBtn(
              icon: Icon(FontAwesomeIcons.check, size: 16, color: couleurSecondaire,),
              couleur: couleurPrincipale,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Informations principales'),
              SizedBox(height: getProportionateScreenHeight(10)),
              TextFormField(
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
                type: SelectFormFieldType.dropdown, // or can be dialog
                initialValue: '',
                items: _Categorie_items,
                onChanged: (val) => print(val),
                onSaved: (val) => print(val),
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
              const Text('Informations pratiques'),
              SizedBox(height: getProportionateScreenHeight(10)),
              TextFormField(
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
              SizedBox(height: getProportionateScreenHeight(10)),
              IntlPhoneField(
                controller: phoneNumber,
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
                  updatedPhone = phone.completeNumber.replaceAll('+', '');
                  //when phone number country code is changed
                  (phone.completeNumber); //get complete number
                  (phone.countryCode); // get country code only
                  (phone.number); // only phone number
                },
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              TextFormField(
                minLines: 1,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: 'Les produits de l\'établissement',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: couleurTertiaire),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: couleurPrincipale),
                      borderRadius: BorderRadius.circular(15),
                    )
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              TextFormField(
                minLines: 1,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: 'Les services (facultatif)',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: couleurTertiaire),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: couleurPrincipale),
                      borderRadius: BorderRadius.circular(15),
                    )
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              const Text('Les horaires de l\'établissement', style: paragraphStyle,),
              SizedBox(height: getProportionateScreenHeight(10)),

              SizedBox(height: getProportionateScreenHeight(10)),
              Divider(),
              SizedBox(height: getProportionateScreenHeight(10)),
              SubmitButton(title: 'Save', onPressed: (){})
            ],
          ),
        ),
      ),
    );

  }


}