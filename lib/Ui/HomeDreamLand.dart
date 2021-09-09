import 'package:dream_land/Model/ModelDreamLand.dart';
import 'package:dream_land/Model/ModelPhotos.dart';
import 'package:dream_land/uiCard/CardForImages.dart';
import 'package:dream_land/uiCard/CardGrid.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'CenterAlBahga.dart';
import 'CenterFlag.dart';
import 'CenterStar.dart';
import 'ServicesDreamLand.dart';

class HomeDream extends StatefulWidget {
  @override
  _HomeDreamState createState() => _HomeDreamState();
}

class _HomeDreamState extends State<HomeDream> {

  bool isLoading = true;

  List<ModelDream> modelDream = [];


  List <ModelPhoto> modelPhoto = [];


 Future <void> setPhotoFireBase() async {

   try{
     DatabaseReference reference =
     FirebaseDatabase.instance.reference().child('DreamLand').child('images');

     await reference.once().then((DataSnapshot snapshot) {
       modelPhoto.clear();

       var keys = snapshot.value.keys;

       var values = snapshot.value;

       for (var keys in keys) {
         ModelPhoto dream = new ModelPhoto(

           values[keys]['image'],
           values[keys]["images"],


         );
         modelPhoto.add(dream);


         //print('****************************');
       }

       isLoading = false;
       setState((){});
     });
   }catch(error){
     print("Error we loding photos ${error.toString()}");

   }



  }

 Future <dynamic> setGridFireBase() async {

   try{

     Query reference =
     FirebaseDatabase.instance.reference().child('DreamLand').child('Dream').orderByChild('CenterElGharby');


     await reference.once().then((DataSnapshot snapshot) {
       modelDream.clear();


       var keys = snapshot.value.keys;

       var values = snapshot.value;

       for (var keys in keys) {
         ModelDream dream = new ModelDream(
           values[keys]['image'],
           values[keys]["name"],

         );
         //modelDream.sort();

         modelDream.add(dream);


         print(dream.name+": "+dream.image);

         print("***************************");
       }

       isLoading = false;
       setState(() {});
     });
   }catch(error){
     print ('error on grade${error.toString()}');
   }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setGridFireBase();
    setPhotoFireBase();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: isLoading
          ? Center(
              child: LoadingBouncingGrid.circle(
                size: 50,
                borderColor: Colors.white,
                backgroundColor: Colors.cyan,
              ),
            )
          : Column(
              children: [

          ListView.builder(

              shrinkWrap: true,

              itemCount: modelPhoto.length,

              physics: NeverScrollableScrollPhysics(),

              itemBuilder:(context,index){
                return CardImages(

                  image:modelPhoto[index].image,

                  images:modelPhoto[index].images ,


                );
              }
          ),

          Padding(padding: EdgeInsets.only(bottom: 47)),



          Expanded(

            child: RefreshIndicator(

              onRefresh: () {
                setPhotoFireBase();
                setGridFireBase();
                return setGridFireBase();

              },

              child: Container(
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(

                    itemCount: modelDream.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                    itemBuilder: (context, index) {

                      return InkWell(

                        onTap: (){

                          setState(() {

                            if(modelDream[index].name =='سنتر ستار'){

                              Navigator.of(context).push(_createRoute(CenterStar()));

                            } else if ( modelDream[index].name=='سنتر البهجة'){

                              Navigator.of(context).push(_createRoute(CenterAlBahga()));

                            }else if (modelDream[index].name=='فلاج مول'){

                              Navigator.of(context).push(_createRoute(CenterFlagMall()));

                            }else if ( modelDream[index].name=='طوارئ و خدمات'){

                              Navigator.of(context).push(_createRoute(ServicesDreamLand()));


                            }

                          });

                        },

                        child: CardGrid(
                          title: modelDream[index].name,
                          image: modelDream[index].image,
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:1 ,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 12
                    )),
              ),

            ),

          ),

        ],
      ),

    );
  }
}



  Route _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}