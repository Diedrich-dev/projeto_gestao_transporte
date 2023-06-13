import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/View/login.dart';
import '../View/recursos/estilo.dart';

void main() => runApp(new MaterialApp(
      title: "Transporte",
      home: Scaffold(
        body: new Login(),
        ),
      debugShowCheckedModeBanner: false,
      theme: estilo(),
    ));
