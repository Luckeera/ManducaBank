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
    try {
      _database = await _initDatabase();
      return _database!;
    } catch (e) {
      print("ERRO CRÍTICO NO BANCO: $e");
      rethrow;
    }
  }

  // Inicialização do banco de dados
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'manducabank_vfinal.db'); // Nome alterado para resetar
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Criação das tabelas
  Future<void> _onCreate(Database db, int version) async {
    print("CRIANDO BANCO DE DADOS PELA PRIMEIRA VEZ...");
    await db.execute('''
      CREATE TABLE transferencias (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        valor REAL,
        destinatario TEXT,
        data TEXT,
        tipo TEXT
      )
    ''');
    await db.execute('CREATE TABLE usuario (id INTEGER PRIMARY KEY, saldo REAL)');
    await db.insert('usuario', {'id': 1, 'saldo': 1000.00});
  }

  // Métodos de Saldo com Fallback para teste em ambiente Windows sem FFI
  static double _saldoMemoria = 1000.00; 

  Future<double> getSaldo() async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> res = await db.query('usuario', where: 'id = 1');
      if (res.isNotEmpty) {
        return res.first['saldo'] as double;
      }
      await db.insert('usuario', {'id': 1, 'saldo': 1000.00});
      return 1000.00;
    } catch (e) {
      print("USANDO SALDO DE MEMÓRIA (ERRO NO BANCO): $e");
      return _saldoMemoria;
    }
  }

  Future<void> updateSaldo(double novoSaldo) async {
    try {
      Database db = await database;
      await db.update('usuario', {'saldo': novoSaldo}, where: 'id = 1');
      _saldoMemoria = novoSaldo;
    } catch (e) {
      _saldoMemoria = novoSaldo;
      print("SALDO ATUALIZADO EM MEMÓRIA: $_saldoMemoria");
    }
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

  // Método para deletar uma transferência específica
  Future<int> deleteTransferencia(int id) async {
    Database db = await database;
    return await db.delete('transferencias', where: 'id = ?', whereArgs: [id]);
  }

  // Método para limpar todo o histórico
  Future<int> clearHistorico() async {
    Database db = await database;
    return await db.delete('transferencias');
  }
}
