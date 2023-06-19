import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/Model/transporte.dart';
import 'package:vale_sim_projeto/Model/usuario.dart';
import 'package:vale_sim_projeto/Service/transporteService.dart';
import 'package:vale_sim_projeto/Service/usuarioService.dart';
import 'package:vale_sim_projeto/View/recursos/barraSuperior.dart';
import 'package:vale_sim_projeto/View/recursos/menu.dart';

class PerfilUsuario extends StatefulWidget {
  final String email;

  const PerfilUsuario({Key? key, required this.email}) : super(key: key);

  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  late Future<Usuario> usuario;

  @override
  void initState() {
    super.initState();
    usuario = UsuarioService().getUsuarioLogado(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarraSuperior(),
      drawer: MenuDrawer(email: widget.email),
      body: FutureBuilder<Usuario>(
        future: usuario,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ocorreu um erro ao carregar o usuário'));
          } else {
            Usuario usuario = snapshot.data!;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 80,
                        width: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          // child: Image.asset("img/foto.jpg", ),
                        ),
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
                        usuario.nome as String,
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
                        usuario.sobrenome as String,
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
                            Icons.phone,
                            color: Color.fromARGB(255, 220, 183, 0),
                            size: 28,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Ligar",
                            style: TextStyle(
                              color: Colors.indigo.shade900,
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
