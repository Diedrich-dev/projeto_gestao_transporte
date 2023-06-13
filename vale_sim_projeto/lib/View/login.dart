import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/View/cadastroUsuario.dart';
import 'package:vale_sim_projeto/View/home.dart';
import 'package:vale_sim_projeto/View/recuperarSenha.dart';

class Login extends StatelessWidget {
  String email = '';
  String pass = '';
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
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text('Digite os dados',
                    style: TextStyle(
                      fontSize: 20,
                    ))),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextField(
                //controller
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 220, 183, 0),
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 220, 183, 0),
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 220, 183, 0)))),
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
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 220, 183, 0)))),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RecuperarSenha()));
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
                  style:
                      ElevatedButton.styleFrom(primary: Colors.indigo.shade900),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Color.fromARGB(255, 220, 183, 0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Home();
                    }));
                  },
                )),
            // ignore: sort_child_properties_last
            Row(children: <Widget>[
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
                      MaterialPageRoute(
                          builder: (context) => CadastroUsuario()),
                    );
                  })
            ], mainAxisAlignment: MainAxisAlignment.center),
          ],
        ));
  }
}
