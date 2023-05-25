import 'dart:io';

import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:path/path.dart' as p;

import '../../../core/config/locator.dart';
import '../../../core/config/routesName.dart';
import '../../../core/models/stores_model.dart';
import '../../../core/services/NavigationService.dart';
import '../../../core/viewmodels/createVM.dart';
import '../../config/size.dart';
import '../../config/style.dart';
import '../../widgets/buttons.dart';

class CompleteShopInfoView extends StatefulWidget{
  final String idStore;
  const CompleteShopInfoView({Key? key, required this.idStore}) : super(key: key);

  @override
  CompleteShopInfoState createState() => CompleteShopInfoState();

}

class CompleteShopInfoState extends State<CompleteShopInfoView>{

  //Service
  final NavigationService _navigationService = locator<NavigationService>();
  final firestoreInstance = FirebaseFirestore.instance;


  //Controller
  final chipController = TextEditingController();
  final chipsController = TextEditingController();
  final openingController = TextEditingController();
  final closureController = TextEditingController();

  //Add produits
  final List<ChipData> _allProducts = [];
  void _addNewProducts() async {
    await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Ajouter un produits:'),
            content: TextField(
              controller: chipController,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _allProducts.add(ChipData(
                          id: DateTime.now().toString(),
                          name: chipController.text));
                    });

                    // reset the TextField
                    chipController.text = '';

                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ajouter'))
            ],
          );
        });
  }
  void _deleteProduct(String id) {
    setState(() {
      _allProducts.removeWhere((element) => element.id == id);
    });
  }

  //Add services
  final List<ChipData> _allServices = [];
  void _addNewServices() async {
    await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Ajouter un produits:'),
            content: TextField(
              controller: chipsController,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _allServices.add(ChipData(
                          id: DateTime.now().toString(),
                          name: chipsController.text));
                    });

                    // reset the TextField
                    chipsController.text = '';

                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ajouter'))
            ],
          );
        });
  }
  void _deleteService(String id) {
    setState(() {
      _allServices.removeWhere((element) => element.id == id);
    });
  }

  //Les jours d'ouvertures
  List<String> tags = [];

  // list of string options
  List<String> days = [ 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche',];

  //Hour
  String _valueChanged4 = '';
  String _valueToValidate4 = '';
  String _valueSaved4 = '';

  String _valueChanged5 = '';
  String _valueToValidate5 = '';
  String _valueSaved5 = '';

  //Profil Picture
  XFile? _image;
  final picker = ImagePicker();
  String? _imageUrl;


  @override
  Widget build(BuildContext context) {

    var idOfStore = widget.idStore;

    return ViewModelBuilder<CreateVM>.reactive(
        viewModelBuilder: () => CreateVM(),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: couleurTertiaire,
            title: const Text('Mon établissement', style: TextStyle(color: couleurPrincipale, fontSize: 13)),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Informations pratiques', style: heading1Style,),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  const Text('Quels sont vos produits ?', style: paragraphStyle,),
                  Wrap(
                    spacing: 10,
                    children: _allProducts
                        .map((chip) => Chip(
                      key: ValueKey(chip.id),
                      label: Text(chip.name, style: const TextStyle(color: couleurSecondaire),),
                      backgroundColor: couleurPrincipale,
                      padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      deleteIconColor: couleurQuaternaire,
                      onDeleted: () => _deleteProduct(chip.id),

                    )
                    ).toList(),
                  ),
                  OutlinedButton(
                      onPressed: _addNewProducts,
                      child: const Text('Ajouter un produit')
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  const Text('Quels sont vos services ? (facultatifs)', style: paragraphStyle,),
                  Wrap(
                    spacing: 10,
                    children: _allServices
                        .map((chip) => Chip(
                      key: ValueKey(chip.id),
                      label: Text(chip.name, style: const TextStyle(color: couleurSecondaire),),
                      backgroundColor: couleurPrincipale,
                      padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      deleteIconColor: couleurQuaternaire,
                      onDeleted: () => _deleteService(chip.id),
                    )
                    ).toList(),
                  ),
                  OutlinedButton(
                      onPressed: _addNewServices,
                      child: const Text('Ajouter un service')
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  const Text('Les horaires de l\'établissement', style: paragraphStyle,),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  ChipsChoice<String>.multiple(
                    value: tags,
                    onChanged: (dayval) => {setState(() => tags = dayval)},
                    choiceItems: C2Choice.listFrom<String, String>(
                      source: days,
                      value: (i, v) => v,
                      label: (i, v) => v,
                    ),
                    choiceStyle: const C2ChoiceStyle(
                      color: couleurTertiaire,
                      borderColor: couleurQuaternaire,
                    ),
                    //wrapped: true,
                    //textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  DateTimePicker(
                    type: DateTimePickerType.time,
                    controller: openingController,
                    icon: const Icon(Icons.access_time),
                    use24HourFormat: true,
                    locale: const Locale('fr', 'FR'),
                    onChanged: (val) => setState(() => _valueChanged4 = val),
                    validator: (val) {
                      setState(() => _valueToValidate4 = val ?? '');
                      return null;
                    },
                    onSaved: (val) => setState(() => _valueSaved4 = val ?? ''),
                    decoration: InputDecoration(
                        hintText: "Heure d'ouverture",
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
                  DateTimePicker(
                    type: DateTimePickerType.time,
                    controller: closureController,
                    icon: const Icon(Icons.access_time),
                    //timeLabelText: "",
                    use24HourFormat: true,
                    locale: const Locale('fr', 'FR'),
                    onChanged: (val) => setState(() => _valueChanged5 = val),
                    validator: (val) {
                      setState(() => _valueToValidate5 = val ?? '');
                      return null;
                    },
                    onSaved: (val) => setState(() => _valueSaved5 = val ?? ''),
                    decoration: InputDecoration(
                        hintText: "Heure de fermeture",
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
                  const Text('Ajoutez une photo de votre établiseement', style: paragraphStyle,),
                  SizedBox(height: getProportionateScreenHeight(10)),

                  _image == null
                      ? OutlinedButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) => SafeArea(
                                child: SizedBox(
                                  height: 350,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const Text("Sélectionnez la source de l'image", style: paragraphStyle,),
                                        SizedBox(height: getProportionateScreenHeight(10),),
                                        GestureDetector(
                                          onTap: () async {

                                            //Check Permissions
                                            await Permission.photos.request();
                                            var permissionStatus = await Permission.photos.status;

                                            if (permissionStatus.isGranted){
                                              await picker.pickImage(source: ImageSource.camera).then((image){
                                                setState(() {
                                                  _image = image;
                                                });
                                              });
                                            }
                                            else {}

                                          },
                                          child: Container(
                                            height: 45,
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(horizontal: 24),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.circular(55),
                                                border: Border.all(color: couleurSecondaire)
                                            ),
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [
                                                const Icon(Icons.camera, color: couleurSecondaire,),
                                                SizedBox(width: getProportionateScreenWidth(5),),
                                                const Text('Camera', style: TextStyle(color: couleurQuaternaire),)
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: getProportionateScreenHeight(10),),
                                        GestureDetector(
                                          onTap: () async {

                                            //Check Permissions
                                            await Permission.photos.request();
                                            var permissionStatus = await Permission.photos.status;

                                            if (permissionStatus.isGranted){
                                              await picker.pickImage(source: ImageSource.gallery).then((image){
                                                setState(() {
                                                  _image = image;
                                                });
                                              });
                                            }
                                            else {}

                                          },
                                          child: Container(
                                            height: 45,
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(horizontal: 24),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.circular(55),
                                                border: Border.all(color: couleurQuaternaire)
                                            ),
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [
                                                const Icon(Icons.image, color: couleurPrincipale,),
                                                SizedBox(width: getProportionateScreenWidth(5),),
                                                const Text('Galerie', style: TextStyle(color: couleurQuaternaire),)
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: getProportionateScreenHeight(10),),
                                        GestureDetector(
                                          onTap: () async {

                                            Navigator.pop(context);

                                          },
                                          child: Container(
                                            height: 45,
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(horizontal: 24),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.circular(55),
                                                border: Border.all(color: Colors.red)
                                            ),
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [
                                                const Icon(Icons.delete, color: Colors.red,),
                                                SizedBox(width: getProportionateScreenWidth(5),),
                                                const Text('Supprimer', style: TextStyle(color: Colors.red),)
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: getProportionateScreenHeight(10),),
                                      ],
                                    ),
                                  ),
                                ),

                              )
                          );
                        },
                        child: const Text('Ajouter'),
                      )
                      : Image(
                          //File(_image!.path),
                          height: 150,
                          width: double.infinity,
                              image: XFileImage(_image!),
                      ),
                  const Divider(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  SubmitButton(
                      title: 'Continuer',
                      onPressed: () async {
                        List<String> fnlProd = _allProducts.map((e) => e.name).toList();
                        List<String> fnlServ = _allServices.map((e) => e.name).toList();

                        File imageFile = File(_image!.path);
                        Reference storageReference = FirebaseStorage.instance
                            .ref()
                            .child('images/${p.basename(_image!.path)}');
                        UploadTask uploadTask = storageReference.putFile(imageFile);

                        await uploadTask.whenComplete(() =>

                          storageReference.getDownloadURL().then((fileURL) {
                            setState(() {
                              _imageUrl = fileURL;
                            });
                          })

                        );


                        //
                        firestoreInstance.collection('stores').doc(idOfStore).update({
                          "products": FieldValue.arrayUnion(fnlProd),
                          "services": FieldValue.arrayUnion(fnlServ),
                          "days": FieldValue.arrayUnion(tags),
                          "opening": openingController.text,
                          "closure": closureController.text,
                          "imageUrl": _imageUrl.toString(),
                        }).then((_) {
                          _navigationService.navigateTo(HomeViewRoute);
                        });

                      }
                  )
                ],
              ),
            ),
          ),
        )
    );


  }
}