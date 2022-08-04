import 'dart:math';

import 'package:flutter/material.dart';
import './transactionCard.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  const TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: transactions.isEmpty
            ? LayoutBuilder(builder: ((context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: min(250, (constraints.maxHeight - 35) * 0.8),
                      child: Image.asset(
                        'assets/Images/noExpense.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const SizedBox(
                        height: 20, child: Text("No Expenditure!! 🎉"))
                  ],
                );
              }))
            : ListView.builder(
                itemBuilder: (context, index) => TransactionCard(
                    tx: transactions[index],
                    deleteTransaction: deleteTransaction),
                itemCount: transactions.length,
              ));
  }
}
