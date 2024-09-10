class MarksBySubjectModel {
  String? errorMessage;
  List<Lessons>? lessons;
  int? numberMissedLessons;

  MarksBySubjectModel(
      {this.errorMessage, this.lessons, this.numberMissedLessons});

  MarksBySubjectModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['error_message'];
    if (json['lessons'] != null) {
      lessons = <Lessons>[];
      json['lessons'].forEach((v) {
        lessons!.add(Lessons.fromJson(v));
      });
    }
    numberMissedLessons = json['number_missed_lessons'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_message'] = errorMessage;
    if (lessons != null) {
      data['lessons'] = lessons!.map((v) => v.toJson()).toList();
    }
    data['number_missed_lessons'] = numberMissedLessons;
    return data;
  }
}

class Lessons {
  String? comment;
  String? lessonDate;
  String? lessonId;
  String? lessonType;
  String? mark;
  String? subject;

  Lessons(
      {this.comment,
      this.lessonDate,
      this.lessonId,
      this.lessonType,
      this.mark,
      this.subject});

  Lessons.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    lessonDate = json['lesson_date'];
    lessonId = json['lesson_id'];
    lessonType = json['lesson_type'];
    mark = json['mark'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = comment;
    data['lesson_date'] = lessonDate;
    data['lesson_id'] = lessonId;
    data['lesson_type'] = lessonType;
    data['mark'] = mark;
    data['subject'] = subject;
    return data;
  }
}
