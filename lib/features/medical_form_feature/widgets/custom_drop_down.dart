import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatefulWidget {
  final List<String>? displayValues;
  final List<T>? values;
  final T? initialValue;
  final String? hintText;
  final void Function(T? value) onChange;

  const CustomDropDown({
    super.key,
    required this.values,
    required this.initialValue,
    required this.onChange,
    this.displayValues,
    this.hintText,
  });

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  late List<T> items;
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    items = widget.values ?? [];
    selectedValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant CustomDropDown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        selectedValue = widget.initialValue;
      });
    }

    if (widget.values != oldWidget.values) {
      setState(() {
        items = widget.values!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
          widget.onChange(value);
        },
        items: List.generate(items.length, (index) {
          final value = items[index];
          final display = widget.displayValues != null && widget.displayValues!.length > index
              ? widget.displayValues![index]
              : value.toString();
          return DropdownMenuItem<T>(
            value: value,
            child: Text(display, overflow: TextOverflow.visible),
          );
        }),
        isExpanded: true,
        hint: selectedValue != null
            ? Text(
                widget.displayValues != null
                    ? widget.displayValues![items.indexOf(selectedValue!)]
                    : selectedValue.toString(),
                overflow: TextOverflow.ellipsis,
              )
            : widget.hintText != null
            ? Text(widget.hintText!, overflow: TextOverflow.ellipsis)
            : null,
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black26),
          ),
        ),
        iconStyleData: const IconStyleData(iconSize: 20, icon: Icon(Icons.keyboard_arrow_down_rounded)),
        dropdownStyleData: DropdownStyleData(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}

class MultiSelectDropdown extends StatefulWidget {
  final List<String> values;
  final List<String> initialSelected;
  final String? hintText;
  final void Function(List<String>) onChanged;

  const MultiSelectDropdown({
    super.key,
    required this.values,
    required this.initialSelected,
    required this.onChanged,
    this.hintText,
  });

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  late List<String> selectedValues;

  @override
  void initState() {
    super.initState();
    selectedValues = List.from(widget.initialSelected);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        customButton: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              selectedValues.isEmpty ? (widget.hintText ?? 'Select') : selectedValues.join(', '),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 300,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        ),
        iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down_rounded)),
        items: widget.values.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            enabled: false,
            child: StatefulBuilder(
              builder: (context, setState) {
                return Row(
                  children: [
                    Checkbox(
                      value: selectedValues.contains(item),
                      onChanged: (bool? checked) {
                        final newValue = checked ?? false;
                        setState(() {
                          if (newValue) {
                            selectedValues.add(item);
                          } else {
                            selectedValues.remove(item);
                          }
                        });

                        this.setState(() {}); // Update button text
                        widget.onChanged(List.from(selectedValues));
                      },
                    ),
                    Text(item),
                  ],
                );
              },
            ),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
