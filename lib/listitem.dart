import 'package:flutter/material.dart';
import 'package:tasktwo/item_name.dart';
import 'package:tasktwo/securestoragefile.dart';

class Todolists extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const Todolists({Key? key, required this.todo, required this.onToDoChanged, required this.onDeleteItem }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(17.17),
        child: ListTile(
          onTap: () {
            onToDoChanged(todo);
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.brown[50],
          leading: Icon(
          todo.isDone! ? Icons.check_circle_rounded : Icons.check_circle_outline_rounded,
            color: Colors.teal[300],
          ),
          title: Text(
            todo.todoText!,
            style: TextStyle(
              fontSize: 16,
              decoration: todo.isDone! ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: IconButton(
            onPressed: (){
              //this will delete the item
              onDeleteItem(todo.id);
            },
            icon: Icon(Icons.delete_rounded),
            color: Colors.red[300],
          ),
        ),
      ),


    );
  }
}



