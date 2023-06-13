// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/Model/transporte.dart';
import 'package:vale_sim_projeto/Service/transporteService.dart';
import 'package:vale_sim_projeto/View/recursos/barraSuperior.dart';
import 'package:vale_sim_projeto/View/recursos/menu.dart';

class Perfil extends StatelessWidget {
  //Guarda o id do tranposrte selecionado
  int id = 0;
  //construir transporte
  Perfil({
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new BarraSuperior(),

      drawer: new MenuDrawer(),

      body: FutureBuilder<Transporte>(
        future: TransporteService().pesquisarTransportePorId(id),
        builder: (BuildContext context, AsyncSnapshot<Transporte> transporte) {
          if (transporte.hasData) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  //Número de transporte
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.directions_bus,
                        size: 60,
                        color: Color.fromARGB(255, 220, 183, 0),
                      )
                    ],
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  //Nome
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        transporte.data?.nome as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          letterSpacing: 3,
                          wordSpacing: 3,
                        ),
                      ),
                    ],
                  ),

                  //Linha
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        transporte.data?.linha as String,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    child: Divider(
                      height: 5,
                    ),
                  ),

                  //Ações
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //HOrarios
                      Column(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: Color.fromARGB(255, 220, 183, 0),
                            size: 28,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Horários",
                            style: TextStyle(
                              color: Color.fromARGB(255, 220, 183, 0),
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (transporte.hasError) {
            // Se ocorrer um erro durante o carregamento do transporte, exiba uma mensagem de erro
            return Center(
              child: Text('Erro ao carregar o transporte.'),
            );
          } else {
            // Caso contrário, exiba um widget de carregamento ou qualquer outro conteúdo padrão
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      //Editar
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create_outlined),
        onPressed: () {},
      ),
    );
  }
}
