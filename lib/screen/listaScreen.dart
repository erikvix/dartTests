import 'package:app2/theme/colorTheme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListaUsuarios extends StatefulWidget {
  const ListaUsuarios({super.key});

  @override
  State<ListaUsuarios> createState() => _ListaUsuariosState();
}

class _ListaUsuariosState extends State<ListaUsuarios> {
  List<dynamic> usuarios = [];

  Future<void> fetchUsuarios() async {
    final url = Uri.parse('http://10.0.2.2:8080/users');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        usuarios = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao carregar usuários.")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray900,
      appBar: AppBar(
        title: const Text("Lista de Usuários"),
      ),
      body: ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          final usuario = usuarios[index];
          return ListTile(
            title: Text(usuario['nome'],
                style: const TextStyle(color: Colors.white)),
            subtitle: Text(usuario['telefone'],
                style: const TextStyle(color: Colors.white)),
          );
        },
      ),
    );
  }
}
