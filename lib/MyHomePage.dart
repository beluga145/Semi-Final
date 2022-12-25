import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'class.dart';
import 'form_page.dart';
import 'todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("To do List - Assignment 2"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FormPage()));
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<List<Todo>?>(
          future: dbHelper.getAllTodo(),
          builder: (context, AsyncSnapshot<List<Todo>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              if (snapshot != null) {
                return ListView.builder(
                  itemBuilder: (context, index) => TodoWidget(
                    todo: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const FormPage()));
                      setState(() {});
                    },
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title:
                              const Text('Are you sure u want to delete?'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await dbHelper
                                        .deleteTodo(snapshot.data![index]);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: const Text('Yes'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  itemCount: snapshot.data!.length,
                );
              }
              return const Center(
                child: Text('No to do'),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
