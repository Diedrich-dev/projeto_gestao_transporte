import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'data_components.dart';

class Conexao {
  static Database? _database;

  static Future<Database> getConexaoDB() async {
    if (_database == null) {
      String databasePath = 
      join(await getDatabasesPath(), DATABASE_VALESIM);

      _database = await openDatabase(databasePath, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(CREATE_USUARIO_TABLE_SCRIPT);
        await db.rawInsert('''insert into $USUARIO_TABLE_NAME(
          $USUARIO_COLUMN_NOME,
          $USUARIO_COLUMN_SOBRENOME,
          $USUARIO_COLUMN_SENHA,
          $USUARIO_COLUMN_EMAIL)
          values ('admin', 'admin', 'admin', 'admin')'''
        );

        await db.execute(CREATE_TRANSPORTE_TABLE_SCRIPT);
      });
    }
    return _database!;
  }
}