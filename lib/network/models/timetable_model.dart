class TimetableModel {
  List<Dates>? dates;

  TimetableModel({this.dates});

  TimetableModel.fromJson(Map<String, dynamic> json) {
    if (json['dates'] != null) {
      dates = <Dates>[];
      json['dates'].forEach((v) {
        dates!.add(Dates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dates != null) {
      data['dates'] = dates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dates {
  List<Calls>? calls;
  String? date;

  Dates({this.calls, this.date});

  Dates.fromJson(Map<String, dynamic> json) {
    if (json['calls'] != null) {
      calls = <Calls>[];
      json['calls'].forEach((v) {
        calls!.add(Calls.fromJson(v));
      });
    }
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (calls != null) {
      data['calls'] = calls!.map((v) => v.toJson()).toList();
    }
    data['date'] = date;
    return data;
  }
}

class Calls {
  int? callId;
  int? callNumber;
  List<Subjects>? subjects;
  String? timeEnd;
  String? timeStart;

  Calls(
      {this.callId,
      this.callNumber,
      this.subjects,
      this.timeEnd,
      this.timeStart});

  Calls.fromJson(Map<String, dynamic> json) {
    callId = json['call_id'];
    callNumber = json['call_number'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
    timeEnd = json['time_end'];
    timeStart = json['time_start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['call_id'] = callId;
    data['call_number'] = callNumber;
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    data['time_end'] = timeEnd;
    data['time_start'] = timeStart;
    return data;
  }
}

class Subjects {
  String? room;
  String? subjectName;
  Teacher? teacher;

  Subjects({this.room, this.subjectName, this.teacher});

  Subjects.fromJson(Map<String, dynamic> json) {
    room = json['room'];
    subjectName = json['subject_name'];
    teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['room'] = room;
    data['subject_name'] = subjectName;
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    return data;
  }
}

class Teacher {
  int? id;
  String? name;

  Teacher({this.id, this.name});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
