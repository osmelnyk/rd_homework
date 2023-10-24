enum Status { pending, inProgress, completed }

class Task {
  final int id;
  final String title;
  Status status;

  Task({required this.id, required this.title, required this.status});
}

class MockAPI {
  List<Task> tasks = [
    Task(id: 1, title: "Вивчити Flutter", status: Status.pending),
    Task(id: 2, title: "Розробити додаток", status: Status.inProgress),
    Task(id: 3, title: "Провести тестування", status: Status.completed),
  ];

  Future<List<Task>> getTasks() async {
    await Future.delayed(const Duration(seconds: 2));
    return tasks;
  }

  Future<void> addTask({required String title}) async {
    await Future.delayed(const Duration(seconds: 1));
    tasks.add(Task(id: tasks.length + 1, title: title, status: Status.pending));
  }
}
