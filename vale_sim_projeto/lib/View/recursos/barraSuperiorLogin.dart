import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/View/recursos/estilo.dart';

class BarraSuperiorLogin extends AppBar {
  BarraSuperiorLogin() : super(
    backgroundColor: Colors.indigo.shade900,
    //esconde o icon original do menu
    automaticallyImplyLeading:  false,
    centerTitle: true,

    leading: Builder(
      builder: (BuildContext context){
        return IconButton(
          color:  Color.fromARGB(255, 220, 183, 0),
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false)
          ); 
      }),
    title: Text(
      "Login",
      style: TextStyle(
        fontSize: 20,
        color:  Color.fromARGB(255, 220, 183, 0)),
    ),
  );
}