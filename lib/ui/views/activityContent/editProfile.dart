import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:stacked/stacked.dart';

import '../../../core/viewmodels/editVM.dart';
import '../../config/size.dart';
import '../../config/style.dart';
import '../../widgets/buttons.dart';

class EditProfilView extends StatelessWidget{

  final TextEditingController phoneNumber = TextEditingController();
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  var updatedPhone;

  EditProfilView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<EditVM>.reactive(
      viewModelBuilder: () => EditVM(),
      builder: (context, model, child) => Scaffold(
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
        title: const Text('Modifier mon profil', style: TextStyle(color: couleurPrincipale, fontSize: 13)),
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
              SizedBox(height: getProportionateScreenHeight(10)),
              TextFormField(
                controller: nomController,
                decoration: InputDecoration(
                    hintText: 'Nom',
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
                controller: prenomController,
                decoration: InputDecoration(
                    hintText: 'Prenom',
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
                  //updatedPhone = phone.completeNumber.replaceAll('+', '');
                  updatedPhone = phone.completeNumber;
                  //when phone number country code is changed
                  (phone.completeNumber); //get complete number
                  (phone.countryCode); // get country code only
                  (phone.number); // only phone number
                },
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Divider(),
              SizedBox(height: getProportionateScreenHeight(10)),
              SubmitButton(title: 'Save', onPressed: (){
                model.UpdateProfile(
                    Firstname: prenomController.text,
                    Lastname: nomController.text,
                    PhoneNumber: updatedPhone
                );
              })
            ],
          ),
        ),
      ),
    )
    );

  }

}