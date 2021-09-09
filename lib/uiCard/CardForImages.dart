import 'package:flutter/material.dart';

class CardImages extends StatefulWidget {


  String image;

  String images;

  CardImages({this.image, this.images});

  @override
  _CardImagesState createState() => _CardImagesState();
}

class _CardImagesState extends State<CardImages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        Stack(

          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,

          children: [

            Image.network("${widget.image}",
               width: MediaQuery.of(context).size.width,
               fit: BoxFit.fill,
               height: 220,


             ),

            Positioned(

              top:180 ,

              child:ClipOval(


                child: Image.network("${widget.images}",fit: BoxFit.cover,width: 80,height: 80,),

              ),)



          ],
        ),
      ],
    );
  }
}
