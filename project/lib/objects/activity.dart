class Activity {
  int id;
  String name;
  String amount;
  DateTime date;
  int state;

  Activity({this.id, this.name, this.amount, this.date, this.state});

  Map<String, dynamic> toMap() =>
      {"id": id, "name": name, "amount": amount, "date": date, "state": state};

  factory Activity.fromMap(Map<String, dynamic> json) => new Activity(
      id: json["id"],
      name: json["name"],
      amount: json["amount"],
      date: json["date"],
      state: json["state"]);
}
