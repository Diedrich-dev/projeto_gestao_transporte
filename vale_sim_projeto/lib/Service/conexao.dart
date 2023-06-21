import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'data_components.dart';

class Conexao {
  //construtor de acesso privado
  Conexao._();

  //criar uma instancia de conexão
  static final Conexao instance = Conexao._();  

  //instancia do SQLite
  static Database? _database;

  get getConexaoDB async {
    // Obter o caminho do banco de dados
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, DATABASE_VALESIM);

    // Apagar o banco de dados, se existir
    await deleteDatabase(path);

    // Inicializar o banco de dados
    if (_database != null) return _database;
    return await _initDatabase();
  }

  _initDatabase() async{
    return await openDatabase(
      join(await getDatabasesPath(), DATABASE_VALESIM),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
        await db.execute(CREATE_USUARIO_TABLE_SCRIPT);
        await db.execute(CREATE_TRANSPORTE_TABLE_SCRIPT);
        await db.execute(CREATE_FAVORITO_TABLE_SCRIPT);

        await db.rawInsert('''insert into $USUARIO_TABLE_NAME(
          $USUARIO_COLUMN_NOME,
          $USUARIO_COLUMN_SOBRENOME,
          $USUARIO_COLUMN_SENHA,
          $USUARIO_COLUMN_EMAIL)
          values ('admin', 'admin', 'admin', 'admin')'''
        );
  }

}