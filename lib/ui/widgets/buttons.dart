import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:network/ui/config/style.dart';

import '../config/size.dart';

//Elevated Button decoration
final ButtonStyle primaryBtn = ElevatedButton.styleFrom(
    textStyle: TextStyle(
        fontSize: getProportionateScreenWidth(20),
        color: couleurSecondaire,
        fontFamily: GoogleFonts.poppins().fontFamily

    ),
    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    primary: couleurPrincipale,
    padding: const EdgeInsets.all(16.0),
    fixedSize: const Size(300, double.infinity)
);
final ButtonStyle secondaryBtn = ElevatedButton.styleFrom(
    textStyle: TextStyle(
        fontSize: getProportionateScreenWidth(20),
        color: Color(0xFF0885CC),
        fontFamily: GoogleFonts.poppins().fontFamily
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    primary: couleurTertiaire,
    padding: const EdgeInsets.all(16.0),
    fixedSize: const Size(300, double.infinity)
);
//Outlined Button decoration
final ButtonStyle OutLineBtn = OutlinedButton.styleFrom(
    side: const BorderSide(color: couleurSecondaire),
);
final ButtonStyle AutreAvisBtn = OutlinedButton.styleFrom(
    side: const BorderSide(color: couleurSecondaire),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    textStyle: const TextStyle(color: Colors.black),
    backgroundColor: couleurQuaternaire,
    fixedSize: const Size(300, double.infinity)
);

//Submit Button
class SubmitButton extends StatefulWidget{

  final bool submit;
  final String title;
  final Function() onPressed;
  final bool enabled;

  const SubmitButton(
      {
        required this.title,
        this.submit = false,
        required this.onPressed,
        this.enabled = true,
      }
      );

  @override
  _SubmitButtonState createState() => _SubmitButtonState();

}
class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: widget.onPressed,
      child: InkWell(
        child: AnimatedContainer(
          height: widget.submit ? 40 : null,
          width: widget.submit ? 40 : null,
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: widget.submit ? 10 : 15,
              vertical: widget.submit ? 10 : 10
          ),
          decoration: BoxDecoration(
            color: widget.enabled ? couleurPrincipale: couleurPrincipale,
            borderRadius: BorderRadius.circular(45),
          ),
          child:  !widget.submit
              ? Text(
            widget.title,
            style: buttonTitleTextStyle,
          ) :const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
        ),
      ),
    );
  }
}

//Icon Button
class IconBtn extends StatelessWidget{

    const IconBtn({
        Key? key,
        this.icon,
        this.press,
        this.couleur
    }): super(key: key);

    final Icon? icon;
    final Function? press;
    final Color? couleur;

    @override
    Widget build(BuildContext context){
        return GestureDetector(
            onTap: press as void Function()?,
            child: Container(
                //margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                //padding: EdgeInsets.all(getProportionateScreenWidth(12)),
                height: getProportionateScreenHeight(40),
                width: getProportionateScreenWidth(40),
                decoration: BoxDecoration(
                    color: couleur,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: icon,
            )
        );
    }
}


//Terms & Conditions
class TermConditionText extends StatelessWidget {
  const TermConditionText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "En continuant, vous acceptez nos",
          style: TextStyle(fontSize: getProportionateScreenWidth(12), color: couleurTertiaire,),
          textAlign: TextAlign.center,
        ),
        GestureDetector(
          //onTap: () => Navigator.pushNamed(context, WelcomeView.routeName),
          child: Text(
            "Termes et conditions",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(12),
                color: couleurPrincipale),
          ),
        ),
      ],
    );
  }
}

//ResendCode
class ResendCode extends StatelessWidget {
  const ResendCode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Vous n'avez pas reçu de code ?",
          style: TextStyle(fontSize: getProportionateScreenWidth(12), color: couleurTertiaire,),
          textAlign: TextAlign.center,
        ),
        GestureDetector(
          //onTap: () => Navigator.pushNamed(context, WelcomeView.routeName),
          child: Text(
            "Renvoyez",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(12),
                color: couleurPrincipale),
          ),
        ),
      ],
    );
  }
}
