import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geotracker/authentication/register.dart';
import './navigation/dashboard.dart';

import './navigation/navigate.dart';
import './navigation/availableCars.dart';

void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'register':(context) => RegisterDemo(),
        'dashboard':(context) => dashboard(),
        'navigate':(context) => NavigationPage(title: "yes"),
        'showMap':(context) => AvailableCars(),
        'login':(context) => MyHomePage(title: "Login")
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position? _currentPosition;
  int _counter = 0;
    TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController nationality = TextEditingController();
  final controller = MapController();
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
        final scaffold = ScaffoldMessenger.of(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
     body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: const Icon(
                      Icons.app_registration,
                      color: Colors.blue,
                      size: 80.0,
                    )),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    // ignore: prefer_const_constructors
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            //   const SizedBox(
            //   height: 40.0,
            // ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 10.0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: 15.0, right: 15.0, top: 0, bottom: 10.0),
            //   child: TextField(
            //     controller: username,
            //     decoration: InputDecoration(
            //         // ignore: prefer_const_constructors
            //         border: OutlineInputBorder(),
            //         labelText: 'username',
            //         hintText: 'choose a username e.g jane doe'),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: 15.0, right: 15.0, top: 0, bottom: 10.0),
            //   child: TextField(
            //     controller: gender,
            //     decoration: InputDecoration(
            //         // ignore: prefer_const_constructors
            //         border: OutlineInputBorder(),
            //         labelText: 'Gender',
            //         hintText: 'Male or Female'),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: 15.0, right: 15.0, top: 0, bottom: 10.0),
            //   child: TextField(
            //     controller: nationality,
            //     decoration: InputDecoration(
            //         // ignore: prefer_const_constructors
            //         border: OutlineInputBorder(),
            //         labelText: 'nationality',
            //         hintText: 'e.g kenyan'),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: 15.0, right: 15.0, top: 0, bottom: 10.0),
              
            // ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FloatingActionButton(
                onPressed: () {
                  if (email.text == '') {
                    scaffold.showSnackBar(const SnackBar(
                        backgroundColor: Colors.blue,
                        content: Text('Enter an Email')));
                  } else if (password.text == '') {
                    scaffold.showSnackBar(SnackBar(
                      content: const Text('Enter a Password'),
                      backgroundColor: Colors.blue,
                    ));
                  } else {
                    try {
                    FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email.text, password: password.text)
                              .then((value) => 
                              Navigator.pushNamed(context, 'dashboard')
                              );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == "Firebase_auth/user-not-found") {
                        // scaffold.showSnackBar(SnackBar(
                        //   content:
                        //       const Text('No user Found with that email'),
                        //   backgroundColor: Colors.blue,
                        // ));
                        print("user-not-found");
                      } else {
                        scaffold.showSnackBar(SnackBar(
                          content: const Text('wrong Password'),
                          backgroundColor: Colors.blue,
                        ));
                      }
                    }
                  }
                  print(email.text);
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(onPressed: (){
              Navigator.pushNamed(context, 'register');
            }, child: Text("Register a Vehicle")),
          ],
        ),
      ),
    );
    
  }
 
}
