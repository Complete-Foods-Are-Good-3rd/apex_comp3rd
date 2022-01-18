import 'package:flutter/material.dart';
import 'designDatabase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APEX App',
      debugShowCheckedModeBanner: false,
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
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'APEX App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Design> _designList = [];

  Future<void> _initializeDesigns() async{
    final List<Design> designs = await Design.getDesigns();
    setState(() {
      _designList = designs;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeDesigns();
  }

  Future<void> _addDesign() async{
    final _design = Design(name: 'hoge', type: 1, backColor: 1, textColor: 1);
    await Design.insertDesign(_design);
    if(_designList.length >= 10) Design.clearDesigns();
    final List<Design> designs = await Design.getDesigns();
    setState(() {
      _designList = designs;
    });
  }

  Widget _designTile(Design design){
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Container(
        color: Colors.white70,
        height: 100,
        width: 200,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: _designList.length,
        itemBuilder: (BuildContext context, int index){
          return _designTile(_designList[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDesign,
        tooltip: 'Add design',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
