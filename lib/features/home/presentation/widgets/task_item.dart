import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tasks/core/widgets/main_form_field.dart';
import 'package:my_tasks/features/home/data/models/home_response/datum.dart';
import 'package:my_tasks/features/home/presentation/cubit/home_cubit.dart';

class TaskItemWidget extends StatelessWidget {
  final Datum task;
  final TextEditingController titlecontroller;
  final TextEditingController descontroller;

  const TaskItemWidget({
    super.key,
    required this.task,
    required this.titlecontroller,
    required this.descontroller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    task.title ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    titlecontroller.text = task.title ?? '';
                    descontroller.text = task.description ?? '';

                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        final cubit = context.read<HomeCubit>();
                        return BlocProvider.value(
                          value: cubit,
                          child: BlocConsumer<HomeCubit, HomeState>(
                            listener: (context, state) {
                              if (state is UpdateTaskSuccess) {
                                Navigator.pop(dialogContext);
                              }
                            },
                            builder: (context, state) {
                              final isLoading = state is UpdateTaskLoading;
                              return AlertDialog(
                                title: const Text("Edit Task"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    MainFormField(controller: titlecontroller),
                                    const SizedBox(height: 20),
                                    MainFormField(controller: descontroller),
                                    const SizedBox(height: 30),
                                    ElevatedButton(
                                      onPressed: isLoading
                                          ? null
                                          : () {
                                              context.read<HomeCubit>().updateTasks(
                                                    id: task.taskId ?? 0,
                                                  );
                                            },
                                      child: isLoading
                                          ? const SizedBox(
                                              height: 18,
                                              width: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Text("Edit"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              task.description ?? '',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(task.status ?? ''),
                  backgroundColor: Colors.blue.shade50,
                  visualDensity: VisualDensity.compact,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      (task.deliveryDate ?? '').split(' ').first,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}