import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Manipulação de dodos"),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Digete algo"),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text("salvar"),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "ler",
                      selectionColor: Colors.blueGrey,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
