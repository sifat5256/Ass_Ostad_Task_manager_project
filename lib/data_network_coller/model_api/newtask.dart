/// status : "success"
/// data : [{"_id":"6562d7036d66888281719070","title":"z","description":"z","status":"New","createdDate":"16-11-2023"},{"_id":"6562d7526d6688828171907b","title":"My Task","description":"My Task","status":"New","createdDate":"16-11-2023"},{"_id":"6562d7546d6688828171907d","title":"My Task","description":"My Task","status":"New","createdDate":"16-11-2023"},{"_id":"6562d75e6d6688828171907f","title":"My Task","description":"My Task","status":"New","createdDate":"16-11-2023"},{"_id":"6562d76f6d66888281719081","title":"My Task","description":"My Task","status":"New","createdDate":"16-11-2023"},{"_id":"6562d7806d66888281719083","title":"My Task","description":"My Task","status":"New","createdDate":"16-11-2023"},{"_id":"6562d7846d66888281719085","title":"My Task","description":"My Task","status":"New","createdDate":"16-11-2023"},{"_id":"6562d7856d66888281719087","title":"My Task","description":"My Task","status":"New","createdDate":"16-11-2023"},{"_id":"6562d7d66d66888281719091","title":"1","description":"11","status":"New","createdDate":"16-11-2023"},{"_id":"6562d7dc6d66888281719093","title":"s","description":"s","status":"New","createdDate":"16-11-2023"},{"_id":"6562d8316d66888281719097","title":"My Task","description":"My Task","status":"New","createdDate":"16-11-2023"},{"_id":"6562d8336d66888281719099","title":"My Task","description":"My Task","status":"New","createdDate":"16-11-2023"},{"_id":"6562d8ec6d668882817190a8","title":"My Task","description":"My Task","status":"New","createdDate":"16-11-2023"},{"_id":"6562d9256d668882817190ac","title":"22","description":"22","status":"New","createdDate":"16-11-2023"},{"_id":"6562da536d668882817190bc","title":"ere","description":"eerew","status":"New","createdDate":"16-11-2023"}]

class Newtask {
  Newtask({
      String? status, 
      List<Task>? data,}){
    _status = status;
    _data = data;
}

  Newtask.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Task.fromJson(v));
      });
    }
  }
  String? _status;
  List<Task>? _data;
Newtask copyWith({  String? status,
  List<Task>? data,
}) => Newtask(  status: status ?? _status,
  data: data ?? _data,
);
  String? get status => _status;
  List<Task>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "6562d7036d66888281719070"
/// title : "z"
/// description : "z"
/// status : "New"
/// createdDate : "16-11-2023"

class Task {
  Task({
      String? id, 
      String? title, 
      String? description, 
      String? status, 
      String? createdDate,}){
    _id = id;
    _title = title;
    _description = description;
    _status = status;
    _createdDate = createdDate;
}

  Task.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _description = json['description'];
    _status = json['status'];
    _createdDate = json['createdDate'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _status;
  String? _createdDate;
Task copyWith({  String? id,
  String? title,
  String? description,
  String? status,
  String? createdDate,
}) => Task(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  status: status ?? _status,
  createdDate: createdDate ?? _createdDate,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get status => _status;
  String? get createdDate => _createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['status'] = _status;
    map['createdDate'] = _createdDate;
    return map;
  }

}