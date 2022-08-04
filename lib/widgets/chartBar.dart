import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double spending, totalSpending;
  final String day;
  const ChartBar(
      {required this.day, required this.spending, required this.totalSpending});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return (Column(
        children: [
          SizedBox(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(child: Text(spending.toStringAsFixed(1)))),
          Container(
            margin:
                EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.05),
            height: constraints.maxHeight * 0.7,
            width: 15,
            child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(10))),
              FractionallySizedBox(
                heightFactor:
                    totalSpending == 0 ? 0.0 : spending / totalSpending,
                child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10))),
              )
            ]),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.1,
            child: Text(day),
          )
        ],
      ));
    });
  }
}
