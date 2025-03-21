import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({super.key});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  final TextEditingController nameController = TextEditingController();
  final key = GlobalKey<FormState>();
  DateTime? _selectedDateTime;
  final List<Map<String, dynamic>> _tasks = [];

  void pickDateTime() async {
    DateTime now = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void addTask() {
    if (key.currentState!.validate() && _selectedDateTime != null) {
      setState(() {
        _tasks.add({
          'title': nameController.text,
          'deadline': _selectedDateTime!,
          'isDone': false,
        });
      });

      nameController.clear();
      _selectedDateTime = null;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Task added successfully"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 24),
          child: Text('Form Page', style: TextStyle(fontSize: 26)),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Task Date:'),
                            Text(
                              _selectedDateTime == null
                                  ? "Select a date"
                                  : DateFormat(
                                    'dd-MM-yyyy HH:mm',
                                  ).format(_selectedDateTime!),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: pickDateTime,
                          icon: Icon(Icons.calendar_today),
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    if (_selectedDateTime == null)
                      const Text(
                        "Please select a date & time",
                        style: TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('First Name'),
                              hintText: 'Masukan Kegiatan Anda',
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: addTask,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Submit"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'List Tasks',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    final task = _tasks[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: task['isDone'] ? Colors.green : Colors.red,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task['title'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Deadline: ${DateFormat('dd-MM-yyyy HH:mm').format(task['deadline'])}",
                              ),
                              Text(
                                task['isDone'] ? "Done" : "Not Done",
                                style: TextStyle(
                                  color:
                                      task['isDone']
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Checkbox(
                            value: task['isDone'],
                            onChanged: (bool? value) {
                              setState(() {
                                task['isDone'] = value ?? false;
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
