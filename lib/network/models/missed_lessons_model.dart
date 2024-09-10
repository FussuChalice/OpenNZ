class MissedLessonsModel {
  String? errorMessage;
  List<MissedLessons>? missedLessons;

  MissedLessonsModel({this.errorMessage, this.missedLessons});

  MissedLessonsModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['error_message'];
    if (json['missed_lessons'] != null) {
      missedLessons = <MissedLessons>[];
      json['missed_lessons'].forEach((v) {
        missedLessons!.add(MissedLessons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_message'] = errorMessage;
    if (missedLessons != null) {
      data['missed_lessons'] = missedLessons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MissedLessons {
  String? lessonDate;
  String? lessonId;
  String? lessonNumber;
  String? subject;

  MissedLessons(
      {this.lessonDate, this.lessonId, this.lessonNumber, this.subject});

  MissedLessons.fromJson(Map<String, dynamic> json) {
    lessonDate = json['lesson_date'];
    lessonId = json['lesson_id'];
    lessonNumber = json['lesson_number'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lesson_date'] = lessonDate;
    data['lesson_id'] = lessonId;
    data['lesson_number'] = lessonNumber;
    data['subject'] = subject;
    return data;
  }
}
