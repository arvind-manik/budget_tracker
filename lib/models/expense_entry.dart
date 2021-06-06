class ExpenseEntry {
  final String _name;
  final String _category;
  final double _price;
  final DateTime _date;

  const ExpenseEntry(
      {required name,
      required category,
      required price,
      required DateTime date})
      : _name = name,
        _category = category,
        _price = price,
        _date = date;

  factory ExpenseEntry.fromMap(Map<String, dynamic> entryData) {
    final properties = entryData['properties'] as Map<String, dynamic>;
    final dateString = properties['Date']?['date']?['start'] ?? '?';

    return ExpenseEntry(
        name: properties['Name']?['title']?[0]?['plain_text'] ?? '?',
        category: properties['Category']?['select']?['name'] ?? 'Unknown',
        price: (properties['Price']?['number'] ?? 0).asDouble(),
        date: dateString != null ? DateTime.parse(dateString) : DateTime.now());
  }
}
