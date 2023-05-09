import 'dart:io'; //追加

import 'package:drift/drift.dart';
import 'package:drift/native.dart'; //追加
import 'package:path/path.dart' as p; //追加
import 'package:path_provider/path_provider.dart'; //追加

part 'todos.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()();
}

@DriftDatabase(tables: [Todos])
class MyDatabase extends _$MyDatabase {
  //4
  MyDatabase() : super(_openConnection()); //追加

  //5
  @override //追加
  int get schemaVersion => 1; //追加

  //7
  //以下追記
  Stream<List<Todo>> watchEntries() {
    return (select(todos)).watch();
  }

  //8
  //以下追記
  Future<List<Todo>> get allTodoEntries => select(todos).get();

  //12
  //以下追加
  Future<int> addTodo(String content) {
    return into(todos).insert(TodosCompanion(content: Value(content)));
  }

  //13
//以下追加
  Future<int> updateTodo(Todo todo, String content) {
    return (update(todos)..where((tbl) => tbl.id.equals(todo.id))).write(
      TodosCompanion(
        content: Value(content),
      ),
    );
  }

  //14
//以下追加
  Future<void> deleteTodo(Todo todo) {
    return (delete(todos)..where((tbl) => tbl.id.equals(todo.id))).go();
  }
}

//6
//以下追加
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
