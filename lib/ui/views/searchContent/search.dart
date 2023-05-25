import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:network/core/models/search_model.dart';
import 'package:network/core/models/stores_model.dart';
import 'package:network/ui/config/style.dart';
import 'package:network/ui/widgets/buttons.dart';
import 'package:stacked/stacked.dart';
import '../../../core/viewmodels/searchVM.dart';
import '../../config/size.dart';
import '../../widgets/itembtn.dart';
import '../activityContent/storeDetails.dart';


class SearchView extends StatelessWidget{
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<SearchVM>.reactive(
      viewModelBuilder: () => SearchVM(),
      builder: (context, model, child) => Scaffold(
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
              Padding(padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(7))),
              const Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text('Recherche', style: heading2Style,),
                  )
              ),

            ],
          ),
          const Padding(padding: EdgeInsets.all(5)),
          FirestoreSearchBar(
            tag: 'boutiques',
            searchTextHintColor: couleurQuaternaire,
          ),
          Expanded(
              child:FirestoreSearchResults.builder(
                tag: 'boutiques',
                dataListFromSnapshot: SearchModel().dataListFromSnapshot,
                searchBy: 'nom',
                firestoreCollectionName: 'stores',
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<SearchModel>? dataList = snapshot.data;
                    if (dataList!.isEmpty) {
                      return const Center(
                        child: Text('No Results Returned'),
                      );
                    }
                    return ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          final SearchModel data = dataList[index];

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FirstItem(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Image.network(
                                          '${data.imageUrl}', fit: BoxFit.cover
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${data.nom}', style: heading2Style,),
                                            Text('${data.category}', style: paragraphStyle,),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  press: (){

                                    Map<String, dynamic> docToMap = {};
                                    docToMap["nom"] = data.nom;
                                    docToMap["category"] = data.category;

                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => StoreDetailsView(item: docToMap )));


                                  },
                                ),
                              ),

                            ],
                          );
                        });
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text('No Results Returned'),
                      );
                    }
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                },
              )
          ),

        ],
      ),
    )
    );

  }

}