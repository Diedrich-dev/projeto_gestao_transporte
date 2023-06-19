import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/Service/usuarioService.dart';
import 'package:vale_sim_projeto/View/cadastroUsuario.dart';
import 'package:vale_sim_projeto/View/home.dart';
import 'package:vale_sim_projeto/View/recuperarSenha.dart';

class Login extends StatefulWidget {
  
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String pass = '';

  void setEmail(String value) {
    setState(() {
      email = value;
    });
  }

  void setPass(String value) {
    setState(() {
      pass = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Tela de Login',
              style: TextStyle(
                color: Color.fromARGB(255, 220, 183, 0),
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Digite os dados',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: TextField(
              //controller
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
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
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 220, 183, 0),
                  ),
                ),
              ),
              onChanged: setEmail, // Usando o método setEmail
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: TextField(
              //controller
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
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
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 220, 183, 0),
                  ),
                ),
              ),
              onChanged: setPass, // Usando o método setPass
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecuperarSenha()),
              );
            },
            child: const Text(
              'Esqueci a senha',
              style: TextStyle(
                color: Color.fromARGB(255, 220, 183, 0),
              ),
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                if (await UsuarioService().getUsuarioLogin(email, pass)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Home(
                        email: email,
                      );
                    }),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    new SnackBar(
                      content: Text(
                        'Usuário não existente',
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
              },
            ),
          ),
          Row(
            children: <Widget>[
              const Text('Não possui conta?'),
              TextButton(
                child: const Text(
                  'Cadastre aqui',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 220, 183, 0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroUsuario(email: email,)),
                  );
                },
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
