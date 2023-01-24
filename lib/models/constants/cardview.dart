import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newstask/models/constants/colors.dart';
import 'package:newstask/models/constants/myfonts.dart';

class ItemWidget extends StatelessWidget {
  var title;
  var description;
  var url;
  var time;
  ItemWidget({required this.title,required this.description,required this.url,required this.time});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
                  decoration: BoxDecoration(
                    color: AppColors.whitecolor,
                    borderRadius: BorderRadius.circular(10.0), //border: Border.all(color: Colors.blue)
                  ),
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  height: 150,
                  child: Row(
                    children: [
                      
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("$title", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: AppFonts.medium),),
                          SizedBox(height: 10,),
                          Container(
                            width: size.width * 0.5,
                            child: Text("$description", overflow: TextOverflow.ellipsis, maxLines: 3, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500, fontFamily: AppFonts.medium),)),
                            SizedBox(height: 10,),
                            Text("${prepareLutMsg(time)}", style: TextStyle(fontSize: 12.0, fontFamily: AppFonts.medium, color: AppColors.greycolor),),
                        ],
                      ),
                      SizedBox(width: 6,),
                      ClipRRect(borderRadius: BorderRadius.circular(10), child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 120,
                        width: size.width * 0.35,
        imageUrl: "$url",
        placeholder: (context, url) => LinearProgressIndicator(
          backgroundColor: AppColors.whitecolor,
          color: AppColors.bluecolor,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
     ),),
                    ],
                  ),
                );
  }
   prepareLutMsg(time) {
    try{
    var lut=DateTime.parse(time).millisecondsSinceEpoch~/1000;
    var msg = "";
    var currentTime = DateTime.now();
    var version = currentTime.millisecondsSinceEpoch ~/ 1000;
    var difference = lut != null ? (version).round() - lut : version;
    var daysDifference = (difference / 60 / 60 / 24).floor();
    if (daysDifference > 0) {
      msg = (daysDifference).toString() + " day(s) ago";
      return msg;
    }
    difference -= daysDifference * 60 * 60 * 24;
    var hoursDifference = (difference / 60 / 60).floor();
    if (hoursDifference > 0) {
      msg = (hoursDifference).toStringAsFixed(0) + " hour(s) ago";
      return msg;
    }
    difference -= hoursDifference * 60 * 60;
    var minutesDifference = (difference / 60).floor();
    if (minutesDifference > 1) {
      msg = (minutesDifference).toStringAsFixed(0) + " min(s) ago";
    } else {
      msg = "1 Min ago";
    }
    return msg;}catch(e){
      return "";
    }
  }

}