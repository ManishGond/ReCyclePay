import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:testproject/bottomNavPages/qrcode.dart';
import '../maps/map_screen_container.dart';
import '../onpage/animatedRefresh.dart';
import '../onpage/sliderwidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //bool _isBlur = true;
  String location = '';
  String address = '';
  late Position position;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLong(Position p) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(p.latitude, p.longitude);
    Placemark place = placemarks.first;

    address = '${place.subLocality}, ${place.locality}, ${place.postalCode}';
    setState(() {});
  }

  Future<void> _getLocation() async {
    try {
      position = await _getGeoLocationPosition();
      location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
      getAddressFromLatLong(position);
    } catch (e) {
      print('Error: $e');
    }
  }

  double _progress = 0.2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade800.withOpacity(0.8),
                        Colors.blue.shade300.withOpacity(0.9)
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(30),
                      topRight: Radius.circular(60),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(5, 10),
                        blurRadius: 15,
                        color: Colors.grey.shade700,
                      )
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Transform(
                              transform: Matrix4.translationValues(0, -15, 0),
                              child: const Text(
                                "Todays",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Transform(
                              transform: Matrix4.translationValues(220, -15, 0),
                              child: IconButton(
                                onPressed: () {
                                  showToast('Scan The QR code on the Bottle');

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const UserQRCode()),
                                  );
                                  // Handle button press
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Transform(
                              transform: Matrix4.translationValues(0, -10, 0),
                              child: const Text(
                                "06 / 30",
                                style: TextStyle(
                                  fontSize: 47,
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: ,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Transform(
                            transform: Matrix4.translationValues(-15, -10, 0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 15,
                                    width: 270,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey[300],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: LinearProgressIndicator(
                                        value: _progress,
                                        minHeight: 15,
                                        backgroundColor: Colors.grey[300],
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.blue.shade300),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Transform(
                                transform: Matrix4.translationValues(0, -5, 0),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: Text(
                                    '📍 $address',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Transform(
                                transform: Matrix4.translationValues(0, -8, 0),
                                child: AnimatedRefreshButton(
                                  onPressed: () async {
                                    Position position =
                                        await _getGeoLocationPosition();
                                    location =
                                        'Lat: ${position.latitude} , Long: ${position.longitude}';
                                    getAddressFromLatLong(position);
                                    // Handle button press
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                //for the map container
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 99, 153, 214)
                                .withOpacity(0.8),
                            Colors.blue.shade300.withOpacity(0.9),
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(5, 5),
                            blurRadius: 10,
                            color: Colors.grey.shade700,
                          ),
                        ],
                      ),
                    ),
                    const Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: MapScreenSmall(),
                      ),
                    ),
                    /*Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isBlur = !_isBlur;
                          });
                        },
                        child: GlassMorphism(
                            blur: _isBlur ? 10 : 0,
                            opacity: 0.2,
                            child: const SizedBox(
                              height: 220,
                              width: 380,
                            )),
                      ),
                    ),*/
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: const BoxDecoration(
                      // Your decoration properties here
                      ),
                  child: SliderP(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }
}
