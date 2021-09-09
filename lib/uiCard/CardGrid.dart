import 'package:dream_land/Ui/CenterStar.dart';
import 'package:flutter/material.dart';

class CardGrid extends StatefulWidget {

  String image;

  String title;

  CardGrid({this.image, this.title});

  @override
  _CardGridState createState() => _CardGridState();
}

class _CardGridState extends State<CardGrid> {
  @override
  Widget build(BuildContext context) {


    return Material(

      elevation: 4.7,

      shadowColor: Colors.grey,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),),


        child: Container(

          decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(17)),
          ),
          child: Column(

           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [

              Image.network("${widget.image}",fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height *0.140 ,
              ),

              SizedBox(
                height: 7,
              ),

              Text(
                "${widget.title}",style: TextStyle(fontSize: 16,
                  color: Colors.black,

                  fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,


              ),
            ],
          ),
        ),

    );

  }
}
