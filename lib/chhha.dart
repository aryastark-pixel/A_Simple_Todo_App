import 'package:flutter/material.dart';
import 'package:tasktwo/listitem.dart';
import 'package:tasktwo/item_name.dart';
import 'package:tasktwo/securestoragefile.dart';
class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final todosList = ToDo.todoList();
  late  TextEditingController todoController;
  @override
  void initState() {
    todoController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        primary: true,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
             Builder(
              builder: (context) {
                return IconButton(
                  padding: EdgeInsets.only( ),
                  icon: Icon(Icons.menu, size:30),
                  color: Colors.brown[400],
                  onPressed: (){
                   Scaffold.of(context).openDrawer();
                  },
                );
              }
            ),
          ],
        ),),
        drawer: Drawer(
          child: Container(
            padding: EdgeInsets.only(top:30),
            color: Colors.brown[50],

            child: Column(
              children: [
                DrawerHeader(
                  child: Icon(
                    Icons.manage_accounts_outlined,
                    size: 100,
                    color: Colors.brown[600],
                  ),
                ),
                ListTile(
                 leading: Icon(
                   Icons.save_as_rounded,
                   color: Colors.brown[500],
                 ),
                  title: Text('Store To-Do list'),
                  onTap: (){
                   SecureStorage().writeSecureData('todos',todoController.text);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.get_app_rounded,
                    color: Colors.brown,
                  ),
                  title: Text('Previous To-Do list'),
                  onTap: (){
                  //read data SecureStorage().readSecureData('todos');

                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.brown,
                  ),
                  title: Text('Delete To-Do list'),
                  onTap: (){
                    //delete SecureStorage().deleteSecureData('todos');
                  },
                ),
              ],
            )

          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 8,),
            Padding(
              padding: EdgeInsets.all(17.17),
              child: TextField(
                controller: todoController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.5, color: Colors.brown),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'enter to-do list',
                  prefixIcon: Icon(
                    Icons.note_add_rounded,
                    color: Colors.brown,
                  ),
                ),
              ),
            ), //Enter to-do list bar
            SizedBox(height: 10,),
            RawMaterialButton(
              onPressed: () {
                _addItem(todoController.text);
              },
              elevation: 2.0,
              fillColor: Colors.brown[50],
              child: Icon(
                Icons.add_rounded,
                color: Colors.brown[800],
                size: 35.0,
              ),
              padding: EdgeInsets.all(14.30),
              shape: CircleBorder(),
            ),

            Expanded(child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only( top:18, bottom: 20),
                    child: Center(
                      child: Text(
                      'Your to-do\'s',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                ),
               for( ToDo todo in todosList)
                  Todolists(
                    todo:todo,
                    onToDoChanged: _handleToDoChange,
                    onDeleteItem: _deleteToDoItem,
                  ),
              ],
            ))
          ],
        )

    );
  }
  void _handleToDoChange(ToDo todo) {
    //this handles change in the checkbox
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }
 void _deleteToDoItem (String id) {
    //this deletes the item from the list
   setState(() {
     todosList.removeWhere((item) => item.id == id);
   });
 }

 void _addItem (String toDo){
    setState(() {
      //this adds item to the list
      todosList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo));
    });
   todoController.clear();
    }


}
