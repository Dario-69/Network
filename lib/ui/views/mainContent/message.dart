
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:network/core/config/routesName.dart';
import 'package:network/ui/config/style.dart';

import '../../config/size.dart';
import '../../widgets/itembtn.dart';

class MessageView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: couleurPrincipale,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Messages', style: heading3Style,),
                )
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
                      height: SizeConfig.screenHeight,
                      child: ListView(
                        padding: const EdgeInsets.all(5),
                        children: <Widget>[
                          FirstItem(
                            press: (){
                              Navigator.pushNamed(context, ChatViewRoute);
                            },
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