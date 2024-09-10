// To parse this JSON data, do
//
//     final StudentPeriodWithSubjectModel = StudentPeriodWithSubjectModelFromJson(jsonString);

import 'dart:convert';

StudentPeriodWithSubjectModel studentPeriodWithSubjectModelFromJson(
        String str) =>
    StudentPeriodWithSubjectModel.fromJson(json.decode(str));

String studentPeriodWithSubjectModelToJson(
        StudentPeriodWithSubjectModel data) =>
    json.encode(data.toJson());

class StudentPeriodWithSubjectModel {
  DateTime endDate;
  DateTime startDate;
  String studentId;
  String subjectId;

  StudentPeriodWithSubjectModel(
      {required this.endDate,
      required this.startDate,
      required this.studentId,
      required this.subjectId});

  factory StudentPeriodWithSubjectModel.fromJson(Map<String, dynamic> json) =>
      StudentPeriodWithSubjectModel(
        endDate: DateTime.parse(json["end_date"]),
        startDate: DateTime.parse(json["start_date"]),
        studentId: json["student_id"],
        subjectId: json["subject_id"],
      );

  Map<String, dynamic> toJson() => {
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "student_id": studentId,
        "subject_id": subjectId,
      };
}
