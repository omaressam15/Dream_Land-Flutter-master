import 'package:dream_land/Model/ModelForCenters.dart';
import 'package:dream_land/uiCard/CardCenters.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CenterAlBahga extends StatefulWidget {
  @override
  _CenterAlBahgaState createState() => _CenterAlBahgaState();
}

class _CenterAlBahgaState extends State<CenterAlBahga> {

  List <ModelForCenters> centers = <ModelForCenters>[];



  Future <void> setDataForFirebase()async {
    DatabaseReference reference =
    FirebaseDatabase.instance.reference().child('DreamLand').child('SanterElGanoby');

   await reference.once().then((DataSnapshot snapshot) {


      centers.clear();

      var keys = snapshot.value.keys;

      var values = snapshot.value;

      for (var keys in keys) {

        ModelForCenters dreamCenters = new ModelForCenters(

          values[keys]['image'],
          values[keys]["name"],
          values[keys]["number"],
          values[keys]["lat"],
          values[keys]["lng"],
          values[keys]["mobile"],

        );

        centers.add(dreamCenters);

      }
      setState((){
        centers.forEach((element) {

          if(centers == null){
            centers.removeWhere((element) => element==null);
          }

        });

      });
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setDataForFirebase();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey[300],

      appBar: AppBar(

        title: Text("سنتر البهجة",style: TextStyle(fontSize: 15),),

        leading: IconButton(

          onPressed: () {

            Navigator.pop(context);

          },

          icon: Icon(Icons.arrow_back),

        ),

      ),

      body: RefreshIndicator(

        onRefresh: () {
          return setDataForFirebase();
        },
        child: ListView.builder(

            itemCount: centers.length,

            shrinkWrap: true,

            itemBuilder: (context,index){

              return CardCenters(

                photo:centers[index].photo,
                title:centers[index].title,
                numberPhone:centers[index].numberPhone,
                mobile: centers[index].mobile,
                lat: centers[index].lat,
                lng: centers[index].lng,

              );

            }

        ),

      ),

    );
  }
}
