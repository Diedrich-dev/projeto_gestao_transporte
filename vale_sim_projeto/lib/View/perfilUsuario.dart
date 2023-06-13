import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/Model/transporte.dart';
import 'package:vale_sim_projeto/Service/transporteService.dart';
import 'package:vale_sim_projeto/View/recursos/barraSuperior.dart';
import 'package:vale_sim_projeto/View/recursos/menu.dart';

class PerfilUsuario extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: new BarraSuperior(),
      
      drawer: new MenuDrawer(),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 80,
                  width: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset("img/foto.jpg", ),
                  ),
                ),
                  // new Icon(
                  //   Icons.directions_bus,
                  //   size: 60,
                  //   color: Color.fromARGB(255, 220, 183, 0),
                  // )
              ],
            ),

            SizedBox(height: 25,),

            //Nome
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                new Text(
                  "Pedro Henrique",
                  style: TextStyle(
                    fontWeight:  FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 3,
                    wordSpacing: 3,
                  ),
                ),
              ],
            ),

            //sobrenome
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Text(
                  "Diedrich",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            new Container(
              padding: EdgeInsets.only(top: 25, bottom: 25),
              child: Divider(height: 5,),
            ),

            //Ações
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Ligar
                new Column(
                  children: [
                    new Icon(Icons.phone,
                    color:  Color.fromARGB(255, 220, 183, 0),
                    size: 28,),

                    SizedBox(height: 10,),

                    new Text("Ligar",
                    style: TextStyle(
                      color:  Colors.indigo.shade900,
                      fontSize: 18,
                    ),)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),

      //Editar
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create_outlined),
        onPressed: (){

        },
      ),
    );
  }

}