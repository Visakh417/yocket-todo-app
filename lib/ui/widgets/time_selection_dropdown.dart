import 'package:flutter/material.dart';

class TimeSelectionDropDown extends StatelessWidget {
  final String label;
  final List<int> options;
  final int selectedPosition;
  final Function onChange;
  const TimeSelectionDropDown(
    this.label,
    this.options,
    this.selectedPosition, this.onChange,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label),
        Expanded(
          child: DropdownButton<int>(
            value: options[selectedPosition],
            icon: const Icon(
              Icons.arrow_drop_down_outlined,
              color: Colors.blue,
            ),
            elevation: 16,
            style: const TextStyle(
              color: Color(0xff888888),
            ),
            underline: Container(
              height: 0,
              color: Colors.transparent,
            ),
            onChanged: (int? newValue) {
              if (newValue == null) return;
              onChange(options.indexOf(newValue));
            },
            items: options.map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(
                  "$value",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.blue),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
