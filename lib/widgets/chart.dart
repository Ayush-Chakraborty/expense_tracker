import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;
  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      var totalAmount = 0.0;
      var now = DateTime.now();
      var date = DateTime(now.year, now.month, now.day);
      var date1 = date.subtract(Duration(days: index));
      for (int i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == date1.day &&
            transactions[i].date.month == date1.month &&
            transactions[i].date.year == date1.year) {
          totalAmount += transactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(date1), 'amount': totalAmount};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactions.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element['amount'] as double));
  }

  const Chart({required this.transactions});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactions
              .map((e) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        day: e['day'] as String,
                        spending: e['amount'] as double,
                        totalSpending: totalSpending),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
