import 'package:dream_land/Model/ModelForCenters.dart';
import 'package:dream_land/uiCard/CardCenters.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CenterFlagMall extends StatefulWidget {
  @override
  _CenterFlagMallState createState() => _CenterFlagMallState();
}

class _CenterFlagMallState extends State<CenterFlagMall> {

  List <ModelForCenters> centers = <ModelForCenters>[];

 Future <void> setDataForFirebase() async {
    DatabaseReference reference =
    FirebaseDatabase.instance.reference().child('DreamLand').child('FlagMall');

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
      setState((){});
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

        title: Text("فلاج مول",style: TextStyle(fontSize: 15),),

        leading: IconButton(

          onPressed: () {

            Navigator.pop(context);

          },

          icon: Icon(Icons.arrow_back),

        ),

      ),

      body:RefreshIndicator(



        onRefresh: () {
          return setDataForFirebase();
        },
        child:  ListView.builder(

            itemCount: centers.length,

            shrinkWrap: true,

            itemBuilder: (context,index){

              return CardCenters(

                photo:centers[index].photo,
                title:centers[index].title,
                mobile: centers[index].mobile,
                numberPhone:centers[index].numberPhone,
                lat:centers[index].lat,
                lng:centers[index].lng,

              );

            }

        ),

      ),

    );
  }
}
