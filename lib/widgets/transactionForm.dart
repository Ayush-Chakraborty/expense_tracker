import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function addTransaction;
  const TransactionForm(this.addTransaction);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _pickedDate = DateTime.now();
  String? _date;

  void _submitHandler() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _date == null) return;
    double amount = double.parse(_amountController.text);
    if (amount < 0) return;
    widget.addTransaction(_titleController.text, amount, _pickedDate);
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: _pickedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        _date = DateFormat.yMMMd().format(value).toString();
        _pickedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            decoration: const InputDecoration(labelText: 'Title'),
            controller: _titleController,
            onSubmitted: (_) => _submitHandler(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 10,
              top: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 15),
          child: TextField(
            decoration: const InputDecoration(labelText: 'Amount'),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitHandler(),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_date == null ? 'No Date Choosen' : 'Picked Date: $_date'),
                TextButton(
                    onPressed: _showDatePicker,
                    child: const Text('Choose Date'))
              ],
            )),
        ElevatedButton(
            onPressed: _submitHandler, child: const Text("Add Transaction"))
      ],
    );
  }
}
