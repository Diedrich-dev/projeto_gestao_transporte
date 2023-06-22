import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/Model/usuario.dart';
import 'package:vale_sim_projeto/Service/transporteService.dart';
import 'package:vale_sim_projeto/View/perfilTransporte.dart';
import 'package:vale_sim_projeto/View/recursos/barraSuperior.dart';
import 'package:vale_sim_projeto/View/recursos/menu.dart';

import '../Model/transporte.dart';
import '../Service/usuarioService.dart';
import 'cadastroTransporte.dart';

class Buscar extends StatefulWidget {
  final String email;
  const Buscar({Key? key, required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new BuscarState();
}

class BuscarState extends State<Buscar> {
  late Usuario usuario;

  @override
  void initState() {
    super.initState();
    carregarUsuario().then((loadedUsuario) {
      setState(() {
        usuario = loadedUsuario;
      });
    });
  }

  Future<Usuario> carregarUsuario() async {
    return await UsuarioService().getUsuarioLogado(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarraSuperior(),
      drawer: MenuDrawer(email: widget.email),
      body: FutureBuilder<List<Transporte>>(
        future: TransporteService().getAllTransporte(),
        builder: (BuildContext context, AsyncSnapshot<List<Transporte>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ocorreu um erro ao carregar os dados'));
          } else if (!snapshot.hasData || snapshot.data?.isEmpty == true) {
            return Center(child: Text('Nenhum transporte encontrado'));
          } else {
            return ListView.builder(
              key: UniqueKey(),
              padding: EdgeInsets.fromLTRB(8, 8, 8, 75),
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                Transporte transporte = snapshot.data![index];
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      snapshot.data!.removeAt(index);
                    });
                    TransporteService().deleteTransportes(transporte);
                  },
                  background: Container(
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo.shade900,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 5,
                    ),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            // child: Image.asset(
                            //   // 'url imagem', // Substitua 'url imagem' pela URL real da imagem
                            //   width: 60,
                            //   height: 60,
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          Column(
                            children: [
                              Text(
                                'Motorista: ${transporte.nome as String}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 220, 183, 0),
                                  fontSize: 24,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'linha: ${transporte.linha as String}',
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
                              builder: (context) => PerfilTransporte(usuario: usuario, transporte: transporte),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroTransporte(email: widget.email)),
          );
        },
      ),
    );
  }
}
