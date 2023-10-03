class ExpenseModel {
  String uid;
  String id;
  String title;
  String category;
  double amount;
  DateTime date;
  String receipt;

  ExpenseModel({
    required this.uid,
    required this.id,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.receipt,
  });
  factory ExpenseModel.fromJson(Map<String, dynamic> map) {
    return ExpenseModel(
        uid: map['uid'],
        id: map['id'],
        title: map['title'],
        category: map['category'],
        amount: map['amount'],
        date: map['date'].toDate(),
        receipt: map['receipt']);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'id': id,
      'title': title,
      'category': category,
      'amount': amount,
      'date': date,
      'receipt': receipt,
    };
  }
}
