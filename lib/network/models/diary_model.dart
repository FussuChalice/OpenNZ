class DiaryModel {
  List<Dates>? dates;
  String? errorMessage;

  DiaryModel({this.dates, this.errorMessage});

  DiaryModel.fromJson(Map<String, dynamic> json) {
    if (json['dates'] != null) {
      dates = <Dates>[];
      json['dates'].forEach((v) {
        dates!.add(Dates.fromJson(v));
      });
    }
    errorMessage = json['error_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dates != null) {
      data['dates'] = dates!.map((v) => v.toJson()).toList();
    }
    data['error_message'] = errorMessage;
    return data;
  }
}

class Dates {
  String? date;
  List<Calls>? calls;

  Dates({this.date, this.calls});

  Dates.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['calls'] != null) {
      calls = <Calls>[];
      json['calls'].forEach((v) {
        calls!.add(Calls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (calls != null) {
      data['calls'] = calls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Calls {
  int? callId;
  int? callNumber;
  List<Subjects>? subjects;

  Calls({this.callId, this.callNumber, this.subjects});

  Calls.fromJson(Map<String, dynamic> json) {
    callId = json['call_id'];
    callNumber = json['call_number'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['call_id'] = callId;
    data['call_number'] = callNumber;
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  List<Lesson>? lesson;
  List<String>? hometask;
  Null distanceHometaskId;
  Null distanceHometaskIsClosed;
  String? subjectName;
  String? room;

  Subjects(
      {this.lesson,
      this.hometask,
      this.distanceHometaskId,
      this.distanceHometaskIsClosed,
      this.subjectName,
      this.room});

  Subjects.fromJson(Map<String, dynamic> json) {
    if (json['lesson'] != null) {
      lesson = <Lesson>[];
      json['lesson'].forEach((v) {
        lesson!.add(Lesson.fromJson(v));
      });
    }
    hometask = json['hometask'].cast<String>();
    distanceHometaskId = json['distance_hometask_id'];
    distanceHometaskIsClosed = json['distance_hometask_is_closed'];
    subjectName = json['subject_name'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (lesson != null) {
      data['lesson'] = lesson!.map((v) => v.toJson()).toList();
    }
    data['hometask'] = hometask;
    data['distance_hometask_id'] = distanceHometaskId;
    data['distance_hometask_is_closed'] = distanceHometaskIsClosed;
    data['subject_name'] = subjectName;
    data['room'] = room;
    return data;
  }
}

class Lesson {
  String? type;
  String? mark;
  String? comment;

  Lesson({this.type, this.mark, this.comment});

  Lesson.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    mark = json['mark'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['mark'] = mark;
    data['comment'] = comment;
    return data;
  }
}
