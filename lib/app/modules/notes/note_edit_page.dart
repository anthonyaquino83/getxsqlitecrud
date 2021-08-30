import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'note_controller.dart';

class NoteEditPage extends GetView<NoteController> {
  final controller = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${controller.titulo}')),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Título',
                ),
                controller: controller.titleController,
                focusNode: controller.titleFocusNode,
                textInputAction: TextInputAction.next,
                onEditingComplete: controller.contentFocusNode.requestFocus,
                onFieldSubmitted: (String value) {
                  controller.contentFocusNode.requestFocus();
                },
                validator: (value) {
                  return controller.validarTitulo(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Conteúdo',
                ),
                controller: controller.contentController,
                focusNode: controller.contentFocusNode,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (String value) {
                  controller.editMode();
                  if (controller.loading.value == true) {
                    Get.dialog(Center(child: CircularProgressIndicator()));
                  }
                },
                validator: (value) {
                  return controller.validarConteudo(value);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.editMode();
                      if (controller.loading.value == true) {
                        Get.dialog(Center(child: CircularProgressIndicator()));
                      }
                    },
                    child: Text('Salvar'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
