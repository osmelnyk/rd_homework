import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../model/model.dart';

class TaskStream extends StatefulWidget {
  const TaskStream({super.key});

  @override
  State<StatefulWidget> createState() => _TaskStreamState();
}

class _TaskStreamState extends State<TaskStream> {
  late StreamController<List<Task>> _streamController;
  List<Task> tasks = [];
  late Timer _timer;
  var mock = MockAPI();
  Map<String, int> countTaskStatuses = {};

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<Task>>.broadcast();
    _getTasks();
  }

  // Calculate the number of tasks in each status usin Iasolates
  void _calculateTasksStatuses() async {
    countTaskStatuses = await compute(_calculate, tasks);
  }

  // Calculate the number of tasks in each status
  Map<String, int> _calculate(List<Task> tasks) {
    return {
      Status.pending.name:
          tasks.where((task) => task.status == Status.pending).length,
      Status.inProgress.name:
          tasks.where((task) => task.status == Status.inProgress).length,
      Status.completed.name:
          tasks.where((task) => task.status == Status.completed).length,
    };
  }

  void _getTasks() async {
    // Get tasks from the mock API
    tasks = await mock.getTasks();
    _streamController.sink.add(tasks);
    _calculateTasksStatuses();
    _updateTasksRandomly();
  }

  void _updateTasksRandomly() {
    // Add, remove, or update tasks randomly
    _timer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      final random = Random();
      final randomAction = random.nextInt(3);

      switch (randomAction) {
        case 0:
          if (tasks.isNotEmpty) {
            final index = random.nextInt(tasks.length);
            setState(() {
              tasks.removeAt(index);
            });
            break;
          }
        case 1:
          if (tasks.isNotEmpty) {
            final index = random.nextInt(tasks.length);
            setState(() {
              tasks[index].status =
                  Status.values[Random().nextInt(Status.values.length)];
            });
          }
          break;
        case 2:
          final id = tasks.length + 1;
          setState(() {
            tasks.add(Task(id: id, title: 'Task $id', status: Status.pending));
          });
          break;
      }
      _calculateTasksStatuses();
      if (mounted) _streamController.sink.add(tasks);
    });
  }

  @override
  void dispose() {
    _streamController.close();
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Task>>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(slivers: <Widget>[
              sliverAppBar(),
              sliverAppList(snapshot),
            ]);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  SliverAppBar sliverAppBar() {
    return SliverAppBar(
        title: const Text('Tasks Stream'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Container(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Pending: ${countTaskStatuses[Status.pending.name]}',
                  style: const TextStyle(
                    // color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  'In Progress: ${countTaskStatuses[Status.inProgress.name]}',
                  style: const TextStyle(
                    // color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  'Completed: ${countTaskStatuses[Status.completed.name]}',
                  style: const TextStyle(
                    // color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

SliverList sliverAppList(AsyncSnapshot<List<Task>> snapshot) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        final task = snapshot.data![index];
        return ListTile(
          title: Text(task.title),
          subtitle: Text('Status: ${task.status.name}'),
        );
      },
      childCount: snapshot.data!.length,
    ),
  );
}
