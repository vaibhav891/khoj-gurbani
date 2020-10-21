import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:khojgurbani_music/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAndRegistrationService {
  var prefs;
  bool isUserLogedin = false;

// GET MACHINE ID
  Future<List<String>> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    getMachineId(identifier);
    print(identifier);
    return [deviceName, deviceVersion, identifier];
  }

  getMachineId(identifier) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('machine_id', identifier.toString());
  }

  setUser(data) async {
    prefs = await SharedPreferences.getInstance();

    prefs.setString('token', data['token']);
    prefs.setInt('user_id', data['user']['id']);
    prefs.setString('name', data['user']['name']);
    prefs.setString('email', data['user']['email']);
    prefs.setString('photo', data['user']['photo_url']);
    prefs.setString('city', data['user']['city']);
    prefs.setString('state', data['user']['state']);
    prefs.setString('country', data['user']['country']);
    // prefs.setString('photo_url', data['user']['photo_url']);
  }

  // SIMPLE LOGIN

  bool isError = false;

  login(String email, String password) async {
    final res = await http.post(
        'https://api.khojgurbani.org/api/v1/android/login',
        body: {'email': email, 'password': password});
    final data = jsonDecode(res.body);
    if (res.statusCode == 200) {
      if (data['token'] != '' || data['token'] != null) {
        setUser(data);
        // Navigator.pushNamedAndRemoveUntil(
        //     context, '/media', ModalRoute.withName('/'));
        // _email.clear();
        // _password.clear();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? "Error with token!";
        final machineId =
            prefs.getString('machine_id') ?? "Error with machine_id!";
        final userId = prefs.getInt('user_id') ?? "Error with user_id";
        isUserLogedin = true;
        isError = false;
        print(token);
        print(userId);
        print(machineId);
      } else {
        print("Something went wrong!");
      }
    } else {
      isError = true;
    }
  }

  var user;

  Future getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final token = prefs.getString('token');

    final headers = {'Authorization': "Bearer " + token};
    final response = await http.get(
        'https://api.khojgurbani.org/api/v1/user/$userId',
        headers: headers);
    var jsonData = json.decode(response.body);

    UserDetails result = new UserDetails.fromJson(jsonData);

    print(user.toString() + " AAAAAAAAAAAAAAAAAAAAA");

    return user;
  }

  clearAllData() {
    user = null;
    logout();
  }

  // LOGOUT AND CLEAR WHOLE SHAREDPREFERENCES
  logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('user_id');
    pref.remove('token');
    pref.remove('photo');
    pref.remove('name');
    pref.remove('email');
    pref.remove('city');
    pref.remove('state');
    pref.remove('country');
    isUserLogedin = false;
  }

  // LOGIN WITH GOOGLE
  void loginWithGoogle() async {
    logout();
    user = '';
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        // you can add extras if you require
      ],
    );
    String id;
    String email;
    String name;
    String photo;
    String provider = 'Google';

    setUserGoogle(data) async {
      prefs = await SharedPreferences.getInstance();
      prefs.remove('user_id');
      prefs.remove('token');

      prefs.setInt('user_id', data['user']['id']);
      prefs.setString('token', data['token']);
      prefs.setString('name', name);
      prefs.setString('email', data['user']['email']);
      prefs.setString('photo', photo);
    }

    loginWithGoogle() async {
      final res = await http.post(
          'https://api.khojgurbani.org/api/v1/android/login-with-social?',
          body: {
            "name": name,
            "email": email,
            "photo_url": json.encode(photo),
            "social_account_id": json.encode(id),
            "provider": provider
          });
      var data = JsonDecoder().convert(res.body);

      // print(user.toString());
      setUserGoogle(data);
      isUserLogedin = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();

      var userId = prefs.getInt('user_id');
      var userName = prefs.getString('name');
      print(userId);
      print(userName);
    }

    _googleSignIn.signIn().then((GoogleSignInAccount acc) async {
      GoogleSignInAuthentication auth = await acc.authentication;
      print(acc.id);
      print(acc.email);
      print(acc.displayName);
      print(acc.photoUrl);
      id = acc.id;
      email = acc.email;
      name = acc.displayName;
      photo = acc.photoUrl;
      loginWithGoogle();
      acc.authentication.then((GoogleSignInAuthentication auth) async {
        print(auth.idToken);
        print(auth.accessToken);
      });
    });
  }

  static Future<void> signOut() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        // you can add extras if you require
      ],
    );
    _googleSignIn.signOut();
    print("odjava");
  }

  // FACEBOOK LOGIN
  // void facebookLogin() async {
  //   final facebookLogin = FacebookLogin();
  //   final facebookLoginResult = await facebookLogin.logIn(['email']);

  //   print(facebookLoginResult.accessToken);
  //   print(facebookLoginResult.accessToken.token);
  //   print(facebookLoginResult.accessToken.expires);
  //   print(facebookLoginResult.accessToken.permissions);
  //   print(facebookLoginResult.accessToken.userId);
  //   print(facebookLoginResult.accessToken.isValid());

  //   print(facebookLoginResult.errorMessage);
  //   print(facebookLoginResult.status);

  //   final token = facebookLoginResult.accessToken.token;

  //   /// for profile details also use the below code
  //   final graphResponse = await http.get(
  //       'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
  //   final profile = json.decode(graphResponse.body);
  //   print(profile);
  // }

  var userId;
  var userName;
  var token;
  var email;
  var photo;
  var city;
  var state;
  var country;
  var machineId;
  getUserTest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id');
    userName = prefs.getString('name');
    token = prefs.getString('token');
    email = prefs.getString('email');
    photo = prefs.getString('photo');
    city = prefs.getString('city');
    state = prefs.getString('state');
    country = prefs.getString('country');
    machineId = prefs.getString('machine_id');
    print(userId);
    print(userName);
    print(token);
    print(email);
    print(photo);
    print(city);
    print(state);
    print(country);
    print(machineId);
    print(isUserLogedin.toString());
    print(isError.toString());
  }
}
