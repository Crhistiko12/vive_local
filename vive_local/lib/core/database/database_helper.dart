import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../../features/places/domain/lugar_foto.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();

  DatabaseHelper._internal();

  factory DatabaseHelper({Database? database}) {
    if (database != null) {
      return DatabaseHelper._withDatabase(database);
    }
    return instance;
  }

  DatabaseHelper._withDatabase(this._database);

  static const String tableName = 'lugar_fotos';
  static const String databaseName = 'vive_local_fotos.db';
  static const int databaseVersion = 1;

  Database? _database;

  static const Map<String, List<String>> defaultTouristPhotos = {
    'plaza-14-de-septiembre': [
      'https://upload.wikimedia.org/wikipedia/commons/8/8e/Catedral_metropolitana_de_Cochabamba_03.jpg',
    ],
    'cristo-de-la-concordia': [
      'https://upload.wikimedia.org/wikipedia/commons/5/54/Cristo_de_la_Concordia_02.jpg',
    ],
    'aeropuerto-jorge-wilstermann': [
      'https://upload.wikimedia.org/wikipedia/commons/5/59/Jorge_Wilstermann_Airport_at_dusk.jpg',
    ],
    'terminal-de-buses-cochabamba': [
      'https://upload.wikimedia.org/wikipedia/commons/d/de/Cocha_Noche.jpg',
    ],
    'palacio-portales': [
      'https://upload.wikimedia.org/wikipedia/commons/9/92/Palacio_portales_perspectiva_exterior.jpg',
    ],
    'teleferico-al-cristo': [
      'https://upload.wikimedia.org/wikipedia/commons/1/1d/Cala_Cala%2C_Cochabamba_2.jpg',
    ],
  };

  Future<Database> get database async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = p.join(databasesPath, databaseName);

    return openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        lugar_id TEXT NOT NULL,
        image_path TEXT NOT NULL,
        es_local INTEGER DEFAULT 1
      )
    ''');

    await _seedDefaultPhotosOnDb(db);
  }

  Future<void> _seedDefaultPhotosOnDb(Database db) async {
    for (final entry in defaultTouristPhotos.entries) {
      for (final url in entry.value) {
        await db.insert(
          tableName,
          {
            'lugar_id': entry.key,
            'image_path': url,
            'es_local': 0,
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
    }
  }

  Future<void> seedDefaultPhotos() async {
    final db = await database;
    for (final entry in defaultTouristPhotos.entries) {
      for (final url in entry.value) {
        final existing = await db.query(
          tableName,
          where: 'lugar_id = ? AND image_path = ?',
          whereArgs: [entry.key, url],
          limit: 1,
        );
        if (existing.isEmpty) {
          await db.insert(
            tableName,
            {
              'lugar_id': entry.key,
              'image_path': url,
              'es_local': 0,
            },
          );
        }
      }
    }
  }

  Future<int> insertFoto(LugarFoto foto) async {
    final db = await database;
    return db.insert(tableName, foto.toMap());
  }

  Future<List<LugarFoto>> getFotosByLugarId(String lugarId) async {
    final db = await database;
    final rows = await db.query(
      tableName,
      where: 'lugar_id = ?',
      whereArgs: [lugarId],
      orderBy: 'id ASC',
    );
    return rows.map(LugarFoto.fromMap).toList();
  }

  Future<int> deleteFoto(int id) async {
    final db = await database;
    return db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
    }
  }
}
