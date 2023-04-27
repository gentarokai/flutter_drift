import 'src/drift/todos.dart';
import 'package:flutter/material.dart';

void main() {
  final database = MyDatabase();
  //9
  runApp(MyApp(database: database));  //変更
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.database,  //追加
  }) : super(key: key);

  final MyDatabase database;  //追加

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //9
      home: DriftSample(database: database),//変更
    );
  }
}

class DriftSample extends StatelessWidget {
  const DriftSample({
    Key? key,
    required this.database,  //追加
  }) : super(key: key);

  final MyDatabase database;  //追加

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              //10
              //以下、Container()をStreamBuilder(...)に置き換え
              child: StreamBuilder(
                stream: database.,
                builder:
                    (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    //11
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => TextButton(
                      child: Text(snapshot.data![index].content),
                      onPressed: () async {
                      },
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      child: const Text('Add'),
                      onPressed: () async {
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      child: const Text('remove'),
                      onPressed: () async {
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}