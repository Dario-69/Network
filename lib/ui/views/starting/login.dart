import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:network/core/config/routesName.dart';
import 'package:network/ui/config/style.dart';
import 'package:stacked/stacked.dart';

import '../../../core/viewmodels/connexionVM.dart';
import '../../config/size.dart';
import '../../widgets/buttons.dart';

class LoginView extends StatefulWidget{

  @override
  LoginState createState() => LoginState();

}

class LoginState extends State<LoginView>{

  final formGlobalKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isValid = false;
  _saveForm() {
    setState(() {
      _isValid = formGlobalKey.currentState!.validate();
    });
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<ConnexionVM>.reactive(
        viewModelBuilder: () => ConnexionVM(),
        builder: (context, model, child) => Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  IconBtn(
                    press: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(FontAwesomeIcons.arrowLeftLong, size: 16,),
                    couleur: couleurTertiaire,
                  ), //GoBackBtn
                  SizedBox(height: SizeConfig.screenHeight * 0.03), // 5%
                  const Text("Content de vous revoir", style: hTitleStyle,),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  const Text(
                    "Connectez vous pour continuer",
                    style: paragraphStyle,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Form(
                      key: formGlobalKey,
                      child: Column(
                        children: [
                          SizedBox(height: SizeConfig.screenHeight * 0.02),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Entrez votre email',
                            ),

                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              // Check if this field is empty
                              if (value == null || value.isEmpty) {
                                return 'Ce champ est requis';
                              }

                              // using regular expression
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return "Veuillez entrer un email valide";
                              }

                              // the email is valid
                              return null;
                            },


                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.02),
                          TextFormField(
                            controller: passwordController,
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Creer un mot de passe',
                                suffixIcon: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                    icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off)
                                )
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          SubmitButton(
                              title: 'Connexion',
                              onPressed: (){
                                _saveForm();
                                model.login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                          )
                        ],
                      )
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  const Center(
                    child: Text(
                      "Ou s'inscrire avec",
                      textAlign: TextAlign.center, style: paragraphStyle,
                    ),
                  ),
                  Center(
                    child: IconBtn(
                      press: (){
                        //Navigator.pushNamed(context, RegisterMailViewRoute);
                      },
                      icon: const Icon(FontAwesomeIcons.phone, size: 16, color: couleurPrincipale,),
                      couleur: couleurTertiaire,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(50)),
                  const Center(
                    child: TermConditionText(),
                  )
                ],
              ),
            ),
          ),
        )
    );

  }

}