import 'package:flutter/material.dart';
import 'designDatabase.dart';

class DesignView extends StatefulWidget {
  const DesignView({Key key, this.isNew, this.index, this.designList}) : super(key: key);

  final bool isNew;
  final int index;
  final List<Design> designList;

  @override
  State<DesignView> createState() => _DesignView();
}

class _DesignView extends State<DesignView> {
  Design _currentDesign;
  int _type = 0;
  int _backColor = 0;
  int _textColor = 0;

  @override
  initState(){
    super.initState();
    Design _design = Design(name: '', type: 0, backColor: 0, textColor: 0, magazineCapacity: 0, reloadDistance: 0);
    if(!widget.isNew) _design = widget.designList[widget.index];
    setState(() {
      _currentDesign = _design;
      _type = _currentDesign.type;
      _backColor = _currentDesign.backColor;
      _textColor = _currentDesign.textColor;
    });
  }

  Widget _barName(){
    String text;
    if(widget.isNew){
      text = '新規デザイン';
    }else{
      text = 'デザイン編集';
    }

    return Text(text);
  }

  String showId(){
    String text = 'ID：';
    if(widget.isNew){
      text += "-";
    }else{
      text += _currentDesign.id.toString();
    }

    return text;
  }

  Future<void> _saveNewDesign() async{
    await Design.insertDesign(_currentDesign);
  }

  Future<void> _updateDesign() async{
    await Design.updateDesign(_currentDesign);
  }


  void _saveDesign(){
    if(widget.isNew){
      _saveNewDesign();
    }else{
      _updateDesign();
    }
    Navigator.pop(context, true);
  }

  Future<void> _deleteMyDesign() async{
    await Design.deleteDesign(_currentDesign.id);
  }

  void _deleteDesign(){
    if(!widget.isNew){
      _deleteMyDesign();
    }

    Navigator.pop(context, true);
  }

  Widget typeList({String title, int value}){
    return RadioListTile(
      secondary: Icon(Icons.ac_unit),
      title: Text(title),
      value: value,
      groupValue: _type,
      onChanged: (int e) => {
        setState(() {
          _type = e;
          _currentDesign.type = e;
        }),
      },
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: _barName(),
      ),
      body: Container(
        margin: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text(showId()),
            TextField(
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'デザイン名',
              ),
              controller: TextEditingController(text: _currentDesign.name),
              onChanged: (text) {
                _currentDesign.name = text;
              },
            ),
            TextField(
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'マガジン容量',
              ),
              controller: TextEditingController(text: _currentDesign.magazineCapacity.toString()),
              keyboardType: TextInputType.number,
              onChanged: (text) {
                _currentDesign.magazineCapacity = int.parse(text);
              },
            ),
            SizedBox(
              height: 200,
              width: 150,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    typeList(title: '0', value: 0),
                    typeList(title: '1', value: 1),
                    typeList(title: '2', value: 2),
                    typeList(title: '3', value: 3),
                    typeList(title: '4', value: 4),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                // SingleChildScrollView(
                //   child: Text('hogehoehgeogoee'),
                // ),
                // SingleChildScrollView(
                //   child: Text('hogehoehgeogoee'),
                // ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('リロード検知距離：${_currentDesign.reloadDistance}'),
                ElevatedButton(
                  child: const Text('測定'),
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _saveDesign,
                  child: const Text('保存'),
                ),
                OutlinedButton(
                  onPressed: _deleteDesign,
                  child: const Text('削除'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
