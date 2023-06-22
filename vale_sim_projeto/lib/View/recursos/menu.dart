import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/Model/usuario.dart';
import 'package:vale_sim_projeto/Service/usuarioService.dart';
import 'package:vale_sim_projeto/View/PerfilUsuario.dart';
import 'package:vale_sim_projeto/View/cadastroTransporte.dart';
import 'package:vale_sim_projeto/View/login.dart';
import '../buscar.dart';
import '../home.dart';

class MenuDrawer extends StatefulWidget {
  final String email;
  const MenuDrawer({Key? key, required this.email}) : super(key: key);

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {

  Text mostrarTitulo(String titulo) {
    return Text(
      titulo,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  Icon formatarIconDrawer(IconData icon) {
    return Icon(
      icon,
      color: Color.fromARGB(255, 220, 183, 0),
      size: 32,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<Usuario>(
        future: UsuarioService().getUsuarioLogado(widget.email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ocorreu um erro ao carregar o usuário'));
          } else {
            Usuario usuario = snapshot.data!;

            return ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade900,
                  ),
                  accountName: Text(usuario.nome!),
                  accountEmail: Text(usuario.email!),
                  currentAccountPicture: CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      // child: Image.asset(fotoPerfil),
                    ),
                  ),
                ),

                ListTile(
                  title: mostrarTitulo("Principal"),
                  subtitle: Text("Página inicial"),
                  trailing: Icon(Icons.arrow_right),
                  leading: formatarIconDrawer(Icons.home),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home(email: widget.email)),
                    );
                  },
                ),

                ListTile(
                  title: mostrarTitulo("Perfil"),
                  subtitle: Text("Editar informações"),
                  trailing: Icon(Icons.arrow_right),
                  leading: formatarIconDrawer(Icons.people),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PerfilUsuario(email: widget.email)),
                    );
                  },
                ),

                ListTile(
                  title: mostrarTitulo("Transportes"),
                  subtitle: Text("Lista de transportes cadastrados"),
                  trailing: Icon(Icons.arrow_right),
                  leading: formatarIconDrawer(Icons.directions_bus),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Buscar(email: widget.email)),
                    );
                  },
                ),

                ListTile(
                  title: mostrarTitulo("Cadastrar Transporte"),
                  subtitle: Text("Cadastro de transportes"),
                  trailing: Icon(Icons.arrow_right),
                  leading: formatarIconDrawer(Icons.construction),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CadastroTransporte(email: widget.email)),
                    );
                  },
                ),

                ListTile(
                  title: mostrarTitulo("Sair"),
                  subtitle: Text("Sair do sistema"),
                  trailing: Icon(Icons.arrow_right),
                  leading: formatarIconDrawer(Icons.exit_to_app),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Scaffold(body: Login())),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
