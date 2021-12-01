import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

// id nome email senha

final String usuarioTabela = "usuarioTabela";
final String idUsuario = "idUsuario";
final String nomeUsuario = "nomeUsuario";
final String emailUsuario = "emailUsuario";
final String senhaUsuario = "senhaUsuario";

class UsuarioHelper {
  static final UsuarioHelper _instance = UsuarioHelper.internal();

  factory UsuarioHelper() => _instance;

  UsuarioHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();

    final path = join(databasesPath, "usuarios.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $usuarioTabela($idUsuario INTEGER PRIMARY KEY, $nomeUsuario TEXT, $emailUsuario TEXT, $senhaUsuario PASSWORD");
    });
  }

  Future<Usuario> salvarUsuario(Usuario usuario) async {
    Database dbUsuario = await db;

    usuario.id = await dbUsuario.insert(usuarioTabela, usuario.toMap());
    return usuario;
  }

  Future<Usuario> buscarUsuario(int id) async {
    Database dbUsuario = await db;

    List<Map> maps = await dbUsuario.query(usuarioTabela,
        columns: [idUsuario, nomeUsuario, emailUsuario],
        where: "$idUsuario = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Usuario.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deletarUsuario(int id) async {
    Database dbUsuario = await db;

    return await dbUsuario
        .delete(usuarioTabela, where: "$idUsuario=?", whereArgs: [id]);
  }

  Future<int> atualizarUsuario(Usuario usuario) async {}

  Future<List> todosOsUsuario() async {
    Database dbUsuario = await db;
    List listMap = await dbUsuario.rawQuery("SELECT * FROM $usuarioTabela");
    List<Usuario> listaUsuario = List();

    for (Map m in listMap) {
      listaUsuario.add(Usuario.fromMap(m));
    }

    return listaUsuario;
  }

  Future<int> getTotal() async {
    Database dbUsuario = await db;
    return Sqflite.firstIntValue(
        await dbUsuario.rawQuery("SELECT COUNT(*) FROM $usuarioTabela"));
  }

  Future close() async {
    Database dbUsuario = await db;
    dbUsuario.close();
  }
}

class Usuario {
  int id;
  String nome;
  String email;
  String senha;

  Usuario.fromMap(Map map) {
    id = map[idUsuario];
    nome = map[nomeUsuario];
    email = map[emailUsuario];
    senha = map[senhaUsuario];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nomeUsuario: nome,
      emailUsuario: email,
      senhaUsuario: senha,
    };

    if (id != null) {
      map[idUsuario] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Usuario (id: $id, nome: $nome, email: $email, senha: $senha)";
  }
}
