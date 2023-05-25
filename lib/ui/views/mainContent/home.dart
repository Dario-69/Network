import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:network/ui/config/style.dart';
import 'package:network/ui/views/searchContent/search.dart';
import 'package:stacked/stacked.dart';

import '../../../core/viewmodels/homeVm.dart';

import 'discover.dart';
import 'reseau.dart';
import 'message.dart';
import 'profile.dart';

class HomeView extends StatelessWidget{
  const HomeView({Key? key}) : super(key: key);

  static String routeName = "/HomeView";

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          reverse: model.reverse,
          transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              ) {
            return SharedAxisTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
            );
          },
          child: getViewForIndex(model.currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: couleurTertiaire,
          fixedColor: couleurPrincipale,
          currentIndex: model.currentIndex,
          onTap: model.setIndex,
          items: const [
            BottomNavigationBarItem(
              label: 'Accueil',
              icon: Icon(FontAwesomeIcons.house),
            ),
            BottomNavigationBarItem(
              label: 'Favoris',
              icon: Icon(FontAwesomeIcons.heart),
            ),

            BottomNavigationBarItem(
              label: 'Recherche',
              icon: Icon(FontAwesomeIcons.magnifyingGlass),
            ),

            BottomNavigationBarItem(
              label: 'Profil',
              icon: Icon(FontAwesomeIcons.user),
            ),
          ],
        ),
      ),

      viewModelBuilder: () => HomeViewModel(),

    );

  }

  Widget getViewForIndex(int index){

    switch(index){
      case 0:
        return DiscoverView();
      case 1:
        return ReseauView();
      case 2:
        return const SearchView();
      case 3:
        return ProfileView();
      default:
        return DiscoverView();
    }
  }
}