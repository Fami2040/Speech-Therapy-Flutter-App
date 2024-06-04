import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'usage_tracker.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Usage (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        screenName TEXT,
        duration INTEGER,
        category TEXT,
        timestamp TEXT
      )
    ''');
  }

  Future<void> insertUsage(String screenName, Duration duration, String category) async {
    final db = await database;
    await db.insert(
      'Usage',
      {
        'screenName': screenName,
        'duration': duration.inSeconds,
        'category': category,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  Future<List<Map<String, dynamic>>> getUsageData() async {
    final db = await database;
    return await db.query('Usage');
  }
}
