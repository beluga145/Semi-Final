import 'package:flutter/material.dart';
import 'class.dart';

class FormPage extends StatelessWidget {
  final Todo? todo;
  const FormPage({Key? key,
    this.todo}) : super(key: key);

  get dbHelper => null;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    if(todo != null){
      titleController.text = todo!.title;
      descController.text = todo!.description;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(todo == null ?'Add to do': 'Update to do'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
              keyboardType: TextInputType.multiline,
              onChanged: (str){},
              maxLines: 5,
            ),
            const SizedBox(height: 40,),
            SizedBox(
              child: ElevatedButton(
                onPressed: () async {
                  final title = titleController.text;
                  final description = descController.text;

                  if(title.isEmpty || description.isEmpty){
                    return;
                  }

                  final Todo model = Todo(title: title, description: description, id: todo?.id);
                  if(todo == null){
                    await dbHelper.addTodo(model);
                  }else{
                    await dbHelper.updateTodo(model);
                  }

                  Navigator.pop(context);
                },
                child: Text(todo == null ? 'Save to do': 'Edit to do'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
