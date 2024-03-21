import 'package:flutter/material.dart';

import '../../domain/entities/task.dart';
import '../controllers/todo_list_controller.dart';

class toDoListPage extends StatefulWidget {

  final String title;
  final TodoListController controller;

  const toDoListPage({super.key, required this.title, required this.controller, });
  @override
  State<toDoListPage> createState() => _toDoListPageState();
}

class _toDoListPageState extends State<toDoListPage> {

  @override
  void initState() {
    super.initState();
    widget.controller.loadTasks();
    widget.controller.errorNotifier.addListener(_showError);
  }

  void _showError() {
    final errorMessage = widget.controller.errorNotifier.value;
    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(errorMessage),)
      );
    }
  }


  @override
  void dispose() {
    widget.controller.errorNotifier.removeListener(_showError);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          "Clean Arc Todo List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black54,
          ),
        ),
      ),
      body: ValueListenableBuilder<List<Task>>(
        valueListenable: widget.controller.tasksNotifier,
        builder: (context, tasks, child) {
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(task.title),
                  subtitle: Text('Completed: ${task.isCompleted ? "Yes" : "No"}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      widget.controller.deleteTask(task);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showModalBottomSheet,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showModalBottomSheet() {
    final _formKey = GlobalKey<FormState>();
    final containerHeight = 800.0;
    String taskTitle = '';
    bool isCompleted = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50.0),
        ),
      ),
      builder: (BuildContext context) {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Adicionar Nova Tarefa",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16.0),
                      child: TextFormField(
                        decoration: bottomSheetInputDecoration("Título"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um título';
                          }
                          return null;
                        },
                        onSaved: (value) => taskTitle = value ?? '',
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 8.0, vertical: 8.0),
                    //   child: SizedBox(
                    //     height: containerHeight / 4,
                    //     child: TextFormField(
                    //       decoration: bottomSheetInputDecoration("Descrição"),
                    //       maxLines: 10,
                    //       minLines: 6,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: cancelFlowButtonStyle,
                              child: const Text('Cancelar'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: positiveFlowButtonStyle,
                              child: const Text('Salvar'),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  widget.controller.createAndAddTask(taskTitle, isCompleted: isCompleted);
                                  Navigator.pop(context);
                                }
                              },

                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  InputDecoration bottomSheetInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      alignLabelWithHint: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }

  final positiveFlowButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.blue.shade900,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

  final cancelFlowButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    side: BorderSide(color: Colors.black, width: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
