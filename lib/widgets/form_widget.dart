import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/theme.dart';

class FormWidget extends StatefulWidget {
  final Function(String, String, DateTime) addFunction;
  const FormWidget({
    Key? key,
    required this.addFunction,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  DateTime? dateSelected;
  TimeOfDay? timeSelected;
  DateTime? dateResult;

  final timeController = TextEditingController();
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();

  void _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      setState(() {
        dateSelected = picked;
        dateResult = picked;
      });
    }
  }

  void _selectedTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 00, minute: 00),
    );
    if (picked != null) {
      setState(() {
        timeSelected = picked;
        dateResult = dateResult!.add(
          Duration(hours: picked.hour, minutes: picked.minute),
        );
        timeController.text =
            DateFormat('dd/MM/yyyy hh:mm').format(dateResult!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text('New Task'),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Task',
                hintStyle: TextStyle(color: grey),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Sub Task',
                hintStyle: TextStyle(color: grey),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: timeController,
              decoration: InputDecoration(
                suffixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          _selectedDate(context);
                          _selectedTime(context);
                        },
                        icon: Icon(Icons.calendar_month)),
                    Text(timeController.text),
                  ],
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Time',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: blue,
            ),
            onPressed: () {
              widget.addFunction(
                  titleController.text, subtitleController.text, dateResult!);
              Navigator.of(context).pop();
            },
            child: Text(
              'add',
              style: TextStyle(color: card_white, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }
}
