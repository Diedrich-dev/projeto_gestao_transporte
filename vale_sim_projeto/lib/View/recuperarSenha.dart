import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/Service/transporteService.dart';
import 'package:vale_sim_projeto/Model/usuario.dart';
import 'package:vale_sim_projeto/Service/usuarioService.dart';
import 'package:vale_sim_projeto/View/buscar.dart';
import 'package:vale_sim_projeto/View/recursos/barraSuperior.dart';
import 'package:vale_sim_projeto/View/recursos/barraSuperiorLogin.dart';
import 'package:vale_sim_projeto/View/recursos/menu.dart';

import '../Model/transporte.dart';

class RecuperarSenha extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RecuperarSenhaState();
}

class RecuperarSenhaState extends State<RecuperarSenha> {
  //Controladores dos campos de inputs

  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new BarraSuperiorLogin(),
      body: new SingleChildScrollView(
        //formulario
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
          margin: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 35,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.indigo.shade900,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //titulo
              new Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Recuperar senha",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:  Color.fromARGB(255, 220, 183, 0),
                    fontSize: 24,
                  ),
                ),
              ),

              //inputs
              campoInput("email", email),

              SizedBox(height: 15,),

              //botões

              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Botão cadastrar
                  new Builder(
                    builder: (BuildContext context) {
                      return ElevatedButton(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                          child: Text(
                            "Recuperar",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        style: ElevatedButton.styleFrom(
                          primary:  Color.fromARGB(255, 220, 183, 0),
                        ),

                        onPressed: (){
                          //recuperar
                        },
                        );
                    }),

                  //botão limpar
                  new Builder(
                    builder: (BuildContext context) {
                      return ElevatedButton(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                          child: Text(
                            "Limpar",
                            style: TextStyle(
                              fontSize: 18,
                              color:  Color.fromARGB(255, 220, 183, 0),
                            ),
                          ),
                        ),

                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),

                        onPressed: (){
                          limpar();
                        },
                        );
                    }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  //retorna estrutura
  Container campoInput(
      String nomeCampo, TextEditingController textEditingController) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextField(
        //controller
        controller: textEditingController,
        decoration: InputDecoration(
          labelText: nomeCampo,
          labelStyle: TextStyle(
            color:  Color.fromARGB(255, 220, 183, 0),
            fontSize: 18,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color:  Color.fromARGB(255, 220, 183, 0),
          )),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color:  Color.fromARGB(255, 220, 183, 0)))
        ),
      ),
    );
  }
    //recurar

  //limpar campos
  void limpar(){
    this.email.text = "";
  }
}
