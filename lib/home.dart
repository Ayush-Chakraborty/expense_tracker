import 'package:flutter/material.dart';
import './widgets/transactionList.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import './widgets/transactionForm.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> _transactions = [];
  void _addTransaction(String title, double amount, DateTime date) {
    setState(() {
      _transactions.add(Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: date));
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: TransactionForm(_addTransaction));
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  // AppBar get appbar {
  //   return AppBar(
  //     title: Text("Expense Tracker"),
  //     actions: [
  //       Builder(
  //           builder: (ctx) => IconButton(
  //               onPressed: () => _startAddNewTransaction(ctx),
  //               icon: Icon(Icons.add)))
  //     ],
  //   );
  // }
  final appbar = AppBar(title: const Text("Expense Tracker"));
  var _showChart = true;

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final isLandscape = mediaquery.orientation == Orientation.landscape;

    return (Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape)
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Show chart'),
                    Switch(
                        value: _showChart,
                        onChanged: (value) {
                          setState(() {
                            _showChart = value;
                          });
                        })
                  ],
                ),
              ),
            if (isLandscape && _showChart)
              SizedBox(
                  height: (mediaquery.size.height -
                          appbar.preferredSize.height -
                          mediaquery.padding.top -
                          50) *
                      1,
                  width: mediaquery.size.width * 0.7,
                  child: Chart(transactions: _transactions)),
            if (isLandscape && !_showChart)
              SizedBox(
                  height: (mediaquery.size.height -
                          appbar.preferredSize.height -
                          mediaquery.padding.top -
                          50) *
                      1,
                  child: TransactionList(_transactions, _deleteTransaction)),
            if (!isLandscape)
              SizedBox(
                  height: (mediaquery.size.height -
                          appbar.preferredSize.height -
                          mediaquery.padding.top) *
                      0.3,
                  child: Chart(transactions: _transactions)),
            if (!isLandscape)
              SizedBox(
                  height: (mediaquery.size.height -
                          appbar.preferredSize.height -
                          mediaquery.padding.top) *
                      0.7,
                  child: TransactionList(_transactions, _deleteTransaction))
          ],
        ),
      ),
      floatingActionButton: Builder(
          builder: (ctx) => FloatingActionButton(
              onPressed: () => _startAddNewTransaction(ctx),
              child: const Icon(Icons.add))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    ));
  }
}
