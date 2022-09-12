import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'firebase_options.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutterproject/login.dart';
import 'package:flutterproject/grid gallery.dart';

import 'package:flutterproject/image upload.dart';
import 'dart:convert';

enum Options { search, upload, copy, exit }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await  Firebase.initializeApp();
  runApp( main2());
}

class main2 extends StatelessWidget {
   main2({super.key});
final firebase=Firebase.initializeApp();
   //

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home:
      FutureBuilder(
        future: firebase,
        builder: (context,snapshot){
          if(snapshot.hasError){
            print(snapshot.error.toString());
          return Text("something went wrong!");
          }
            else if(snapshot.hasData) {
            print(snapshot.data);
            // print(tf.)
            return MyHomePage(title: 'Flutter Demo Home Page');
          }
            else
              return Text("something");
        },
      )
      // const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  var ctime;
  DatabaseReference tf=FirebaseDatabase.instance.ref();

  PopupMenuItem _buildPopupMenuItem(
      String title, IconData iconData, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.black,
          ),
          Text(title),
        ],
      ),
    );
  }
  
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // <-- SEE HERE
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }
  
  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(

        onWillPop: _onWillPop,
        // () {
        //   DateTime now = DateTime.now();
        //   if (ctime == null || now.difference(ctime) > Duration(seconds: 2)) {
        //     //add duration of press gap
        //     ctime = now;
        //     ScaffoldMessenger.of(context).showSnackBar(
        //         SnackBar(content: Text('Press Back Button Again to Exit'))
        //     ); //scaffold message, you can show Toast message too.
        //     return Future.value(false);
        //   }
        //
        //   return Future.value(true);
        // },
        child: Scaffold(
        appBar: AppBar(
          title: Text("jhvjm"),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) =>[
                _buildPopupMenuItem('Search/write', Icons.search, Options.search.index),
                _buildPopupMenuItem('Upload/read', Icons.upload, Options.upload.index),
                _buildPopupMenuItem('Copy/update', Icons.copy, Options.copy.index),
                _buildPopupMenuItem('Exit', Icons.exit_to_app, Options.exit.index),
              ],
              icon: Icon(
                Icons.settings,
                size: 35,
                color: Colors.white,
              ),
              // initialValue: 2,
              onCanceled: () {
                print("you have cancelled menu.");
              },
              onSelected: (value) async {
                print("value: $value");
                // DatabaseReference tf=FirebaseDatabase.instance.ref();
                if (value==0)
                tf.child("test").set("Ds");
                if (value==1){
                  final snapshot = await tf.child('name').get();
                  if (snapshot.exists) {
                    print(snapshot.value);
                  } else {
                    print('No data available.');
                  }
                }
                if(value==2){
                  await tf.update({
                    "name": "fdgfd",
                  });
                }

                // tf.
                if (value==3){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const login()),
                  );
                }
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  accountName: Text(
                    "Abhishek Mishra",
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text("abhishekm977@gmail.com"),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 165, 255, 137),
                    child: Text(
                      "A",
                      style: TextStyle(fontSize: 30.0, color: Colors.blue),
                    ), //Text
                  ), //circleAvatar
                ), //UserAccountDrawerHeader
              ), //DrawerHeader
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text(' My Profile '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text(' My Course '),
                onTap: () {
                  _navigateToNextScreen(context);
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.workspace_premium),
                title: const Text(' Go Premium '),
                onTap: () {
                  _navigateToNextScreen(context);
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.video_label),
                title: const Text(' Saved Videos '),
                onTap: () {
                  _navigateToNextScreen(context);
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text(' Edit Profile '),
                onTap: () {
                  _navigateToNextScreen(context);
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {
                  _navigateToNextScreen(context);
                  // Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    actions: <Widget>[],
                    title: TabBar(
                      tabs: [
                        Tab(icon: new Icon(Icons.directions_car)),
                        Tab(icon: new Icon(Icons.directions_transit)),
                        Tab(icon: new Icon(Icons.directions_bike)),
                      ],
                      indicatorColor: Colors.white,
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      NewScreen3(),
                      NewScreen2(),
                      RouteOne(),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
    ),
      );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NewScreen()));
  }

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
}

class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const ImageUploads(),
    );
  }
}

class NewScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return           Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.arrow_drop_down_circle),
            title: const Text('Card title 1'),
            subtitle: Text(
              'Secondary Text',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(

                // textColor: const Color(0xFF6200EE),
                onPressed: () {
                  // Perform some action
                  Fluttertoast.showToast(
                      msg: "This is a Toast message",
                      // message
                      toastLength: Toast.LENGTH_SHORT,
                      // length
                      gravity: ToastGravity.CENTER // location
                    // duration
                  );
                },
                child: const Text('ACTION 1'),
              ),
              TextButton(
                // textColor: const Color(0xFF6200EE),

                onPressed: () {
                  // Perform some action
                  Fluttertoast.showToast(
                      msg: "This is a Toast message",
                      // message
                      toastLength: Toast.LENGTH_SHORT,
                      // length
                      gravity: ToastGravity.CENTER // location
                    // duration
                  );
                },
                child: const Text('ACTION 2'),
              ),
            ],
          ),
          Image.asset('assets/images/shape_of_you.jpg'),
          // Image.asset('assets/card-sample-image-2.jpg'),
        ],
      ),
    );
  }
}

class NewScreen2 extends StatelessWidget {
  Future<List<User>> usersf = getUsers();

  static Future<List<User>> getUsers() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'))
        .catchError((err) {
      print(err);
    });
    debugPrint("");
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      // Log
      return jsonResponse.map((data) => User.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<User>>(
          future: usersf,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              final List<User> users = snapshot.data!;
              return buildUsers(users);
            } else {
              return const Text("no data");
            }
          }),
    );
  }

  Widget buildUsers(List<User> users) => Expanded(
        child: SizedBox(
          height: 700.0,
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 28,
                    // foregroundImage: NetworkImage(user.thumbnail),
                    backgroundImage: NetworkImage(user.urlAvatar),
                  ),
                  title: Text(user.id.toString()),
                  subtitle: Text(user.email.toString()),
                ),
              );
            },
          ),
        ),
      );
}

class User {
  final int username;
  final String email;
  final int id;
  final String urlAvatar;
  final String thumbnail;

  const User({
    required this.username,
    required this.email,
    required this.urlAvatar,
    required this.id,
    required this.thumbnail,
  });

  // static User fromJson(json)=>User(
  //   username: json['id'],
  //   email: json['title'],
  //   urlAvatar: json['url'],
  // );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['albumId'],
        id: json['id'],
        email: json['title'],
        urlAvatar: json['url'],
        thumbnail: json['thumbnailUrl']);
  }
}

class NewScreen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
RouteOne();


      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const login()),
      // );




    //   runApp(
    //   MaterialApp(debugShowCheckedModeBanner: false, initialRoute: '/', routes: {
    //     '/': (context) => RouteOne(),
    //     '/detail': (context) => RouteTwo(image: '', name: ''),
    //   }),
    // );
    // TODO: implement build
    // throw UnimplementedError();
  }
  
}
