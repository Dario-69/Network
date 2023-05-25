import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:network/ui/config/style.dart';
import '../../config/size.dart';

class ChatView extends StatefulWidget {

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: couleurTertiaire,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: couleurPrincipale,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: couleurSecondaire,
              ),
              color: couleurTertiaire,
            ),
            SizedBox(
                width: 40,
                height: 40,
                child: Stack(children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SvgPicture.asset('assets/images/onboard.svg')),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.greenAccent[400],
                          border:
                              Border.all(color: couleurSecondaire, width: 2)),
                    ),
                  ),
                ])),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "Nom",
                    style: h22Style,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: const Text( "Online", style: paragraphStyle, ),
                )
              ],
            )
          ],
        ),
        elevation: 0,
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.phone,
                  size: 16,
                  color: couleurSecondaire,
                ),
              ),
            ],
          )
        ],
      ),
      body: Container(),
    );
  }


}



