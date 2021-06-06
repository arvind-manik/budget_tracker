import 'package:budget_tracker/constants.dart';
import 'package:budget_tracker/models/expense_entry.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpenseChart extends StatelessWidget {
  final List<ExpenseEntry> expenseEntries;
  const ExpenseChart({Key? key, required this.expenseEntries})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expenses = <String, double>{};
    expenseEntries.forEach((entry) {
      expenses.update(entry.getCategory(), (value) => value + entry.getPrice(),
          ifAbsent: () => entry.getPrice());
    });

    return Card(
        margin: BTUI.edge8,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BTUI.radius10),
        child: Container(
            decoration:
                BoxDecoration(color: Theme.of(context).primaryColorLight),
            padding: BTUI.edge16,
            height: BTUI.PIE_CHART_HEIGHT,
            child: Column(children: [
              Expanded(
                  child: PieChart(PieChartData(
                      sections: expenses
                          .map((category, totalExpense) => MapEntry(
                              category,
                              PieChartSectionData(
                                  color: ExpenseEntry.getBGColor(category),
                                  radius: BTUI.PIE_CHART_RADIUS,
                                  title: '₹${totalExpense.toStringAsFixed(2)}',
                                  titleStyle: TextStyle(
                                      fontSize: BTUI.PIE_CHART_FONT_SIZE,
                                      color:
                                          ExpenseEntry.getTextColor(category)),
                                  value: totalExpense)))
                          .values
                          .toList(),
                      sectionsSpace: BTUI.PIE_CHART_SPACE))),
              SizedBox(height: BTUI.SECTION_MARGIN),
              Wrap(
                spacing: BTUI.LEGEND_SPACING,
                runSpacing: BTUI.LEGEND_SPACING,
                children: expenses.keys
                    .map((each) => _Legend(
                        color: ExpenseEntry.getBGColor(each), name: each))
                    .toList(),
              )
            ])));
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String name;

  const _Legend({Key? key, required this.color, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            height: BTUI.LEGEND_SIZE,
            width: BTUI.LEGEND_SIZE,
            color: this.color),
        SizedBox(width: BTUI.PIE_CHART_SPACE),
        Text(name, style: const TextStyle(fontWeight: FontWeight.w500))
      ],
    );
  }
}
