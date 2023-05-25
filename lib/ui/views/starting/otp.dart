import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:network/core/config/routesName.dart';
import 'package:network/ui/config/size.dart';
import 'package:network/ui/config/style.dart';
import 'package:network/ui/widgets/buttons.dart';

import '../../widgets/otpinput.dart';

class OTPView extends StatelessWidget{
   OTPView({Key? key}) : super(key: key);

  final TextEditingController fieldOne = TextEditingController();
  final TextEditingController fieldTwo = TextEditingController();
  final TextEditingController fieldThree = TextEditingController();
  final TextEditingController fieldFour = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              Container(
                child: Center(
                  child: SvgPicture.asset('assets/brand/naming.svg', width: 150,),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Center(
                child: Column(
                  children: [
                    const Text('Authentication par OTP', textAlign: TextAlign.center, style: heading1Style,),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    const Text('Un code de sécurité a été envoyé sur votre numéro de téléphone/email', textAlign: TextAlign.center, style: paragraphStyle,),
                    SizedBox(height: SizeConfig.screenHeight * 0.03),
                    //Form
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OtpInput(fieldOne, true),
                        OtpInput(fieldTwo, true),
                        OtpInput(fieldThree, true),
                        OtpInput(fieldFour, true),

                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    const ResendCode(),
                    SizedBox(height: SizeConfig.screenHeight * 0.05),
                    SubmitButton(
                        title: 'Continue',
                        onPressed: (){
                          Navigator.pushNamed(context, CreateProfileViewRoute);
                        }
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

  }

}