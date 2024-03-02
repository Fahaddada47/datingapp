import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database _database;

  Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'user_profile_database.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE user_profiles(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fullName TEXT,
            email TEXT,
            phoneNumber TEXT,
            bio TEXT,
            gender TEXT,
            club TEXT,
            varsity TEXT,
            profileImagePath TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> insertUserProfile(Map<String, dynamic> user) async {
    await _database.insert('user_profiles', user, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    final List<Map<String, dynamic>> maps = await _database.query('user_profiles');

    if (maps.isNotEmpty) {
      return maps.first;
    }

    return {};
  }
}