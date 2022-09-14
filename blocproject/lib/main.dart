import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_cubit.dart';
import 'package:blocproject/CounterBloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  final firebase=Firebase.initializeApp();


 // f s=new f();
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
              return  Scaffold(
                body: BlocProvider<CounterCubit>(
                  // builder: (BuildContext context)
                  // create: (counterCubitContext) => CounterCubit(),
                    create: (BuildContext context) => CounterCubit(0),
                    child : CounterScreen()

                ),
              );
            }
            else
              return Text("something");
          },
        )

      // return  Scaffold(
      //     body: BlocProvider<CounterCubit>(
      //         // builder: (BuildContext context)
      //         // create: (counterCubitContext) => CounterCubit(),
      //         create: (BuildContext context) => CounterCubit(0),
      //         child : CounterScreen()
      //
      //     ),
      //   )
    );
  }
}

class CounterScreen extends StatelessWidget {
DatabaseReference tf=FirebaseDatabase.instance.ref();
  read() async {
final snapshot = await tf.child('number').get() ;
    return snapshot.value;
  }
  update(int n) async {
    await tf.update({
      "number": "$n",
    });
  }



  @override
  Widget build(BuildContext context) {

    final _counterBloc = BlocProvider.of<CounterCubit>(context);
    final dsfds=read();
    // print(dsfds.);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: dsfds,
            builder: (context,snapshot){
// print(snapshot.data);
              String sdf=snapshot.data.toString();
              print(snapshot.data.toString());
              print(int.parse(sdf) );
_counterBloc.emit(CounterState(counterValue: int.parse(sdf)));
              // children: [
                return Column(
                  children: <Widget>[


                    BlocBuilder<CounterCubit,CounterState>(
                      builder: (BuildContext context,counterValue){
                        // snapshot.data;
                        return Text("Count Value : $counterValue", style: TextStyle(fontSize: 30),);
                      },
                    ),


                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          child: Text("increment"),
                          onPressed: (){
                            // _counterBloc.emit(CounterState(counterValue: 9));
                            _counterBloc.increment();
                            update(_counterBloc.state.counterValue);
                          },
                        ),

                        TextButton(
                          child: Text("decrement"),
                          onPressed: (){
                            _counterBloc.decrement();
                            update(_counterBloc.state.counterValue);
                          },
                        ),
                      ],
                    )

                  ],
                );
              // ];
            }

          ),
        ],
      ),
    );
  }
}

