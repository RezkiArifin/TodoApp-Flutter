import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/theme.dart';

import '../models/task.dart';

class CardWidget extends StatefulWidget {
  final Function handleRefresh;
  final Task task;
  const CardWidget({
    Key? key,
    required this.handleRefresh,
    required this.task,
  }) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          final newTask = widget.task.copyWith(isDone: true);
          listTask.remove(widget.task);
          listTask.add(newTask);
          widget.handleRefresh;
        }),
        children: [
          const SizedBox(
            width: 2,
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(16),
            onPressed: (_) {
              final newTask = widget.task.copyWith(isDone: true);
              listTask.remove(widget.task);
              listTask.add(newTask);
              widget.handleRefresh();
            },
            backgroundColor: blue,
            foregroundColor: card_white,
            icon: Icons.done_outline_rounded,
            label: 'Done',
          ),
          const SizedBox(
            width: 2,
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(16),
            onPressed: (_) {
              widget.handleRefresh();
            },
            backgroundColor: red,
            foregroundColor: card_white,
            icon: Icons.delete,
            label: 'Remove',
          ),
        ],
      ),
      child: Card(
        elevation: 8,
        shadowColor: blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          minLeadingWidth: widget.task.isDone ? 0 : 2,
          leading: widget.task.isDone
              ? const SizedBox()
              : Container(
                  width: 2,
                  color: blue,
                ),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              widget.task.taskName,
              style: cardStyle,
            ),
          ),
          subtitle: Text(
            widget.task.description,
            style: cardSubStyle,
          ),
          trailing: Text(
            widget.task.isDone
                ? 'Done'
                : DateFormat('hh:mm a').format(widget.task.taskTime),
            style: cardTrailingStyle,
          ),
        ),
      ),
    );
  }
}
