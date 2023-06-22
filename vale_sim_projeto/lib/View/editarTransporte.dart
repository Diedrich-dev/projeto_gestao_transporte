import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/Model/transporte.dart';
import 'package:vale_sim_projeto/Service/transporteService.dart';

class EditarTransporte extends StatefulWidget {
  final Transporte transporte;

  EditarTransporte({required this.transporte});

  @override
  _EditarTransporteState createState() => _EditarTransporteState();
}

class _EditarTransporteState extends State<EditarTransporte> {
  late TextEditingController _nomeController;
  late TextEditingController _numeroController;
  late TextEditingController _renavamController;
  late TextEditingController _placaController;
  late TextEditingController _capacidadeController;
  late TextEditingController _linhaController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.transporte.nome);
    _numeroController = TextEditingController(text: widget.transporte.numero);
    _renavamController = TextEditingController(text: widget.transporte.renavam);
    _placaController = TextEditingController(text: widget.transporte.placa);
    _capacidadeController = TextEditingController(text: widget.transporte.capacidade);
    _linhaController = TextEditingController(text: widget.transporte.linha);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _numeroController.dispose();
    _renavamController.dispose();
    _placaController.dispose();
    _capacidadeController.dispose();
    _linhaController.dispose();
    super.dispose();
  }

  void _salvarEdicao() {
    // Atualize os valores do transporte com base nos valores dos controladores
    widget.transporte.nome = _nomeController.text;
    widget.transporte.numero = _numeroController.text;
    widget.transporte.renavam = _renavamController.text;
    widget.transporte.placa = _placaController.text;
    widget.transporte.capacidade = _capacidadeController.text;
    widget.transporte.linha = _linhaController.text;

    // Chame o método para atualizar o transporte no banco de dados
    TransporteService().atualizarTransporte(widget.transporte).then((_) {
      // Informe que a edição foi concluída e retorne o transporte atualizado
      Navigator.pop(context, widget.transporte);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: Text('Editar Transporte', style: TextStyle(color: Color.fromARGB(255, 220, 183, 0),),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _numeroController,
              decoration: InputDecoration(labelText: 'Número'),
            ),
            TextField(
              controller: _renavamController,
              decoration: InputDecoration(labelText: 'Renavam'),
            ),
            TextField(
              controller: _placaController,
              decoration: InputDecoration(labelText: 'Placa'),
            ),
            TextField(
              controller: _capacidadeController,
              decoration: InputDecoration(labelText: 'Capacidade'),
            ),
            TextField(
              controller: _linhaController,
              decoration: InputDecoration(labelText: 'Linha'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo.shade900),
              ),
              onPressed: _salvarEdicao,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
