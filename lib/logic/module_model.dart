import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableModules = 'modules';

class ModuleFields {
  static final List<String> values = [id, NomModule, coif, Moyenne, time];
  static final String id = '_id';
  static final String coif = 'coif';
  static final String Moyenne = 'Moyenne';
  static final String NomModule = 'NomModule';
  static final String time = 'time';
}

class Module {
  final int? id;
  final int coif;
  final double Moyenne;
  final String NomModule;
  final DateTime createdTime;

  Module({
    this.id,
    required this.NomModule,
    required this.coif,
    required this.Moyenne,
    required this.createdTime,
  });
  Map<String, Object?> toJSON() => {
        ModuleFields.id: id,
        ModuleFields.NomModule: NomModule,
        ModuleFields.coif: coif,
        ModuleFields.Moyenne: Moyenne,
        ModuleFields.time: createdTime.toIso8601String(),
      };
  Module copy({
    int? id,
    int? coif,
    double? Moyenne,
    String? NomModule,
    DateTime? createdTime,
  }) =>
      Module(
        id: id ?? this.id,
        NomModule: NomModule ?? this.NomModule,
        coif: coif ?? this.coif,
        Moyenne: Moyenne ?? this.Moyenne,
        createdTime: createdTime ?? this.createdTime,
      );
  static Module fromJson(Map<String, Object?> json) => Module(
      id: json[ModuleFields.id] as int?,
      NomModule: json[ModuleFields.NomModule] as String,
      coif: json[ModuleFields.coif] as int,
      Moyenne: json[ModuleFields.Moyenne] as double,
      createdTime: DateTime.parse(json[ModuleFields.time] as String));
}

class ModulesDatabase {
  static final ModulesDatabase instance = ModulesDatabase._init();
  static Database? _database;
  ModulesDatabase._init();
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('modules.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final doubletype = 'DOUBLE NOT NULL';
    final Stringtype = 'TEXT NOT NULL';
    final inttype = 'INTEGER NOT NULL';
    await db.execute('''CREATE TABLE $tableModules (
    ${ModuleFields.id} $idType,
    ${ModuleFields.NomModule} $Stringtype,
    ${ModuleFields.coif} $inttype,
    ${ModuleFields.Moyenne} $doubletype,
    ${ModuleFields.time} $Stringtype  
    )''');
  }

  Future<int> Update(Module module) async {
    final db = await instance.database;
    return db.update(tableModules, module.toJSON(),
        where: '${ModuleFields.id} = ?', whereArgs: [module.id]);
  }

  Future close() async {
    final db = await instance.database;
    return db.close();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db
        .delete(tableModules, where: '${ModuleFields.id} = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    final db = await instance.database;
    return await db.delete(tableModules);
  }

  Future<Module> create(Module module) async {
    final db = await instance.database;
    final id = await db.insert(tableModules, module.toJSON());
    return module.copy(id: id);
  }

  Future<List<Module>> readAllModule() async {
    final db = await instance.database;
    final orderBy = '${ModuleFields.time} ASC';
    final result = await db.query(tableModules, orderBy: orderBy);
    return result.map((json) => Module.fromJson(json)).toList();
  }

  Future<Module> readModule(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableModules,
        columns: ModuleFields.values,
        where: '${ModuleFields.id} = ? ',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Module.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }
}
