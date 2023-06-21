import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/Service/transporteService.dart';
import 'package:vale_sim_projeto/View/buscar.dart';
import 'package:vale_sim_projeto/View/recursos/barraSuperior.dart';
import 'package:vale_sim_projeto/View/recursos/menu.dart';

import '../Model/transporte.dart';

class CadastroTransporte extends StatefulWidget {
  final String email;
  const CadastroTransporte({Key? key, required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new CadastroTransporteState();
}

class CadastroTransporteState extends State<CadastroTransporte> {
  //Controladores dos campos de inputs
  TextEditingController nomeController = new TextEditingController();
  TextEditingController placaController = new TextEditingController();
  TextEditingController linhaController = new TextEditingController();
  TextEditingController capacidadeController = new TextEditingController();
  TextEditingController numeroController = new TextEditingController();
  TextEditingController renavamController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new BarraSuperior(),
      drawer: new MenuDrawer(email: widget.email,),
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
                    color: Color.fromARGB(255, 220, 183, 0),
                    fontSize: 24,
                  ),
                ),
              ),

              //inputs

              campoInput("motorista", nomeController),
              campoInput("número", numeroController),
              campoInput("linha", linhaController),
              campoInput("placa", placaController),
              campoInput("renavam", renavamController),

              SizedBox(
                height: 15,
              ),
              //botões
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Botão cadastrar
                  Builder(builder: (BuildContext context) {
                    return ElevatedButton(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    );
                  }),

                  //botão limpar
                  new Builder(builder: (BuildContext context) {
                    return ElevatedButton(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          color: Color.fromARGB(255, 220, 183, 0),
        ),
        //controller
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
            )),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 220, 183, 0)))),
      ),
    );
  }

  //cadastrar
void cadastrar() async {
  TransporteService transporteService = TransporteService();
  Transporte transporte = Transporte();
  transporte.nome = nomeController.text;
  transporte.numero = numeroController.text;
  transporte.linha = linhaController.text;
  transporte.capacidade = capacidadeController.text;
  transporte.placa = placaController.text;
  transporte.renavam = renavamController.text;

  bool sucesso = await transporteService.create(transporte);

  if (sucesso) {
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: Text(
          'Transporte salvo com sucesso!',
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Buscar(email: widget.email,)),
      );
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: Text(
          'Problemas ao salvar o transporte!',
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


  //limpar campos
  void limpar() {
    nomeController.text = "";
    numeroController.text = "";
    renavamController.text = "";
    placaController.text = "";
    linhaController.text = "";
    capacidadeController.text = "";
  }
}
