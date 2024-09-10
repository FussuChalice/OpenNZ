class MarksByPeriodModel {
  String? errorMessage;
  Missed? missed;
  List<Subjects>? subjects;

  MarksByPeriodModel({this.errorMessage, this.missed, this.subjects});

  MarksByPeriodModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['error_message'];
    missed = json['missed'] != null ? Missed.fromJson(json['missed']) : null;
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_message'] = errorMessage;
    if (missed != null) {
      data['missed'] = missed!.toJson();
    }
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Missed {
  int? days;
  int? lessons;

  Missed({this.days, this.lessons});

  Missed.fromJson(Map<String, dynamic> json) {
    days = json['days'];
    lessons = json['lessons'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['days'] = days;
    data['lessons'] = lessons;
    return data;
  }
}

class Subjects {
  List<String>? marks;
  String? subjectId;
  String? subjectName;

  Subjects({this.marks, this.subjectId, this.subjectName});

  Subjects.fromJson(Map<String, dynamic> json) {
    marks = json['marks'].cast<String>();
    subjectId = json['subject_id'];
    subjectName = json['subject_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['marks'] = marks;
    data['subject_id'] = subjectId;
    data['subject_name'] = subjectName;
    return data;
  }
}
