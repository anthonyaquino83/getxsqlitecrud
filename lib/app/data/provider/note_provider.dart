import 'package:get/get.dart';
import 'package:getxtutorial6sqlitetodo/app/data/model/note_model.dart';
import 'package:getxtutorial6sqlitetodo/app/db/notes_service.dart';

class NoteProvider {
  final notesService = Get.find<NotesService>();

  Future<List<Note>> getAll() async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    // await Future.delayed(Duration(seconds: 2));
    return await notesService.getAll();
  }

  Future<Note> save(Note note) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    await Future.delayed(Duration(seconds: 2));
    return await notesService.save(note);
  }

  Future<Note> update(Note note) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    await Future.delayed(Duration(seconds: 2));
    return await notesService.update(note);
  }

  Future<int> delete(int noteId) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    await Future.delayed(Duration(seconds: 2));
    return await notesService.delete(noteId);
  }
}
