import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:network/ui/config/style.dart';
import 'package:stacked/stacked.dart';

import '../../../core/viewmodels/createVM.dart';
import '../../config/size.dart';
import '../../widgets/buttons.dart';

class CreateProfileView extends StatelessWidget{
  CreateProfileView({Key? key}) : super(key: key);
  static String routeName = "/CreateProfile";

  final lastnameController = TextEditingController();
  final firstnameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  var updatedPhone;

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<CreateVM>.reactive(
        viewModelBuilder: () => CreateVM(),
        builder: (context, model, child) => Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 5%
                    const Text(
                      "Félicitations !",
                      style: TextStyle(
                          color: couleurPrincipale,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    const Text(
                      "Nous sommes très heureux de vous avoir dans notre communauté... Nous serons d'en savoir plus sur vous.",
                      style: TextStyle(
                        color: couleurTertiaire,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.03),
                    Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: lastnameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Votre nom',
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.02),
                            TextFormField(
                              controller: firstnameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Votre prenom',
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.02),
                            IntlPhoneField(
                              controller: phoneNumberController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
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
                            SizedBox(height: SizeConfig.screenHeight * 0.04),
                            SubmitButton(
                                title: 'Continue',
                                onPressed: (){
                                  model.CreateProfile(
                                      Firstname: firstnameController.text,
                                      Lastname: lastnameController.text,
                                      PhoneNumber: updatedPhone
                                  );
                                }
                            )
                          ],
                        )
                    )
                  ]
              ),
            ),
          ),
        )
    );

  }

}
