import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/Model/transporte.dart';
import 'package:vale_sim_projeto/Service/favoritoService.dart';
import 'package:vale_sim_projeto/Service/transporteService.dart';
import 'package:vale_sim_projeto/View/recursos/barraSuperior.dart';
import 'package:vale_sim_projeto/View/recursos/menu.dart';

import '../Model/usuario.dart';

class PerfilTransporte extends StatefulWidget {
  final Usuario usuario;
  final Transporte transporte;

  const PerfilTransporte({Key? key, required this.usuario, required this.transporte}) : super(key: key);

  @override
  _PerfilTransporteState createState() => _PerfilTransporteState();
}

class _PerfilTransporteState extends State<PerfilTransporte> {
  bool _isFavorito = false; // Variável de estado para indicar se o transporte é favorito ou não

  @override
  void initState() {
    super.initState();
    // Verificar se o transporte é favorito ao inicializar a tela
    _verificarFavorito();
  }

  void _verificarFavorito() async {
    // Verificar se o transporte é favorito e atualizar o estado
    bool isFavorito = await FavoritoService().verificarFavorito(widget.usuario.id as int, widget.transporte.id as int);
    setState(() {
      _isFavorito = isFavorito;
    });
  }

  void _alternarFavorito() async {
    setState(() {
      _isFavorito = !_isFavorito;
    });

    // Adicionar ou remover o transporte dos favoritos
    if (_isFavorito) {
      await FavoritoService().adicionarFavorito(widget.usuario, widget.transporte);
    } else {
      await FavoritoService().removerFavorito(widget.usuario.id as int, widget.transporte.id as int);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarraSuperior(),
      drawer: MenuDrawer(email: widget.usuario.email as String),
      body: FutureBuilder<Transporte>(
        future: TransporteService().pesquisarTransportePorId(widget.usuario.id as int),
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
                          IconButton(
                            icon: Icon(
                              _isFavorito ? Icons.favorite : Icons.favorite_border,
                              color: _isFavorito ? Colors.red : Colors.grey,
                            ),
                            onPressed: _alternarFavorito,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _isFavorito ? 'Favorito' : 'Não Favorito',
                            style: TextStyle(
                              color: _isFavorito ? Colors.red : Colors.grey,
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
