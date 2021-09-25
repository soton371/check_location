
import 'package:check_location/dbuserservice.dart';
import 'package:check_location/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class SendLocation extends StatefulWidget {
  //const SendLocation({Key? key}) : super(key: key);
  var recive_user, email;
  SendLocation({this.recive_user, this.email});

  @override
  _SendLocationState createState() => _SendLocationState();
}

class _SendLocationState extends State<SendLocation> {

  var lat,lon;
  StreamSubscription<Position> streamSubscription;
  var _address;
  var _position;

  getLocation() async{
    final geoposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = geoposition.latitude;
      lon = geoposition.longitude;

    });

    streamSubscription = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.high, distanceFilter: 10).listen((Position position) {
      setState(() {
        _position = position;

        final coordinates = new Coordinates(
            position.latitude, position.longitude);
        convertCoordinateToAddress(coordinates).then((value) =>
        _address = value);
      });
    });
  }

  Future convertCoordinateToAddress(Coordinates coordinates) async {
    var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return address.first;
  }

  final CollectionReference brewcollection = Firestore.instance.collection('Users');
  String uid;
  Future<void> sendData()async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await DataBaseUserService(uid: user.uid).UpdateUserData(
      _address?.addressLine ?? "null address",
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    Timer(Duration(minutes: 1), sendData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Text(_address?.addressLine ?? "null address"),
              FlatButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupPage()),result: (route) => false);
                  },
                  child: Text("logout"),
                color: Colors.blue,
              )
            ],
          )
      ),
    );
  }
}

