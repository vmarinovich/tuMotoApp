import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tu_moto_app/bloc/assistantMethods.dart';
import 'package:tu_moto_app/ui/widget/brandColors.dart';
import 'package:tu_moto_app/ui/widget/brandDivider.dart';
import 'package:tu_moto_app/ui/widget/pallete.dart';
import 'package:tu_moto_app/ui/widget/style.dart';

class MainPage extends StatefulWidget {
  static const String id = 'mainpage';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  void locatePosition() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethod.searchCoordinateAddress(position);
    print('Esta es tu dirección actual : :' + address);

  }

  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        width: 250,
        color: Palette.activeColor,
        child: Drawer(


            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[

                Container(
                  color: Palette.activeColor,
                  height: 160,
                  child: DrawerHeader(

                    decoration: BoxDecoration(
                      color: Palette.activeColor,
                    ),
                    child: Row(
                      children: <Widget>[
                        Image.asset('assets/images/user_icon.png',
                            height: 60,
                            width: 60),
                        SizedBox(width: 15,),


                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Uchema',
                                style: TextStyle(fontSize: 20, fontFamily: 'Brand-Regular',color: BrandColors.colorDimText, fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Text('Ver perfil',
                                style: TextStyle(color: BrandColors.colorDimText),)
                            ]
                        )

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                ListTile(
                  leading: Icon(OMIcons.cardGiftcard),
                  title: Text('Cupones de viaje', style: kDrawerItemStyle),
                ),
                ListTile(
                  leading: Icon(OMIcons.history),
                  title: Text('Historial', style: kDrawerItemStyle),
                ),
                ListTile(
                  leading: Icon(OMIcons.notifications),
                  title: Text('Notificaciones', style: kDrawerItemStyle),
                ),
                ListTile(
                  leading: Icon(OMIcons.payment),
                  title: Text('Metodos de pago', style: kDrawerItemStyle),
                ),
                ListTile(
                  leading: Icon(OMIcons.verifiedUser),
                  title: Text('Mi cuenta', style: kDrawerItemStyle),
                ),



              ],
            )
        ),
      ),

      body: Stack(
        children: <Widget>[

          // Google Maps - Maps
        GoogleMap(
          padding: EdgeInsets.only(bottom: bottomPaddingOfMap,top: 25),
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          initialCameraPosition: _kGooglePlex,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,


          onMapCreated: (GoogleMapController controller)
            {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              setState(() {
                bottomPaddingOfMap = 300;
              });

              locatePosition();
            }

        ),
          //Boton de Menu
          Positioned(
            top: 44,
            left: 20,
            child: GestureDetector(
              onTap: (){
                scaffoldKey.currentState.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                      )
                    ]
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(Icons.menu, color: Colors.black87,),
                ),
              ),
            ),
          ),

          // Container bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 15.0,
                      spreadRadius: 0.4,
                      offset: Offset(0.7, 0.7)
                    )
                  ]),
                  //Container buscar dirección de destino
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      SizedBox(height: 5,),
                    Text('Es genial verte de nuevo', style: TextStyle(fontSize: 12),),
                    SizedBox(height: 5,),
                    Text('¿A donde quieres ir?', style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Brand-Regular',
                        fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Container(
                        decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7)

                        )
                      ],
                    ),

                      // Boton de buscar destino

                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.search,
                              color: Colors.blueAccent,),
                            SizedBox(width: 10,),
                            Text('Escribe aquí la dirección de destino'),
                          ],

                        ),
                      ),


                    ),
                        SizedBox(height: 20,),
                        // Agregar dirección de casa
                        Row(
                          children: <Widget>[
                            Icon(OMIcons.home, color: BrandColors.colorDimText,),
                            SizedBox(width: 12,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Mi casa'),
                                  SizedBox(height: 3,),
                                  Text('Escribe tú dirección de residencia',
                                    style: TextStyle(
                                        fontSize: 11, color: BrandColors.colorDimText),
                                  )],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        BrandDivider(),
                        SizedBox(height: 16,),
                        // Agregar dirección de trabajo
                        Row(
                          children: <Widget>[
                            Icon(OMIcons.workOutline, color: BrandColors.colorDimText,),
                            SizedBox(width: 12,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Agregar dirección de trabajo'),
                                SizedBox(height: 3,),
                                Text('Escribe tú dirección de tu oficina',
                                  style: TextStyle(
                                      fontSize: 11, color: BrandColors.colorDimText),
                                )],
                            )
                          ],
                        ),

              ]
                    )
                  ),

              )
          )

      ]
        ),
    );
  }
}
