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
  // Correctly declaring the task list
  List<String> _ListaTarefa = ["Tarefa 1", "Tarefa 2", "Tarefa 3"];

  //metodos
  _savarPath()async{
    final Directory directory = await getApplicationDocumentsDirectory();
    
    final File file = File('${directory.path}/data.json');
    final String data = jsonEncode(_ListaTarefa);
    file.writeAsString(data);

  }
  getPath()async{
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/data.json');
    if(file.existsSync()){
      final data = file.readAsStringSync();
      final json = jsonDecode(data);
      return json;
    }
  }

  lerPath()async{
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/data.json');
    if(file.existsSync()){
      final data = file.readAsStringSync();
      final json = jsonDecode(data);
      return json;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Lista de Tarefas',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _ListaTarefa.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_ListaTarefa[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.check_box_outline_blank,
                        color: Color(0xFF080606)),
                    onPressed: () {
                      setState(() {
                        _ListaTarefa.removeAt(index); // Remove item on delete
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        elevation: 3,
        foregroundColor: Colors.white,
        onPressed: () {
          _showAddTaskDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar Tarefa'),
          content: TextField(
           // controller:  _taskController,
            decoration: const InputDecoration(
              labelText: 'Digite a tarefa',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
               /* setState(() {
                  if (_taskController.text.isNotEmpty) {
                    _ListaTarefa.add(_taskController.text); // Add task
                  }
                });
                _taskController.clear(); // Clear input
                Navigator.pop(context); // Close the dialog
              },*/
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
