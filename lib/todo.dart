import 'package:flutter/material.dart';
import 'class.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const TodoWidget({Key? key, required this.todo, required this.onTap, required this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
        child: Card(
          elevation: 2,
          child:Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    todo.title,
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12)
                ),
                Text(todo.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
