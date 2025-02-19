class Task {
  final int? id;
  final String title;
  final String description;
  final bool isComplete;

  Task(
      {this.id,
      required this.title,
      required this.description,
      this.isComplete = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isComplete': isComplete ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isComplete: map['isComplete'] == 1,
    );
  }
}
