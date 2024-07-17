import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_aap/theme/myColors.dart';
import 'package:todo_aap/widgets/customElevatedButton.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  _AddTaskBottomSheetState createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isToday = true;

  ///SetTime
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  ///AddTask Function
  Future<void> _addTask() async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/todos/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'todo': _nameController.text,
        'completed': false,
        'userId': 5,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data); // Handle the response data as needed
    } else {
      throw Exception('Failed to add task');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                ///Close Button
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                  ),
                ),
                const Text(
                  'Task',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                    width: 48), // To balance the 'Close' button width
              ],
            ),
            const SizedBox(height: 16),
            Text('Add a task',
                style: GoogleFonts.hankenGrotesk(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const SizedBox(height: 16),

            ///TitleName
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Lorem ipsum dolor',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            ///Time Added todo
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectTime(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _timeController,
                        decoration: InputDecoration(
                          // labelText: 'Hour',
                          hintText: _selectedTime.format(context),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                /// AM/PM
                DropdownButton<String>(
                  value: _selectedTime.period == DayPeriod.am ? 'AM' : 'PM',
                  items: ['AM', 'PM'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      if (value == 'AM') {
                        _selectedTime = TimeOfDay(
                          hour: _selectedTime.hour % 12,
                          minute: _selectedTime.minute,
                        );
                      } else {
                        _selectedTime = TimeOfDay(
                          hour: (_selectedTime.hour % 12) + 12,
                          minute: _selectedTime.minute,
                        );
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            ///TodayText
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Switch(
                  value: _isToday,
                  activeColor: const Color(0xff34C759),
                  onChanged: (bool value) {
                    setState(() {
                      _isToday = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            ///Done Button
            CustomElevatedButton(
                height: 58,
                buttonColor: ColorTheme.blackBold,
                textColor: ColorTheme.whiteBold,
                textSize: 14,
                borderRadius: BorderRadius.circular(8),
                width: MediaQuery.of(context).size.width,
                text: 'Done',
                onPressed: () {
                  Navigator.pop(context);
                }),
            const SizedBox(height: 8),
            const Text(
              textAlign: TextAlign.start,
              'If you disable today, the task will be considered as tomorrow',
              style: TextStyle(
                color: ColorTheme.greyRegularAndBold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
