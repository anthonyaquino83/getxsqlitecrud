import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtutorial6sqlitetodo/app/data/provider/note_provider.dart';
import 'package:getxtutorial6sqlitetodo/app/data/repository/note_repository.dart';
import 'package:getxtutorial6sqlitetodo/app/modules/notes/note_controller.dart';

class NoteListPage extends GetView<NoteController> {
  final controller = Get.put(NoteController(NoteRepository(NoteProvider())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GetX SQLite CRUD Tutorial')),
      body: Obx(() {
        //para testar melhor o loading, descomente a future delayed
        //no provider pra simular uma pequena demora no retorno da requisicao
        if (controller.loading.value == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: controller.noteList.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text('${controller.noteList[index].title}'),
            trailing: Wrap(children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  controller.editNote(controller.noteList[index]);
                },
              ),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Get.defaultDialog(
                        title: 'Excluir Nota',
                        middleText:
                            'Excluir nota de título ${controller.noteList[index].title}?',
                        textCancel: 'Voltar',
                        onConfirm: () {
                          controller.deleteNote(controller.noteList[index].id!);
                          if (controller.loading.value == true) {
                            Get.dialog(
                              Center(child: CircularProgressIndicator()),
                            );
                          }
                        });
                  }),
            ]),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.addNote();
        },
      ),
    );
  }
}
