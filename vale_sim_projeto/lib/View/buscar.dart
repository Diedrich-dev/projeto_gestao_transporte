import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/Service/transporteService.dart';
import 'package:vale_sim_projeto/View/perfil.dart';
import 'package:vale_sim_projeto/View/recursos/barraSuperior.dart';
import 'package:vale_sim_projeto/View/recursos/menu.dart';

import '../Model/transporte.dart';
import 'cadastro.dart';

class Buscar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new BuscarState();
}

class BuscarState extends State<Buscar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new BarraSuperior(),

      drawer: new MenuDrawer(),

      body: FutureBuilder<List<Transporte>>(
        future: TransporteService().getAllTransporte(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Transporte>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 75),
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                Transporte transporte = snapshot.data![index];
                return Container(
                  color: Colors.indigo.shade900,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 5,
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          // child: Image.asset(
                          // url imagem,
                          // width: 60,
                          // heigth: 60,
                          // fit: boxFit.cover),
                        ),
                        Column(
                          children: [
                            Text(
                              transporte.nome as String,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 220, 183, 0),
                                  fontSize: 24),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            new Text(
                              transporte.linha as String,
                              style: TextStyle(
                                color: Color.fromARGB(255, 220, 183, 0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.arrow_right,
                        color: Color.fromARGB(255, 220, 183, 0),
                        size: 32,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Perfil(id: transporte.id as int)));
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

      //Botão flututante
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
        onPressed: () {
          //Botão adicionar
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => new Cadastro()));
        },
      ),
    );
  }
}