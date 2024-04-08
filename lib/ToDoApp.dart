import 'package:flutter/material.dart';
import 'package:full_to_do_app_myself/model/To_do_model_class.dart';
import 'package:intl/intl.dart';
//import 'package:full_to_do_app_myself/Showbottomsheet.dart';
//import 'package:full_to_do_app_myself/democontainer.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key, required Row child});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  List<Color> colors = [
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromRGBO(250, 249, 232, 1),
    const Color.fromRGBO(250, 232, 250, 1),
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromRGBO(250, 249, 232, 1),
  ];
  List<ToDoModelClass> todoList = [
    ToDoModelClass(
      title: "Take notes",
      description: "Take notes of every app you write ",
      date: "10 July 2023",
    ),
    ToDoModelClass(
      title: "Arrange Meeting ",
      description: "Meet the backend team ",
      date: "10 July 2023",
    ),
  ];
  void submit(bool doedit, [ToDoModelClass? toDoModelObj]) {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (!doedit) {
        setState(() {
          todoList.add(
            ToDoModelClass(
              title: titleController.text.trim(),
              description: descriptionController.text.trim(),
              date: dateController.text.trim(),
            ),
          );
        });
      } else {
        setState(() {
          toDoModelObj!.date = dateController.text.trim();
          toDoModelObj.title = titleController.text.trim();
          toDoModelObj.description = descriptionController.text.trim();
        });
      }
    }
    clearController();
  }

  ///TO CLEAR ALL THE TEXT EDITING CONTROLLERS
  void clearController() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  void editTask(ToDoModelClass toDoModelObj) {
//ASSIGN THE TEXT EDITING CONTROLLERS WITH THE TEXT VALUES AND THEN OPEN THE BOTTOM SHEET
    titleController.text = toDoModelObj.title;
    descriptionController.text = toDoModelObj.description;
    dateController.text = toDoModelObj.date;
    showBottomSheet(true, toDoModelObj);
  }

  void removeTasks(ToDoModelClass toDoModelObj) {
    setState(() {
      todoList.remove(toDoModelObj);
    });
  }

  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  void showBottomSheet(bool doedit, [ToDoModelClass? toDoModelObj]) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,

              ///TO AVOID THE KEYBOARD OVERLAP THE SCREEN
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create Task",
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Title",
                          style: GoogleFonts.quicksand(
                            color: const Color.fromRGBO(0, 139, 148, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(0, 139, 148, 1),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.purpleAccent),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Description",
                          style: GoogleFonts.quicksand(
                            color: const Color.fromRGBO(0, 139, 148, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        TextField(
                          controller: descriptionController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(0, 139, 148, 1),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.purpleAccent),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Date",
                          style: GoogleFonts.quicksand(
                            color: const Color.fromRGBO(0, 139, 148, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        TextField(
                            controller: dateController,
                            //  readOnly: true,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.date_range_rounded),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(0, 139, 148, 1),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.purpleAccent),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onTap: () async {
                              DateTime? pickeddate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2025),
                              );
                              String formattedDate =
                                  DateFormat.yMMMd().format(pickeddate!);
                              setState(() {
                                dateController.text = formattedDate;
                              });
                            }),
                      ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: 300,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
                      ),
                      onPressed: () {
                        doedit ? submit(doedit, toDoModelObj) : submit(doedit);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Submit",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To-do list",
          style: GoogleFonts.quicksand(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: ((context, index) {
            return Container(
              margin: const EdgeInsets.only(left: 15, top: 30, right: 15),
              height: 118,
              width: 330,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: colors[index],
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 23, left: 10, bottom: 10),
                        padding: const EdgeInsets.only(
                            top: 16.92, bottom: 16, left: 14.4, right: 13.8),
                        height: 52,
                        width: 52,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            shape: BoxShape.circle),
                        child: const SizedBox(
                          height: 19.7,
                          width: 23.29,
                          //  child: Image.asset(""),
                        ),
                      ),
                      Container(
                        height: 16,
                        width: 62,
                        margin: const EdgeInsets.only(left: 12, bottom: 10),
                        child: Text(
                          todoList[index].date,
                          style: GoogleFonts.quicksand(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: const Color.fromARGB(255, 15, 11, 11),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 15,
                        width: 280,
                        margin:
                            const EdgeInsets.only(left: 15, right: 10, top: 10),
                        child: Text(
                          todoList[index].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              height: 1.5),
                        ),
                      ),
                      Container(
                        height: 44,
                        width: 280,
                        margin:
                            const EdgeInsets.only(top: 10, left: 15, right: 10),
                        child: Text(
                          todoList[index].description,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              height: 1.4),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 13,
                            width: 13,
                            color: colors[index],
                            margin: const EdgeInsets.only(left: 240, top: 10),
                            child: GestureDetector(
                              onTap: () {
                                editTask(todoList[index]);
                              },
                              child: const Icon(
                                Icons.edit,
                                size: 13,
                                color: Color.fromRGBO(0, 139, 148, 1),
                              ),
                            ),
                          ),
                          Container(
                            height: 10,
                            width: 13,
                            color: colors[index],
                            margin: const EdgeInsets.only(top: 10, left: 19),
                            child: GestureDetector(
                              onTap: () {
                                removeTasks(todoList[index]);
                              },
                              child: const Icon(
                                Icons.delete_outline,
                                size: 13,
                                color: Color.fromRGBO(0, 139, 148, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
        shape: const CircleBorder(),
        onPressed: () {
          showBottomSheet(false
              // context: context,
              // builder: (context) {
              //   return const Showbottomsheet();
              // }
              );
        },
        child: const Icon(
          Icons.add,
          size: 46,

          color: Colors.white,
          // color: Color.fromRGBO(r, g, b, opacity),
        ),
      ),
    );
  }
}
