import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tasks/features/home/presentation/cubit/home_cubit.dart';
import 'package:my_tasks/features/home/presentation/widgets/task_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            current is HomeLoading ||
            current is HomeSuccess ||
            current is HomeError,
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();

          if (state is HomeLoading || state is HomeInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeSuccess) {
            if (state.data.isEmpty) {
              return const Center(child: Text('No tasks yet'));
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.data.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return TaskItemWidget(
                  task: state.data[index],
                  titlecontroller: cubit.titleController,
                  descontroller: cubit.desController,
                );
              },
            );
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
