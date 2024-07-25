import 'package:flutter/material.dart';
import 'package:practice/modele/pop_model.dart';

class NewPop extends StatefulWidget {
  const NewPop({super.key, required this.inputform});
  final void Function(PopModel popmodel, PriceCategory category) inputform;

  @override
  State<NewPop> createState() {
    return _newState();
  }
}

class _newState extends State<NewPop> {
  PriceCategory _selectedsalary = PriceCategory.below50;
  final _textcontroller = TextEditingController();
  DateTime? _selectedDate;
  String? selectedgender;

  void tap() async {
    final now = DateTime.now();
    final birthdate = DateTime(now.year - 200, now.month, now.day);
    final birth = await showDatePicker(
      context: context,
      firstDate: birthdate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = birth;
    });
  }

  void _save() {
    if (_textcontroller.text.trim().isEmpty ||
        selectedgender == null ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please fill in all fields to submit.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    // Create a new PopModel instance
    final newPopModel = PopModel(
      name: _textcontroller.text,
      salary: _selectedsalary.description,
      date: _selectedDate!,
      gender: selectedgender!,
    );

    // Call the inputform function with the new model and category
    widget.inputform(newPopModel, _selectedsalary);

    // Close the modal
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(children: [
        TextField(
          controller: _textcontroller,
          maxLength: 50,
          decoration: const InputDecoration(
            label: Text('Name'),
          ),
        ),
        Row(
          children: [
            DropdownButton(
              value: _selectedsalary,
              items: PriceCategory.values
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.description),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  _selectedsalary = value;
                });
              },
            ),
            const Spacer(),
            Text(_selectedDate == null
                ? 'Not selected Date of Birth'
                : formatter.format(_selectedDate!)),
            IconButton(
                onPressed: tap, icon: const Icon(Icons.calendar_month)),
            const SizedBox(width: 16),
          ],
        ),
        Row(
          children: [
            const Text('Gender'),
            const SizedBox(width: 10),
            Expanded(
              child: RadioListTile(
                title: const Text('Male'),
                value: 'Male',
                groupValue: selectedgender,
                onChanged: (value) {
                  setState(() {
                    selectedgender = value;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Female'),
                value: 'Female',
                groupValue: selectedgender,
                onChanged: (value) {
                  setState(() {
                    selectedgender = value;
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(onPressed: _save, child: const Text('Save')),
          ],
        ),
      ]),
    );
  }
}
