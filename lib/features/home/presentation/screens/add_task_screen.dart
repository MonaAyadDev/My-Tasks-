import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_tasks/features/home/presentation/cubit/home_cubit.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is AddTaskSuccess) {
            cubit.titleController.clear();
            cubit.desController.clear();
            cubit.deliveryDateController.clear();
            Navigator.pop(context);
          } else if (state is AddTaskError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('حصل خطأ أثناء إضافة التاسك')),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),

            child: Column(
              children: [
                TextField(
                  controller: cubit.titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: cubit.desController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: cubit.deliveryDateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: 'Date (YYYY-MM-DD)',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      cubit.deliveryDateController.text = DateFormat(
                        'yyyy-MM-dd',
                      ).format(pickedDate);
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    cubit.addTasks();
                  },
                  child: state is AddTaskLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Add Task'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
