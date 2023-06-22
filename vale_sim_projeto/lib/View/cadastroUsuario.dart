import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/Service/usuarioService.dart';
import 'package:vale_sim_projeto/View/recursos/barraSuperior.dart';
import 'package:vale_sim_projeto/View/recursos/menu.dart';

import '../Model/usuario.dart';

class CadastroUsuario extends StatefulWidget {
  final String email;
  const CadastroUsuario({Key? key, required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new CadastroUsuarioState();
}

class CadastroUsuarioState extends State<CadastroUsuario> {
  // Controladores dos campos de inputs
  TextEditingController nomeController = TextEditingController();
  TextEditingController sobrenomeController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.indigo.shade900,
        title: Text('Cadastro Inicial', style: TextStyle(color: Color.fromARGB(255, 220, 183, 0),),),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.indigo.shade900,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Cadastro de usuário",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 220, 183, 0),
                    fontSize: 24,
                  ),
                ),
              ),

              // Inputs
              campoInput("Nome", nomeController),
              campoInput("Sobrenome", sobrenomeController),
              campoInput("Senha", senhaController),
              campoInput("Email", emailController),

              SizedBox(height: 15),

              // Botões
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 220, 183, 0),
                    ),
                    onPressed: () {
                      cadastrar();
                    },
                  ),

                  ElevatedButton(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        "Limpar",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 220, 183, 0),
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      limpar();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Retorna campo de input
  Container campoInput(String nomeCampo, TextEditingController textEditingController) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextField(
        style: TextStyle(
          color: Color.fromARGB(255, 220, 183, 0),
        ),
        controller: textEditingController,
        decoration: InputDecoration(
          labelText: nomeCampo,
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 220, 183, 0),
            fontSize: 18,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 220, 183, 0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 220, 183, 0)),
          ),
        ),
      ),
    );
  }

  // Função para cadastrar usuário
  void cadastrar() async {
    UsuarioService usuarioService = UsuarioService();
    Usuario usuario = Usuario(
      nome: nomeController.text,
      sobrenome: sobrenomeController.text,
      senha: senhaController.text,
      email: emailController.text,
    );

    bool sucesso = await usuarioService.create(usuario);

    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Usuário cadastrado com sucesso!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 220, 183, 0),
            ),
          ),
          duration: Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.indigo.shade900,
        ),
      );

      Future.delayed(Duration(milliseconds: 2500), () {
        Navigator.pop(context);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Problemas ao cadastrar o usuário!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 220, 183, 0),
            ),
          ),
          duration: Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.indigo.shade900,
        ),
      );
    }
  }

  // Função para limpar campos
  void limpar() {
    nomeController.text = "";
    sobrenomeController.text = "";
    senhaController.text = "";
    emailController.text = "";
  }
}
