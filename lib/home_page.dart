import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/theme.dart';
import 'package:todolist_app/widgets/card_widget.dart';
import 'package:todolist_app/widgets/form_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List newList = listTask.where((element) => !element.isDone).toList();

  void addTask(String title, String subTitle, DateTime dateTime) {
    setState(() {
      final newTask = Task(title, subTitle, dateTime, false);
      listTask.add(newTask);
      updateData();
    });
  }

  void updateData() {
    newList = listTask.where((element) => !element.isDone).toList();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateFormat('dd/MMMM/yyyy').format(DateTime.now());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: size.width,
                height: size.height / 3,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff8d70fe),
                      Color(0xff2da9ef),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Todo App",
                      style: todoTitleStyle,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ListTile(
                      leading: Text(
                        now.split('/').first,
                        style: leadingTimeTextStyle,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          now.split('/')[1],
                          style: titleTimeTextStyle,
                        ),
                      ),
                      subtitle: Text(
                        now.split('/').last,
                        style: subtitleTimeTextStyle,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.height / 4.5,
              left: 15,
              child: Container(
                width: size.width - 32,
                height: size.height / 1.4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10),
                    right: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    itemBuilder: (context, index) {
                      return CardWidget(
                        task: newList[index],
                        handleRefresh: () {
                          setState(() {
                            listTask.remove(newList[index]);
                            print('remove ${newList[index]}');
                            updateData();
                          });
                        },
                      );
                    },
                    itemCount: newList.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 4,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: blue,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.list_alt_rounded),
              color: Colors.white,
              iconSize: 28,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.archive_rounded),
              color: Colors.white,
              iconSize: 28,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return FormWidget(
                addFunction: addTask,
              );
            },
          );
        },
        backgroundColor: blue,
        foregroundColor: card_white,
        child: const Icon(
          Icons.add,
          size: 36,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
