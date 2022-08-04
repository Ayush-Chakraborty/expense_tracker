import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction tx;
  final Function deleteTransaction;
  const TransactionCard({required this.tx, required this.deleteTransaction});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(35)),
            padding: const EdgeInsets.all(3),
            child: FittedBox(
              child: Text('\$ ${tx.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  tx.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    DateFormat('dd-MMM-yyyy').format(tx.date),
                    style: const TextStyle(color: Colors.grey),
                  ))
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? IconButton(
                        onPressed: () => deleteTransaction(tx.id),
                        icon: const Icon(Icons.delete_rounded),
                        color: Theme.of(context).errorColor,
                      )
                    : TextButton.icon(
                        onPressed: () => deleteTransaction(tx.id),
                        icon: const Icon(Icons.delete_rounded),
                        label: const Text('Delete'),
                        style: TextButton.styleFrom(
                          primary: Theme.of(context).errorColor,
                        ),
                        // color: Theme.of(context).errorColor,
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
