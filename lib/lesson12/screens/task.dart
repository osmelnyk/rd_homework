import 'package:flutter/material.dart';
import '../model/model.dart';
import '../screens/stream.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late Future<List<Task>> tasksFuture;
  List<Task> tasks = [];
  var mock = MockAPI();
  TextEditingController titleController = TextEditingController();
  late GlobalKey<AnimatedListState> listKey;

  // Set focus to the input text field
  FocusNode inputTextFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    listKey = GlobalKey<AnimatedListState>();
    tasksFuture = mock.getTasks();
    // Set focus to the input text field after the screen is rendered
    Future.delayed(
        const Duration(seconds: 1), () => inputTextFocus.requestFocus());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TaskStream(),
                ),
              );
            },
            icon: const Icon(Icons.preview),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: FutureBuilder<List<Task>>(
              future: tasksFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  tasks = snapshot.data!;
                  return AnimatedList(
                    key: listKey,
                    shrinkWrap: true,
                    initialItemCount: tasks.length,
                    itemBuilder: (_, index, animation) =>
                        _buildTaskItem(tasks[index], animation, index),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error fetching data'),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          // Container for the input text field and button
          textInputContainer(),
        ],
      ),
    );
  }

  Align textInputContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
        height: 60,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                focusNode: inputTextFocus,
                controller: titleController,
                decoration: const InputDecoration(
                    hintText: "Add Task...",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            floatingButton(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton floatingButton() {
    return FloatingActionButton(
      onPressed: () {
        if (titleController.text.isNotEmpty) {
          setState(() {
            tasks.insert(
                0,
                Task(
                    id: tasks.length + 1,
                    title: titleController.text,
                    status: Status.pending));
          });
          listKey.currentState!.insertItem(0);
          titleController.clear();
          inputTextFocus.requestFocus();
        }
      },
      backgroundColor: Colors.blue,
      elevation: 0,
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 18,
      ),
    );
  }

  // Build the task item with animation for AnimatedList
  SizeTransition _buildTaskItem(
      Task task, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: ListTile(
        key: ValueKey(tasks[index]),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.status == Status.completed
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _removeTask(index)),
        leading: Checkbox(
          value: task.status == Status.completed,
          onChanged: (bool? value) {
            setState(() {
              value!
                  ? task.status = Status.completed
                  : tasks[index].status = Status.pending;
            });
          },
        ),
      ),
    );
  }

  void _removeTask(int index) {
    listKey.currentState!.removeItem(
      index,
      (_, animation) => SizeTransition(
        sizeFactor: animation,
        child: const ListTile(),
      ),
      duration: const Duration(milliseconds: 300),
    );
    tasks.removeAt(index);
  }
}
