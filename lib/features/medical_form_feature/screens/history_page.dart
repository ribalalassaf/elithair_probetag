import 'package:auto_route/auto_route.dart';
import 'package:elithair_probetag/config/injectable.dart';
import 'package:elithair_probetag/config/router/router.gr.dart';
import 'package:elithair_probetag/features/medical_form_feature/business_logic/controller/records_cubit/records_cubit.dart';
import 'package:elithair_probetag/features/medical_form_feature/model/record_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

@RoutePage()
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RecordsCubit>()..getRecords(),
      child: Scaffold(
        appBar: AppBar(title: Text("Records History")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushRoute(FormRoute());
          },
          child: Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<RecordsCubit, RecordsState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => Text("Error loading records"),
                inProgress: () => Center(child: CircularProgressIndicator()),
                recordsSuccess: (records) => ListView.separated(
                  itemCount: records.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return RecordListItem(recordModel: records.elementAt(index));
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class RecordListItem extends StatelessWidget {
  final RecordModel recordModel;
  const RecordListItem({super.key, required this.recordModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recordModel.priorTransplant! ? "Did a prior transplant" : "No prior transplant",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(recordModel.conditions!.join(', '), style: TextStyle(fontWeight: FontWeight.w500)),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                DateFormat("yyyy.MM.dd").format(recordModel.submittedAt!),
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
