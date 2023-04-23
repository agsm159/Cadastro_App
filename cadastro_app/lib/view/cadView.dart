import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int contactId = 0;
  String username = "";
  String password = "";

  _openDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'database.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String sql =
            'CREATE TABLE contacts (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR)';
        await db.execute(sql);
      },
    );
    return db;
  }

  _save() async {
    Database db = await _openDB();
    Map<String, dynamic> contactData = {
      'username': username,
      'password': password
    };
    setState(() async {
      contactId = await db.insert('contacts', contactData);
    });
    print(contactId);
  }

  @override
  Widget build(BuildContext context) {
    _openDB();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://media.istockphoto.com/vectors/stream-of-gold-coins-pours-from-the-fuel-handle-pump-nozzle-with-hose-vector-id1251678227?k=20&m=1251678227&s=612x612&w=0&h=WueKOjZwKgOk0wRBcj9zhL7Bli9N4Vy3vs8NcDJHwBA=',
              height: 200,
              width: 200,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                label: Center(child: Text('Login')),
              ),
              onChanged: (value) {
                setState(() {
                });
              },
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                label: Center(child: Text('Senha')),
              ),
              onChanged: (value) {
                setState(() {
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => {},
              child: const Text("Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }
}
