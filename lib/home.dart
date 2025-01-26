import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> _listaTarefas = [];

  Future<void> _salvarTarefas() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/data.json');
    final data = jsonEncode(_listaTarefas);
    await file.writeAsString(data);
  }

  Future<void> _carregarTarefas() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/data.json');
    if (await file.exists()) {
      final data = await file.readAsString();
      setState(() {
        _listaTarefas = List<Map<String, dynamic>>.from(jsonDecode(data));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Lista de Tarefas',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _listaTarefas.length,
              itemBuilder: (context, index) {
                final tarefa = _listaTarefas[index];
                return ListTile(
                  title: Text(
                    tarefa['titulo'],
                    style: TextStyle(
                      decoration: tarefa['realizada']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          tarefa['realizada']
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            tarefa['realizada'] = !tarefa['realizada'];
                            _salvarTarefas();
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _confirmarRemocao(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: _mostrarDialogoAdicionarTarefa,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _mostrarDialogoAdicionarTarefa() {
    final TextEditingController _controladorTarefa = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar Tarefa'),
          content: TextField(
            controller: _controladorTarefa,
            decoration: const InputDecoration(
              labelText: 'Digite a tarefa',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (_controladorTarefa.text.trim().isNotEmpty) {
                  setState(() {
                    _listaTarefas.add({
                      'titulo': _controladorTarefa.text.trim(),
                      'realizada': false,
                    });
                    _salvarTarefas();
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _confirmarRemocao(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remover Tarefa'),
          content: const Text('Deseja realmente remover esta tarefa?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _listaTarefas.removeAt(index);
                  _salvarTarefas();
                });
                Navigator.pop(context);
              },
              child: const Text('Remover')
            ),
          ],
        );
      },
    );
  }
}
