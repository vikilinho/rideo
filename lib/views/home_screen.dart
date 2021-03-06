import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

var currentPost;

class HomeScreen extends StatefulWidget {
  static const String homeID = 'HOME_SCREEN';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Position currentPosition;
  var mapPadding = 0.0;

  Completer<GoogleMapController> _mapcontroller = Completer();
  late GoogleMapController _googleMapController;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void getCurrentLocation() async {
    var location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = location;
    LatLng latLng = LatLng(currentPosition.latitude, currentPosition.longitude);
    CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 15);
    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
        color: Colors.white,
        width: 255,
        child: Drawer(
            semanticLabel: "Menu",
            child: ListView(
              children: [
                Container(
                  height: 200,
                  child: DrawerHeader(
                      child: Row(children: [
                        Image.asset(
                          'images/user_icon.png',
                          height: 65,
                          width: 65,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Profile Name",
                              style: GoogleFonts.sahitya(),
                            ),
                            Text(
                              "Visit Profile",
                              style: GoogleFonts.sahitya(fontSize: 12),
                            )
                          ],
                        )
                      ]),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      )),
                ),
                Divider(
                  height: 2.5,
                ),
                SizedBox(
                  height: 12,
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text("Ride History"),
                ),
                ListTile(
                  leading: Icon(Icons.person_off_outlined),
                  title: Text("Ride Profile"),
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About"),
                ),
              ],
            )),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapPadding),
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _mapcontroller.complete(controller);
              _googleMapController = controller;
              setState(() {
                mapPadding = 300.0;
              });
              getCurrentLocation();
            },
          ),
          Positioned(
              top: 45,
              left: 25,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 6.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.0, 0.0))
                    ]),
                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                  ),
                ),
              )),
          Positioned(
            right: 0.0,
            bottom: 0.0,
            left: 0.0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.34,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 20,
                        spreadRadius: 0.5,
                        offset: Offset(0, -10)),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Hey!",
                      style: GoogleFonts.sahitya(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Where do you wanna go?",
                      style: GoogleFonts.sahitya(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7))
                          ]),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search,
                              color: Colors.teal,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(" Search"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Icon(Icons.home),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add Home Address"),
                            SizedBox(height: 4.0),
                            Text(
                              "Your home address",
                              style: GoogleFonts.sahitya(
                                  color: Colors.grey[600], fontSize: 12.0),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 2.0,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(Icons.work),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add Work Address"),
                            SizedBox(height: 3.0),
                            Text(
                              "Your work address",
                              style: GoogleFonts.sahitya(
                                  color: Colors.grey[600], fontSize: 12.0),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
