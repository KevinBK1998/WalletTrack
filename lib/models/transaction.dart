class Transaction {
  final String id;
  final double amount;
  final String title;
  final String category;
  final DateTime date;

  Transaction(
      {required this.id,
      required this.amount,
      required this.title,
      required this.category,
      required this.date});
}
