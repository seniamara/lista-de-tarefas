import 'dart:convert'; // Para converter listas/objetos em JSON e vice-versa
import 'dart:io'; // Para lidar com arquivos no dispositivo
import 'package:flutter/material.dart'; // Para criar interfaces com Flutter
import 'package:path_provider/path_provider.dart'; // Para obter diretórios no dispositivo

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Lista de tarefas inicializada com valores de exemplo
  List<String> _ListaTarefa = [];
  TextEditingController _controladorTarefa = TextEditingController();

  // Método para salvar a lista de tarefas em um arquivo JSON
  Future<void> _salvarTarefas() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/data.json');
    final String data = jsonEncode(_ListaTarefa); // Converte a lista para JSON
    await file.writeAsString(data); // Salva o JSON no arquivo
  }

  // Método para carregar as tarefas salvas no arquivo
  Future<void> _carregarTarefas() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/data.json');
    if (await file.exists()) {
      final String data = await file.readAsString(); // Lê o conteúdo do arquivo
      final List<dynamic> json = jsonDecode(data); // Decodifica o JSON
      setState(() {
        _ListaTarefa = List<String>.from(json); // Atualiza a lista com os dados do arquivo
      });
    }
  }

  // Inicialização do estado do widget
  @override
  void initState() {
    super.initState();
    _carregarTarefas(); // Carrega as tarefas quando o app é iniciado
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
            // Lista de tarefas com builder para otimizar a renderização
            child: ListView.builder(
              itemCount: _ListaTarefa.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_ListaTarefa[index]), // Exibe o texto da tarefa
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.check_box_outline_blank,
                      color: Color(0xFF080606),
                    ),
                    onPressed: () {
                      setState(() {
                        _ListaTarefa.removeAt(index); // Remove a tarefa da lista
                        _salvarTarefas(); // Salva a lista atualizada
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
        onPressed: _mostrarDialogoAdicionarTarefa, // Chama o diálogo de adicionar
        child: const Icon(Icons.add),
      ),
    );
  }

  // Método para exibir o diálogo de adicionar tarefa
  void _mostrarDialogoAdicionarTarefa() {
    final TextEditingController _controladorTarefa = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar Tarefa'),
          content: TextField(
            controller: _controladorTarefa, // Controlador para obter o texto digitado
            decoration: const InputDecoration(
              labelText: 'Digite a tarefa',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (_controladorTarefa.text.isNotEmpty) {
                    _ListaTarefa.add(_controladorTarefa.text); // Adiciona a tarefa
                    _salvarTarefas(); // Salva a lista atualizada
                  }
                });
                _controladorTarefa.clear(); // Limpa o campo de texto
                Navigator.pop(context); // Fecha o diálogo
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
