import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tu_moto_app/bloc/requestAssistant.dart';
import 'package:tu_moto_app/repository/address.dart';
import 'package:tu_moto_app/repository/appData.dart';
import 'package:tu_moto_app/repository/placePreditions.dart';
import 'package:tu_moto_app/ui/widget/brandColors.dart';
import 'package:tu_moto_app/ui/widget/brandDivider.dart';
import 'package:tu_moto_app/ui/widget/pallete.dart';
import 'package:tu_moto_app/ui/widget/progressDialog.dart';

import '../../configMaps.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController pickupTextEditingController  = TextEditingController();
  TextEditingController dropoffTextEditingController  = TextEditingController();
  List<PlacePredicitions> placePredictionList = [];


  @override
  Widget build(BuildContext context) {

    String  placeAddress  = Provider.of<AppData>(context).pickUpLocation.placeName ?? '';
    pickupTextEditingController.text = placeAddress;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 215,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 6.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                )
              ]
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20, top:  35, right: 20, bottom: 20,),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5,),
                  Stack(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },

                          child: Icon(Icons.arrow_back)),
                      Center(
                        child: Text('Elige a donde quieres ir ', style: TextStyle(fontSize: 18,)),
                      )
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: <Widget>[
                      Image.asset('assets/images/pickicon.png', height: 16,width: 16,),
                      SizedBox(width: 18,),
                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: BrandColors.colorLightGray,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3),
                              child: TextField(
                                controller: pickupTextEditingController,
                                decoration: InputDecoration(
                                  hintText: Provider.of<AppData>(context).pickUpLocation.placeName,
                                  fillColor: BrandColors.colorLightGray,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(left: 11, top: 8, bottom: 8),
                                ),
                              ),
                            ),

                      )
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Image.asset('assets/images/desticon.png', height: 18,width: 18,),
                      SizedBox(width: 16,),
                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: BrandColors.colorLightGray,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3),
                              child: TextField(
                                  onChanged: (val)
                                  {
                                    findPlace(val);
                                  },
                                  controller: dropoffTextEditingController,
                                decoration: InputDecoration(
                                  hintText: 'Escribe aquí la dirección de destino',
                                  fillColor: BrandColors.colorLightGray,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(left: 11, top: 8, bottom: 8),
                                ),
                              ),
                            ),

                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          (placePredictionList.length > 0) ?
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListView.separated(
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index)
                    {
                      return PredictionTile(placePredictions: placePredictionList[index],);
                    },
                    separatorBuilder: (BuildContext context, int index) => BrandDivider(),
                    itemCount: placePredictionList.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),


              ),
    ) : Container(),

        ],
      ),
    );

  }
  void findPlace(String placeName) async{
    if(placeName.length > 1) {
      String autoCompleteUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:co';
      var res = await RequestAssistant.getRequest(autoCompleteUrl);
      if (res == 'failed') {
        return;
      }

      if(res['status'] == 'OK')
        {
          var predictions = res['predictions'];
          var placeList = (predictions as List).map((e) => PlacePredicitions.fromJson(e)).toList();

          setState(() {
            placePredictionList = placeList;
          });
        }
    }
  }
}

class PredictionTile extends StatelessWidget {

  final PlacePredicitions placePredictions;

  PredictionTile({Key key, this.placePredictions}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // ignore: deprecated_member_use
    return FlatButton(
      padding: EdgeInsets.all(0.0),
      onPressed: (){

        getPlaceAddressDetails(placePredictions.placeId, context);
      },
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Icon(Icons.add_location),
                SizedBox(width: 14,),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(placePredictions.mainText,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),),
                        SizedBox(height: 3,),
                        Text(placePredictions.secondaryText,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12,
                              color: Palette.textColor1),),
                        SizedBox(height: 8,)

                      ]
                  ),
                )
              ],
            ),
          ]
        ),
      ),
    );
  }
  void getPlaceAddressDetails(String placeId, context) async
  {
    showDialog(
        context: context,
        // ignore: non_constant_identifier_names
        builder: (BuildContext) => ProgressDialog(message: 'Bip Bup Bip Un segundo más',));
    String placeDetailsUrl = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey';

    var res = await RequestAssistant.getRequest(placeDetailsUrl);
    
    Navigator.pop(context);
    
    if(res == 'failed')
      {
        return ;
      }

    {
      Address address = Address();
      address.placeName = res['result']['name'];
      address.placeId = placeId;
      address.latitude = res['result']['geometry']['location']['lat'];
      address.longitude = res['result']['geometry']['location']['lng'];

      Provider.of<AppData>(context, listen: false).updateDropOffAddress(address);
      print('Esta es la ubicación destino');
      print(address.placeName);
      print(address.latitude);
      print(address.longitude);

      Navigator.pop(context, 'obtainDirection');

    }
  }
}

