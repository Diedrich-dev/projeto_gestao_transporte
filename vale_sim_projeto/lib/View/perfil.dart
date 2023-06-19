import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/Model/transporte.dart';
import 'package:vale_sim_projeto/Service/transporteService.dart';
import 'package:vale_sim_projeto/View/recursos/barraSuperior.dart';
import 'package:vale_sim_projeto/View/recursos/menu.dart';

class Perfil extends StatefulWidget {
  final String email;
  final int id;
  const Perfil({super.key, required this.id, required this.email});

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarraSuperior(),
      drawer: MenuDrawer(email: widget.email,),
      body: FutureBuilder<Transporte>(
        future: TransporteService().pesquisarTransportePorId(widget.id),
        builder: (BuildContext context, AsyncSnapshot<Transporte> transporte) {
          if (transporte.hasData) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.directions_bus,
                        size: 60,
                        color: Color.fromARGB(255, 220, 183, 0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (transporte.hasError) {
            return Center(
              child: Text('Erro ao carregar o transporte.'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create_outlined),
        onPressed: () {},
      ),
    );
  }
}
