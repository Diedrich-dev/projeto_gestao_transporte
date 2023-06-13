import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/View/PerfilUsuario.dart';
import 'package:vale_sim_projeto/View/cadastro.dart';
import 'package:vale_sim_projeto/View/login.dart';

import '../buscar.dart';
import '../home.dart';

class MenuDrawer extends StatelessWidget {
  //Dados do banco de dados simulados
  String usuario = "Pedro";
  String email = "pedrodiedrich123@gmail.com";
  String fotoPerfil = "img/foto.jpg";

  Text mostrarTitulo (String titulo){
    return Text(
      titulo,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  Icon formatarIconDrawer (IconData icon){
    return Icon(
      icon,
      color: Color.fromARGB(255, 220, 183, 0),
      size: 32,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          new UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo.shade900,
            ),
            accountName: Text(usuario),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(fotoPerfil),
              ) 
            ),
          ),

          //home 
          new ListTile(
            title: mostrarTitulo("Principal"),
            subtitle: Text("Página inicial"),
            trailing: Icon(Icons.arrow_right),
            leading: formatarIconDrawer(Icons.home),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home())
                );
            },
          ),

          //Perfil 
          new ListTile(
            title: mostrarTitulo("Perfil"),
            subtitle: Text("Editar informações"),
            trailing: Icon(Icons.arrow_right),
            leading: formatarIconDrawer(Icons.people),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PerfilUsuario())
                );
            },
          ),

          //favoritos
          new ListTile(
            title: mostrarTitulo("Favoritos"),
            subtitle: Text("Meus transportes favoritos"),
            trailing: Icon(Icons.arrow_right),
            leading: formatarIconDrawer(Icons.star),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Buscar())
              );
            }
          ),

          //mapa

          //cadastro de onibus
          new ListTile(
            title: mostrarTitulo("Cadastrar Transporte"),
            subtitle: Text("Cadastro de transportes"),
            trailing: Icon(Icons.arrow_right),
            leading: 
            formatarIconDrawer(Icons.construction),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cadastro()));
            }
          ),

        //Sair do sistema 
          new ListTile(
            title: mostrarTitulo("Sair"),
            subtitle: Text("Sair do sistema"),
            trailing: Icon(Icons.arrow_right),
            leading: 
            formatarIconDrawer(Icons.exit_to_app),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(body: Login())));
            }
          ),
        ],     
      ),
    );
  }

}