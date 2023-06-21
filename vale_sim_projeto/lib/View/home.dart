import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/View/buscar.dart';
import 'package:vale_sim_projeto/View/cadastroTransporte.dart';
import 'package:vale_sim_projeto/View/recursos/barraSuperior.dart';
import 'package:vale_sim_projeto/View/recursos/menu.dart';

class Home extends StatefulWidget {
  final String email;
    const Home({Key? key, required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Titulo
      appBar: BarraSuperior(),

      // Menu Lateral
      drawer: MenuDrawer(email: widget.email),

      //Corpo
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  //Botão buscar transportes
                  Builder(builder: (BuildContext context) {
                    return ElevatedButton(
                        child: Container(
                            width: 300,
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                new Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                new Text(
                                  "Buscar Transportes",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                              ],
                            )),
                        style: ElevatedButton.styleFrom(primary:  Color.fromARGB(255, 220, 183, 0)),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Buscar(email: widget.email)));
                        });
                  }),

                  SizedBox(
                    height: 15,
                  ),

                  //Botão casdastrar transportes
                  new Builder(builder: (BuildContext context) {
                    return ElevatedButton(
                        child: Container(
                            width: 300,
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                new Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                new Text(
                                  "Cadastrar Transportes",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                              ],
                            )),
                        style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 220, 183, 0) ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => new CadastroTransporte(email: widget.email,)));
                        });
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
