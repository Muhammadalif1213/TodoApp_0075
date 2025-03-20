import 'package:flutter/material.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({super.key});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
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
              Text('Task Date:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select a date'),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.calendar_today),
                    color: Colors.blue,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('First Name'),
                        hintText: 'Masukan Kegiatan Anda',
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom( backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white),
                    child: const Text("Submit")
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
