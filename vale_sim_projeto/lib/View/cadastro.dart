import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/Service/transporteService.dart';
import 'package:vale_sim_projeto/View/buscar.dart';
import 'package:vale_sim_projeto/View/recursos/barraSuperior.dart';
import 'package:vale_sim_projeto/View/recursos/menu.dart';

import '../Model/transporte.dart';

class Cadastro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CadastroState();
}

class CadastroState extends State<Cadastro> {
  //Controladores dos campos de inputs

  Transporte transporte = new Transporte();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new BarraSuperior(),
      drawer: new MenuDrawer(),
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
                  "Cadastro de transporte",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:  Color.fromARGB(255, 220, 183, 0),
                    fontSize: 24,
                  ),
                ),
              ),

              //inputs

              campoInput("nome", transporte.nome as TextEditingController),
              campoInput("número", transporte.numero as TextEditingController),
              campoInput("linha", transporte.linha as TextEditingController),
              campoInput("placa", transporte.placa as TextEditingController),
              campoInput("renavam", transporte.renavam as TextEditingController),

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
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),

                          child: Text(
                            "Cadastrar",
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
                          cadastrar();
                        },
                        );
                    }),

                  //botão limpar
                  new Builder(
                    builder: (BuildContext context) {
                      return ElevatedButton(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),

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
        style: TextStyle(
          color:  Color.fromARGB(255, 220, 183, 0),
        ),
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
  //cadastrar
  void cadastrar(){
    TransporteService transporteService = TransporteService();

    transporteService.create(transporte);
    //mostra a mensagem com SnackBar (desaparece)
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: Text('mensagem',
        textAlign: TextAlign.center,
        style: TextStyle(
          color:  Color.fromARGB(255, 220, 183, 0),
        ),),
        duration: Duration(
          milliseconds: 2000,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.indigo.shade900,),
    );

    //redirecionar para a tela de busca

    Future.delayed(
      Duration(milliseconds: 2500),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Buscar())
        );
      }
    );
  }

  //limpar campos
  void limpar(){
    this.transporte.nome = "";
    this.transporte.numero = "";
    this.transporte.renavam = "";
    this.transporte.placa = "";
    this.transporte.linha = "";
  }
}
