import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/Model/transporte.dart';
import 'package:vale_sim_projeto/Model/usuario.dart';
import 'package:vale_sim_projeto/Service/favoritoService.dart';
import 'package:vale_sim_projeto/Service/usuarioService.dart';
import 'package:vale_sim_projeto/View/editarUsuario.dart';
import 'package:vale_sim_projeto/View/recursos/barraSuperior.dart';
import 'package:vale_sim_projeto/View/recursos/menu.dart';

class PerfilUsuario extends StatefulWidget {
  final String email;

  const PerfilUsuario({Key? key, required this.email}) : super(key: key);

  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
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
      body: FutureBuilder<Usuario>(
        future: UsuarioService().getUsuarioLogado(widget.email),
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
                  SizedBox(height: 25),
                  Text(
                    'Transportes Favoritos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<Transporte>>(
                      future: FavoritoService().getTransportesFavoritos(usuario.id as int),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Ocorreu um erro ao carregar os transportes favoritos'));
                        } else {
                          List<Transporte> transportesFavoritos = snapshot.data!;
                          if (transportesFavoritos.isEmpty) {
                            return Center(child: Text('Nenhum transporte favorito encontrado'));
                          } else {
                            return ListView.builder(
                              itemCount: transportesFavoritos.length,
                              itemBuilder: (context, index) {
                                Transporte transporte = transportesFavoritos[index];
                                return ListTile(
                                  title: Text(transporte.nome!),
                                  subtitle: Text(transporte.linha!),
                                  trailing: IconButton(
                                    icon: Icon(
                                      transporte.favorito ? Icons.favorite : Icons.favorite_border,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        transporte.favorito = !transporte.favorito;
                                      });
                                      if (transporte.favorito) {
                                        FavoritoService().adicionarFavorito(usuario, transporte);
                                      } else {
                                        FavoritoService().removerFavorito(usuario.id as int, transporte.id as int);
                                      }
                                    },
                                  ),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create_outlined),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditarUsuario(usuario: usuario)),
          );
        },
      ),
    );
  }
}
