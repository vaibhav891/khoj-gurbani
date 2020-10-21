class UserSetings {
  final int id;
  final int val;

  UserSetings({
    this.id,
    this.val,
  });

  factory UserSetings.fromMap(Map<String, dynamic> json) => new UserSetings(
        id: json["id"],
        val: json["val"],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'val': val,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'UserSetings{id: $id, val: $val}';
  }
}
