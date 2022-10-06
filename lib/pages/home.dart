import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytodo_app/model/todo.dart';
import 'package:provider/provider.dart';
import 'package:mytodo_app/model/task_data.dart';

class Home extends StatelessWidget {
  bool isComplete = false;
  TextEditingController todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String? newTask;
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'My To-Do List',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(width: 6),
              Icon(IconData(0xe05b, fontFamily: 'MaterialIcons'))
            ],
          ),
          backgroundColor: Colors.purple),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          margin: EdgeInsets.only(top: 20, bottom: 80),
          child: Consumer<TaskData>(
            builder: (context, taskData, child) {
              return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.transparent,
                      ),
                  shrinkWrap: true,
                  itemCount: taskData.tasks.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      // key: Key(index.toString()),
                      key: UniqueKey(),
                      background: Container(
                        padding: EdgeInsets.only(right: 30),
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        ),
                        color: Colors.transparent,
                      ),
                      // onDismissed: (direction) {
                      //   print("removed");
                      // },
                      child: ListTile(
                        onTap: () {
                          // setState(() {
                          //   isComplete = !isComplete;
                          // });
                        },
                        leading: Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Column(
                            children: [
                              isComplete
                                  ? Icon(Icons.check, color: Colors.greenAccent)
                                  : Icon(Icons.check,
                                      color: Colors.transparent),
                              Container(
                                height: 3,
                                width: 25,
                                decoration:
                                    BoxDecoration(color: Colors.orangeAccent),
                              ),
                            ],
                          ),
                        ),
                        title: Text(
                          taskData.tasks[index].title,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    );
                  });
            },
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            gradient: LinearGradient(
              colors: [Color(0xff432677), Color(0xffbe3ed4)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 45.0),
            child: SizedBox(
              width: 90,
              height: 90,
              child: FloatingActionButton.large(
                child: const Icon(Icons.add),
                backgroundColor: Colors.orangeAccent,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => new SimpleDialog(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45)),
                            title: Row(
                              children: [
                                Text(
                                  "Add task",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            ),
                            children: [
                              Divider(),
                              TextField(
                                autofocus: true,
                                textAlign: TextAlign.center,
                                onChanged: (newText) {
                                  newTask = newText;
                                },
                                controller: todoController,
                                style: TextStyle(
                                    fontSize: 17,
                                    height: 1.5,
                                    color: Colors.purple),
                                decoration: InputDecoration(
                                    hintText: "eg. shopping",
                                    border: InputBorder.none),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: TextButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                  ),
                                  onPressed: () {
                                    Provider.of<TaskData>(context,
                                            listen: false).addToList(newTask!);
                                    if (todoController.text.isNotEmpty) {
                                      print(todoController.text);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    'Add',
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ),
                              ),
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                              )
                            ],
                          ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
