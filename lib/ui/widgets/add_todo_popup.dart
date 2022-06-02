import 'package:flutter/material.dart';
import 'package:todo/database/models/todo_model.dart';
import 'package:todo/ui/widgets/time_selection_dropdown.dart';
import 'package:todo/utils/general_util.dart';

class AddTodoPopupWidget extends StatefulWidget {
  const AddTodoPopupWidget({Key? key}) : super(key: key);

  @override
  State<AddTodoPopupWidget> createState() => _AddTodoPopupWidgetState();
}

class _AddTodoPopupWidgetState extends State<AddTodoPopupWidget> {
  final TextEditingController titleTxtCntlr = TextEditingController();
  final TextEditingController descriptionTxtCntlr = TextEditingController();
  int selectedMinutes = 10, selectedSecond = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(
                    context, TodoModel(title: "My Task", duration: 3));
              },
              child: const Text("Add ToDo")),
          TextField(
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            maxLines: 4,
            minLines: 1,
            decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Title"),
            controller: titleTxtCntlr,
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            cursorColor: Colors.black,
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            minLines: 1,
            decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Description"),
            controller: titleTxtCntlr,
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: TimeSelectionDropDown(
                        "Minutes",
                        GeneralUtil().getNumberArray(11),
                        selectedMinutes, (int value) {
                  setState(() {
                    selectedMinutes = value;
                    if (selectedMinutes == 10) {
                      selectedSecond = 0;

                    }
                  });
                })),
                Expanded(
                    child: TimeSelectionDropDown(
                        "Seconds",
                        selectedMinutes == 10 ? [0] : GeneralUtil().getNumberArray(60),
                        selectedMinutes == 10 ? 0 : selectedSecond, (int value) {
                  setState(() {
                    selectedSecond = value;
                  });
                }))
              ],
            ),
          )
        ],
      ),
    );
  }
}
