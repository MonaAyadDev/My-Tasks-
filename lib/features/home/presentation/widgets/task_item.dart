import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_tasks/core/routes/routes.dart';
import 'package:my_tasks/core/widgets/main_form_field.dart';
import 'package:my_tasks/features/home/data/models/home_response/datum.dart';
import 'package:my_tasks/features/home/presentation/cubit/home_cubit.dart';

class TaskItemWidget extends StatelessWidget {
  final RequestModel task;

  const TaskItemWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.showScreen,
              arguments: task.taskId,
            );
          },
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
                      final cubit = context.read<HomeCubit>();

                      cubit.titleController.text = task.title ?? '';
                      cubit.desController.text = task.description ?? '';
                      cubit.deliveryDateController.text =
                          (task.deliveryDate ?? '').split(' ').first;

                      showDialog(
                        context: context,
                        builder: (dialogContext) {
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
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        MainFormField(
                                          controller: cubit.titleController,
                                        ),
                                        const SizedBox(height: 20),
                                        MainFormField(
                                          controller: cubit.desController,
                                        ),
                                        const SizedBox(height: 20),
                                        TextField(
                                          controller:
                                              cubit.deliveryDateController,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            hintText: 'Date (YYYY-MM-DD)',
                                            border: OutlineInputBorder(),
                                            suffixIcon:
                                                Icon(Icons.calendar_today),
                                          ),
                                          onTap: () async {
                                            final pickedDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2100),
                                            );

                                            if (pickedDate != null) {
                                              cubit.deliveryDateController
                                                  .text = DateFormat(
                                                      'yyyy-MM-dd')
                                                  .format(pickedDate);
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 30),
                                        ElevatedButton(
                                          onPressed: isLoading
                                              ? null
                                              : () {
                                                  cubit.updateTasks(
                                                    taskId: task.taskId ?? 0,
                                                    status: task.status,
                                                    priority: task.priority,
                                                  );
                                                },
                                          child: isLoading
                                              ? const SizedBox(
                                                  height: 18,
                                                  width: 18,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                  ),
                                                )
                                              : const Text("Edit"),
                                        ),
                                      ],
                                    ),
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
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}