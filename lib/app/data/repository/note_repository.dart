import 'package:getxtutorial6sqlitetodo/app/data/model/note_model.dart';
import 'package:getxtutorial6sqlitetodo/app/data/provider/note_provider.dart';

class NoteRepository {
  final NoteProvider api;
  NoteRepository(this.api);

  getAll() {
    return api.getAll();
  }

  save(Note note) {
    return api.save(note);
  }

  update(Note note) {
    return api.update(note);
  }

  delete(int id) {
    return api.delete(id);
  }
}
