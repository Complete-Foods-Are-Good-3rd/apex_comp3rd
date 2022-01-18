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

  @override
  initState(){
    super.initState();
    Design _design = Design(name: '', type: 0, backColor: 0, textColor: 0);
    if(!widget.isNew) _design = widget.designList[widget.index];
    setState(() {
      _currentDesign = _design;
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

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: _barName(),
      ),
      body: Container(
        margin: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text(showId()),
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
