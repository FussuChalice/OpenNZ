// To parse this JSON data, do
//
//     final studentPeriodModel = studentPeriodModelFromJson(jsonString);

import 'dart:convert';

StudentPeriodModel studentPeriodModelFromJson(String str) =>
    StudentPeriodModel.fromJson(json.decode(str));

String studentPeriodModelToJson(StudentPeriodModel data) =>
    json.encode(data.toJson());

class StudentPeriodModel {
  DateTime endDate;
  DateTime startDate;
  String studentId;

  StudentPeriodModel({
    required this.endDate,
    required this.startDate,
    required this.studentId,
  });

  factory StudentPeriodModel.fromJson(Map<String, dynamic> json) =>
      StudentPeriodModel(
        endDate: DateTime.parse(json["end_date"]),
        startDate: DateTime.parse(json["start_date"]),
        studentId: json["student_id"],
      );

  Map<String, dynamic> toJson() => {
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "student_id": studentId,
      };
}
