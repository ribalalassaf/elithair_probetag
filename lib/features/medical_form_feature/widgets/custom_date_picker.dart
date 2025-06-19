import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime? startDate, DateTime? endDate)? onRangeChange;
  final Function(DateTime? date)? onDateChange;
  final DateRangePickerSelectionMode selectionMode;
  final bool withSaveButton;
  final EdgeInsetsGeometry? padding;
  final DateTime? initialDate;
  final bool enablePastDates;
  const CustomDatePicker({
    super.key,
    this.onRangeChange,
    this.onDateChange,
    required this.selectionMode,
    this.withSaveButton = true,
    this.padding,
    this.initialDate,
    this.enablePastDates = false,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateRangePickerController _datePickerController;

  @override
  void initState() {
    _datePickerController = DateRangePickerController();

    super.initState();
  }

  @override
  void dispose() {
    _datePickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(16),
      child: ListView(
        shrinkWrap: true,
        children: [
          const Divider(color: Colors.black),
          SfDateRangePicker(
            showNavigationArrow: true,
            controller: _datePickerController,
            selectionMode: widget.selectionMode,
            initialSelectedDate: widget.initialDate,
            backgroundColor: Colors.white,

            onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
              if (widget.onRangeChange != null) {
                widget.onRangeChange!(
                  (dateRangePickerSelectionChangedArgs.value as PickerDateRange).startDate,
                  (dateRangePickerSelectionChangedArgs.value as PickerDateRange).endDate,
                );
              }
              if (widget.onDateChange != null) {
                widget.onDateChange!((dateRangePickerSelectionChangedArgs.value as DateTime));
                if (!widget.withSaveButton) {
                  context.maybePop();
                }
              }
            },
            onViewChanged: (DateRangePickerViewChangedArgs args) {
              if (args.view == DateRangePickerView.century) {
                Future.microtask(() {
                  _datePickerController.view = DateRangePickerView.decade;
                });
              }
            },
            headerHeight: 35,
            enablePastDates: widget.enablePastDates,
            headerStyle: DateRangePickerHeaderStyle(textAlign: TextAlign.center, backgroundColor: Colors.white),
            monthViewSettings: DateRangePickerMonthViewSettings(
              viewHeaderStyle: DateRangePickerViewHeaderStyle(),
              showTrailingAndLeadingDates: true,
            ),
            rangeSelectionColor: const Color(0xFFEFEDF2),
          ),
        ],
      ),
    );
  }
}
