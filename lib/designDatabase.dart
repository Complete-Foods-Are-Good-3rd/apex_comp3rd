import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Design{
  final int id; //内部ID
  final String name; //デザイン名
  final int type; //テンプレのタイプ
  final int backColor; //背景色
  final int textColor; //文字色
  final int magazineCapacity; //マガジン容量
  final double reloadDistance; //リロード検知距離

  Design({this.id, this.name, this.type, this.backColor, this.textColor, this.magazineCapacity, this.reloadDistance});

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'name': name,
      'type': type,
      'backColor': backColor,
      'textColor': textColor,
      'magazineCapacity': magazineCapacity,
      'reloadDistance': reloadDistance,
    };
  }

  @override
  String toString(){
    return 'Design{id: $id, name: $name, type: $type, backColor: $backColor, textColor: $textColor, magazineCapacity: $magazineCapacity, reloadDistance: $reloadDistance}';
  }

  static Future<Database> get database async{
    final Future<Database> _database = openDatabase(
      join(await getDatabasesPath(), 'design_database_v2.db'),
      onCreate: (db, version){
        return db.execute(
          "CREATE TABLE design(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, type INTEGER, backColor INTEGER, textColor INTEGER, magazineCapacity INTEGER, reloadDistance REAL)",
        );
      },
      version: 1,
    );
    return _database;
  }

  static Future<void> insertDesign(Design design) async{
    final Database db = await database;
    await db.insert(
      'design',
      design.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Design>> getDesigns() async{
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('design');
    return List.generate(maps.length, (i){
      return Design(
        id: maps[i]['id'],
        name: maps[i]['name'],
        type: maps[i]['type'],
        backColor: maps[i]['backColor'],
        textColor: maps[i]['textColor'],
        magazineCapacity: maps[i]['magazineCapacity'],
        reloadDistance: maps[i]['reloadDistance'],
      );
    });
  }

  static Future<void> updateDesign(Design design) async{
    final db = await database;
    await db.update(
      'design',
      design.toMap(),
      where: "id = ?",
      whereArgs: [design.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<void> deleteDesign(int id) async{
    final db = await database;
    await db.delete(
      'design',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> clearDesigns() async{
    final db = await database;
    await db.delete(
      'design',
    );
  }
}
