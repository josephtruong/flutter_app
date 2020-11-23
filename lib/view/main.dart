import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/Android/flutter_app/flutter_app/lib/blocs/counterbloc.dart';
import 'package:flutter_app/model/request_login.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/view/movie_screen.dart';
import 'file:///D:/Android/flutter_app/flutter_app/lib/model/login.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Demo',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.blue,
          ),
          FloatingActionButton(
              child: StreamBuilder<String>(
                  initialData: "",
                  stream: _loginBloc.requestLoginStream,
                  builder: (context, snapshot) {
                   if (snapshot.data != "") {
                     switch (snapshot.data) {
                       case "Ok":
                         Navigator.of(context).push(MaterialPageRoute(
                             builder: (context) => MovieScreen()));
                         break;
                     }
                   }
                    return Container();
                  }),
              onPressed:  _loginBloc.login(RequestLogin("", ""))

          )
        ],
      ),
    );
  }

/*  Future<List<User>> getUser() async{
     final res = await http.get('https://jsonplaceholder.typicode.com/posts');
     return User().parseUser(res.body);
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: Text('Usser'),),
       body: FutureBuilder(
           future: getUser(),
           builder: (context, snapshot){
              if (snapshot.hasError) print(snapshot.error);
              List<User> user = snapshot.data;
              return snapshot.hasData ? ListView.builder(
                  itemCount: user.length,
                  itemBuilder: (context, index){
                     return ListTile(title: Text(user[index].title), subtitle: Text(user[index].body),);
                  }): Center(child: CupertinoActivityIndicator(),);
           })
     );
  }*/

/*CounterBloc _counterBloc = CounterBloc(initialCount: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
                stream: _counterBloc.counterObservable,
                builder: (context, AsyncSnapshot<int> snapshot) {
                  return Text('${snapshot.data}');
                }
            )

          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: _counterBloc.increment,
            tooltip: 'Increment',
            child: Icon(Icons.add),),
          FloatingActionButton(onPressed: _counterBloc.decrement,
            tooltip: 'Decrement',
            child: Icon(Icons.remove),)
        ],

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }*/
}
