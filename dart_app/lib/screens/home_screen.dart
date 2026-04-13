import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List'), centerTitle: true),
      body: Column(
        children: [
          // 🔹 Seção: Nova tarefa
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nova tarefa',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Insira o nome da tarefa',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Salvar tarefa'),
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        ref
                            .read(taskProvider.notifier)
                            .addTask(controller.text);
                        controller.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Lista de tarefas
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.completed
                            ? TextDecoration.lineThrough
                            : null,
                        color: task.completed ? Colors.grey : Colors.black,
                      ),
                    ),
                    leading: Checkbox(
                      value: task.completed,
                      onChanged: (_) {
                        ref.read(taskProvider.notifier).toggleTask(index);
                      },
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _showEditDialog(context, ref, index, task.title);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            ref.read(taskProvider.notifier).removeTask(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _showEditDialog(
  BuildContext context,
  WidgetRef ref,
  int index,
  String currentTitle,
) {
  final controller = TextEditingController(text: currentTitle);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Editar tarefa'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Título da tarefa'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref
                    .read(taskProvider.notifier)
                    .editTask(index, controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      );
    },
  );
}
