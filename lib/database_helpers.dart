import 'dart:io';
import 'package:path/path.dart';
import 'package:quiz_u/data/models/top_scors/score_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
const String tableUserScore = 'scores';
const String columnId = '_id';
const String columnScore = 'score';
const String columnTime = 'time';

// data model class
class UserScore {

  int? id;
  String? score;
  String? time;

  UserScore({this.id,this.score,this.time});

  // convenience constructor to create a Word object
  UserScore.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    score = map[columnScore];
    time = map[columnTime];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnScore: score,
      columnTime: time
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static const _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static const _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableUserScore (
                $columnId INTEGER PRIMARY KEY,
                $columnScore TEXT NOT NULL,
                $columnTime INTEGER NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(UserScore score) async {
    Database? db = await database;
    int id = await db!.insert(tableUserScore, score.toMap());
    return id;
  }

  Future<UserScore?> queryUserScore(int id) async {
    Database? db = await database;
    List<Map<String,dynamic>> maps = await db!.query(tableUserScore,
        columns: [columnId, columnScore, columnTime],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return UserScore.fromMap(maps.first);
    }
    return null;
  }
  Future<List<UserScore>?> queryAllUserScore() async {
    Database? db = await database;
    List<UserScore>  scores=[];
    List<Map<String,dynamic>> maps = await db!.query(tableUserScore, columns: [ columnScore, columnTime]);
    if (maps.isNotEmpty) {

      for(var score in maps){
        scores.add(UserScore.fromMap(score));
      }
      return scores;
    }
    return null;
  }

// TODO: queryAllWords()
// TODO: delete(int id)
// TODO: update(Word word)
}
