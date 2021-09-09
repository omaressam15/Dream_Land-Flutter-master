import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

class CardCenters extends StatefulWidget {
  String photo;

  String title;

  String numberPhone;

  double lat;

  double lng;

  String mobile;

  CardCenters(
      {this.photo,
      this.title,
      this.numberPhone,
      this.lat,
      this.lng,
      this.mobile});

  @override
  _CardCentersState createState() => _CardCentersState();
}

class _CardCentersState extends State<CardCenters> {
  bool isVisible = true;

  void showToast() {
    setState(() {

      if (widget.lat != null && widget.lng != null && widget.mobile == null) {
        isVisible = false;
      } else {
        isVisible = true;
      }


      if (widget.lat == null && widget.lng == null && widget.mobile == null) {
        isVisible = false;
      } else {
        isVisible = true;
      }

    });
  }

  void _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 170,
            color: Color(0xFF737373), //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20))),
              child: _itemBottomSheetMenu(),
            ),
          );
        });
  }


  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Column _itemBottomSheetMenu() {
    return Column(
      children: [
        ListTile(
          title: Text("${widget.numberPhone}"),
          leading: Icon(
            Icons.phone,
            color: Colors.green,
          ),
          onTap: () {
            UrlLauncher.launch('tel:${widget.numberPhone.toString()}');
          },
        ),
        Visibility(
          visible: isVisible,
          child: ListTile(
            title: Text("${widget.mobile ?? "No other number"}"),
            leading: Icon(
              Icons.phone,
              color: Colors.green,
            ),
            onTap: () {
              UrlLauncher.launch('tel:${widget.mobile.toString()}');
            },
          ),
        ),
        Visibility(
          visible: isVisible,
          child: ListTile(
            title: Text("Location"),
            leading: Icon(
              Icons.location_on,
              color: Colors.green,
            ),
            onTap: () {
              _launchMapsUrl(widget.lat, widget.lng);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Material(
        elevation: 5,
        type: MaterialType.card,
        shadowColor: Colors.grey[350],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: () {
            showToast();

            _modalBottomSheetMenu(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: CircleAvatar(
                      radius: 30,
                      // foregroundColor: Colors.white,

                      backgroundImage: NetworkImage("${widget.photo}"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          "${widget.title}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                          overflow: TextOverflow.visible,
                        ),
                        width: MediaQuery.of(context).size.width *0.63
                        ,
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      Text(
                        "${widget.numberPhone}",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 5))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
