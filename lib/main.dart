import 'package:flutter/material.dart';
import 'designDatabase.dart';
import 'designView.dart';
import 'utility.dart';

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

  Widget _designTile(Design design, int index){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async{
            final result = await Navigator.push(context, MaterialPageRoute(
              builder: (context) => DesignView(
                isNew: false,
                index: index,
                designList: _designList,
              ),
            ));

            if(result){
              _initializeDesigns();
            }
          },
          child: Card(
            margin: const EdgeInsets.all(10.0),
            elevation: 10,
            child: Container(
              color: Colors.white70,
              height: 100,
              width:330,
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  imageList[design.type],
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left:10),
                      child: Text(
                        design.name,
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon((design.textColor == 0 ? Icons.article_outlined : Icons.article), color: (design.textColor == 0 ? colorList[1] : colorList[design.textColor])),
                      Icon((design.backColor == 0 ? Icons.circle_outlined : Icons.circle), color: (design.backColor == 0 ? colorList[1] : colorList[design.backColor])),
                      Text(design.magazineCapacity.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const SizedBox(
            height: 100,
            width: 32,
            child: Center(
              child: Text('適用', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ],
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
          return _designTile(_designList[index], index);
        },
      ),
      floatingActionButton: Column(
        verticalDirection: VerticalDirection.up,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () async{
              final result = await Navigator.push(context, MaterialPageRoute(
                builder: (context) => DesignView(
                  isNew: true,
                  index: -1,
                  designList: _designList,
                ),
              ));

              if(result){
                _initializeDesigns();
              }
            },
            tooltip: 'Add new design',
            heroTag: 'Add new design',
            child: const Icon(Icons.add),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: FloatingActionButton(
              onPressed: () async{
                await Design.clearDesigns();
                final List<Design> _designs = await Design.getDesigns();
                setState(() {
                  _designList = _designs;
                });
              },
              tooltip: 'Clear designs',
              heroTag: 'Clear designs',
              child: const Icon(Icons.clear_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
