import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  // Singleton para garantir uma única instância do banco
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicialização do banco de dados
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'manducabank.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Criação da tabela de transferências
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transferencias (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        valor REAL,
        destinatario TEXT,
        data TEXT
      )
    ''');
  }

  // Método para inserir uma transferência
  Future<int> insertTransferencia(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('transferencias', row);
  }

  // Método para buscar todas as transferências
  Future<List<Map<String, dynamic>>> getTransferencias() async {
    Database db = await database;
    return await db.query('transferencias', orderBy: 'id DESC');
  }
}
