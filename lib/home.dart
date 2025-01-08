import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Correctly declaring the task list
  List<String> _ListaTarefa = ["Tarefa 1", "Tarefa 2", "Tarefa 3"];
  final TextEditingController _taskController = TextEditingController();

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
            controller: _taskController,
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
                setState(() {
                  if (_taskController.text.isNotEmpty) {
                    _ListaTarefa.add(_taskController.text); // Add task
                  }
                });
                _taskController.clear(); // Clear input
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
