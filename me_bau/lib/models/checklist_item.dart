class ChecklistItem {
  String name;
  bool isCompleted;
  String? notes;

  ChecklistItem({required this.name, this.isCompleted = false, this.notes});

  // Chuyển đổi từ JSON Map sang ChecklistItem object
  factory ChecklistItem.fromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      name: json['name'],
      isCompleted: json['isCompleted'] ?? false,
      notes: json['notes'],
    );
  }

  // Chuyển đổi từ ChecklistItem object sang JSON Map
  Map<String, dynamic> toJson() {
    return {'name': name, 'isCompleted': isCompleted, 'notes': notes};
  }
}
