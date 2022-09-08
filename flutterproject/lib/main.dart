import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutterproject/tab.dart';
import 'package:flutterproject/login.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp2());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
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
      ), //Deawer

      appBar: AppBar(

        title: Text("Flutter Card"),
      ),
      body: Column(
        children: [
          Card(
            elevation: 8,
            margin: EdgeInsets.all(10),
            child: Container(
              height: 100,
              color: Colors.white,
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Expanded(
                        flex: 2,
                        child: Image.asset("assets/images/shape_of_you.jpg"),
                        // child:Image.network( // <-- SEE HERE
                        //   'https://picsum.photos/id/1074/400/400',
                        // ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: ListTile(
                              title: Text("Shape Of You"),
                              subtitle: Text("Ed Sheeran"),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: Text("PLAY"),
                                  onPressed: () {
                                    Fluttertoast.showToast(
                                        msg: "This is a Toast message",
                                        // message
                                        toastLength: Toast.LENGTH_SHORT,
                                        // length
                                        gravity: ToastGravity.CENTER // location
                                        // duration
                                        );
                                  },
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                TextButton(
                                  child: Text("ADD TO QUEUE"),
                                  onPressed: () {},
                                ),
                                SizedBox(
                                  width: 8,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
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
          ),
        ],
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NewScreen()));
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

class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Screen')),
      body: const Center(
        child: Text(
          'This is a new screen',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
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
