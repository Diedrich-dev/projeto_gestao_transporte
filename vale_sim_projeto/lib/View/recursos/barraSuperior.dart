import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/View/recursos/estilo.dart';

class BarraSuperior extends AppBar {
  BarraSuperior() : super(
    backgroundColor: Colors.indigo.shade900,
    //esconde o icon original do menu
    automaticallyImplyLeading:  false,
    centerTitle: true,
    leading: Builder(
      builder: (BuildContext context){
        return IconButton(
          color:  Color.fromARGB(255, 220, 183, 0),
          icon: Icon(Icons.apps_outlined),
          onPressed: () => Scaffold.of(context).openDrawer()
          ); 
      }),
    title: Text(
      "Meus Transportes",
      style: TextStyle(
        fontSize: 20,
        color:  Color.fromARGB(255, 220, 183, 0)),
    ),

    //Customizar Icon do menu
    // iconTheme: IconThemeData(
    //   color: Colors.orange
    // )
  );
}