import 'dart:convert';

import 'package:app2/screen/listaScreen.dart';
import 'package:app2/theme/colorTheme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastroUsuarios extends StatefulWidget {
  const CadastroUsuarios({super.key});

  @override
  State<CadastroUsuarios> createState() => _CadastroUsuariosState();
}

class _CadastroUsuariosState extends State<CadastroUsuarios> {
  late TextEditingController nomeController;
  late TextEditingController telefoneController;
  late TextEditingController apelidoController;
  late TextEditingController dataAniversarioController;

  String nome = '';
  String telefone = '';
  String apelido = '';
  String dataAniversario = '';

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController();
    telefoneController = TextEditingController();
    apelidoController = TextEditingController();
    dataAniversarioController = TextEditingController();
  }

  @override
  void dispose() {
    nomeController.dispose();
    telefoneController.dispose();
    apelidoController.dispose();
    dataAniversarioController.dispose();
    super.dispose();
  }

  Future<void> _enviarDados(BuildContext context) async {
    print("Tentando enviar dados...");
    const String url = "http://10.0.2.2:8080/users";
    final Map<String, String> data = {
      'nome': nomeController.text, // Verifique o valor das variáveis
      'telefone': telefoneController.text,
      'apelido': apelidoController.text,
      'datadeaniversario': dataAniversarioController.text,
    };

    final encodedData = json.encode(data);

    try {
      print("Enviando requisição para $url com os dados: $encodedData");
      final response = await http
          .post(
            Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: encodedData,
          )
          .timeout(const Duration(seconds: 10));

      print("Resposta recebida: ${response.statusCode}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário cadastrado com sucesso!')),
      );
    } catch (error) {
      print("Erro durante a requisição: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray900,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.gray900,
        title: const Text(
          "Cadastro de Usuários",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nomeController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: AppColors.gray900,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  nome = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: telefoneController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Telefone",
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: AppColors.gray900,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  telefone = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: apelidoController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Apelido",
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: AppColors.gray900,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  apelido = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.datetime,
              controller: dataAniversarioController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Data de Aniversário",
                labelStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: AppColors.gray900,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  dataAniversario = value;
                });
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.teal600,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () => _enviarDados(context),
              child: const Text("Inserir Usuário"),
            ),
          ],
        ),
      ),
    );
  }
}
