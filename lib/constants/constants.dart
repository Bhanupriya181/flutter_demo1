
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

//login with email
const String USER_EMAIL = "email";
const String USER_PASSWORD = "password";
const String IS_LOGIN_WITH_MAIL = "isLoginWIthEmail";
const String IS_LOGIN_WITH_MPIN = "isLoginWIthMpin";
const String IS_BLOCK_DATA_DOWNLOADED = "isBlockDataDownloaded";
const String MPIN = "m_pin";
const String ISMPINSAVED = "m_pin_saved";
const String DRAFT_TYPE = "draft" ;
const String SYNC_TYPE = "sync" ;
const String PENDING_TYPE = "pending" ;
class Constants {
  Constants._privateConstructor();
  static final Constants instance = Constants._privateConstructor();

  ///Used to save string value in shared preference
  saveStringValue(String key, String value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(key, value);
  }
  ///Used to get string value
  Future<String?> getStringValue(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString(key);
    return data;
  }
  ///Used to save boolean value
  saveBooleanValue(String key, bool value) async {
    SharedPreferences myPref = await SharedPreferences.getInstance();
    myPref.setBool(key, value);
  }

  ///Used to get boolean value
  Future<bool?> getBooleanValue(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? data = preferences.getBool(key);
    if(data != null) {
      return true ;
    } else {
      return false;
    }

  }

  removeAllFromSharedPreference() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.clear();
  }

  ///Used to check Internet Connectivity
  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  /*//get current location
  Future<Position?> getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // If location services are not enabled, return null or handle appropriately
      debugPrint('Location services are disabled.');
      return null;
    }

    // Check the permission status
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if it is denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied again, return null or handle it accordingly
        print('Location permissions are denied.');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle the case where permissions are permanently denied
      print('Location permissions are permanently denied.');
      return null;
    }

    // If permissions are granted, fetch the current location
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      // Handle potential errors like GPS not being available
      print('Error getting location: $e');
      return null;
    }
  }*/

}