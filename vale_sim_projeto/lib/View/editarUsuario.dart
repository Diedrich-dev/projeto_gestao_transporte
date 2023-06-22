import 'package:flutter/material.dart';
import 'package:vale_sim_projeto/Model/usuario.dart';
import 'package:vale_sim_projeto/Service/usuarioService.dart';

class EditarUsuario extends StatefulWidget {
  final Usuario usuario;

  const EditarUsuario({Key? key, required this.usuario}) : super(key: key);

  @override
  _EditarUsuarioState createState() => _EditarUsuarioState();
}

class _EditarUsuarioState extends State<EditarUsuario> {
  late TextEditingController _nomeController;
  late TextEditingController _sobrenomeController;
  late TextEditingController _senhaController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.usuario.nome);
    _sobrenomeController = TextEditingController(text: widget.usuario.sobrenome);
    _senhaController = TextEditingController(text: widget.usuario.senha);
    _emailController = TextEditingController(text: widget.usuario.email);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _senhaController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _salvarEdicao() async {
    String novoNome = _nomeController.text;
    String novoSobrenome = _sobrenomeController.text;
    String novaSenha = _senhaController.text;
    String novoEmail = _emailController.text;

    Usuario usuarioAtualizado = Usuario(
      id: widget.usuario.id,
      nome: novoNome,
      sobrenome: novoSobrenome,
      senha: novaSenha,
      email: novoEmail,
      transportesFavoritos: widget.usuario.transportesFavoritos,
    );

    UsuarioService usuarioService = UsuarioService();
    await usuarioService.atualizarUsuario(usuarioAtualizado);

    Navigator.pop(context, usuarioAtualizado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: Text('Editar Usuário', style: TextStyle(color: Color.fromARGB(255, 220, 183, 0),)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              controller: _sobrenomeController,
              decoration: InputDecoration(labelText: 'Sobrenome'),
            ),
            TextFormField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
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
