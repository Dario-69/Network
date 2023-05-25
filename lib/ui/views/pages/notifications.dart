import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:network/ui/config/style.dart';
import 'package:network/ui/widgets/buttons.dart';

import '../../config/size.dart';
import '../../widgets/itembtn.dart';

class NotifsView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
              Padding(padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(7))),
              Expanded(
                  child: IconBtn(
                    icon: Icon(FontAwesomeIcons.arrowLeftLong, size: 16,),
                    press: (){
                      Navigator.pop(context);
                    },
                    couleur: couleurTertiaire,
                  ),
              ),
              const Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text('Notifications', style: heading2Style,),
                  )
              ),

            ],
          ),
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
                      height: SizeConfig.screenHeight,
                      child: ListView(
                        padding: EdgeInsets.all(7.00),
                        children: <Widget>[
                          FirstItem(
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/images/onboard.svg', width: 60,),
                                Padding(padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(4))),
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: const [
                                            Text('UserName', style: heading2Style,),
                                            Spacer(),
                                            Text('TimeAgo', style: timeAgoStyle,),
                                            Padding(padding: EdgeInsets.only(right: 3))
                                          ],
                                        ),
                                        const Text('Dernier Message', style: paragraphStyle,)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.03),

                  ],
                ),
              )
          )
        ],
      ),
    );

  }

}