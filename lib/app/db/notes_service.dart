import 'package:get/get.dart';
import 'package:getxtutorial6sqlitetodo/app/data/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesService extends GetxService {
  //o banco de dados declarado como late sera inicializado na primeira leitura
  late Database db;

  Future<NotesService> init() async {
    db = await _getDatabase();
    //criar nota de teste
    // final note = Note(
    //   title: 't1',
    //   content: 'c1',
    // );
    // await save(note);
    // await getAll();
    return this;
  }

  Future<Database> _getDatabase() async {
    // Recupera pasta da aplicacao
    var databasesPath = await getDatabasesPath();
    // Recupera caminho da database e excluir database
    // String path = join(databasesPath, 'notes.db');
    // descomente o await abaixo para excluir a base de dados do caminho
    // recuperado pelo path na inicializacao
    // await deleteDatabase(path);
    // Retorna o banco de dados aberto
    return db = await openDatabase(
      join(databasesPath, 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, content TEXT)');
      },
      version: 1,
    );
  }

  // recuperar todas as notas
  Future<List<Note>> getAll() async {
    final result = await db.rawQuery('SELECT * FROM notes ORDER BY id');
    print(result);
    return result.map((json) => Note.fromJson(json)).toList();
  }

  //criar nova nota
  Future<Note> save(Note note) async {
    final id = await db.rawInsert(
        'INSERT INTO notes (title, content) VALUES (?,?)',
        [note.title, note.content]);

    print(id);
    return note.copy(id: id);
  }

  //atualizar nota
  Future<Note> update(Note note) async {
    final id = await db.rawUpdate(
        'UPDATE notes SET title = ?, content = ? WHERE id = ?',
        [note.title, note.content, note.id]);

    print(id);
    return note.copy(id: id);
  }

  //excluir nota
  Future<int> delete(int noteId) async {
    final id = await db.rawDelete('DELETE FROM notes WHERE id = ?', [noteId]);

    print(id);
    return id;
  }

  //fechar conexao com o banco de dados, funcao nao usada nesse app
  Future close() async {
    db.close();
  }
}
