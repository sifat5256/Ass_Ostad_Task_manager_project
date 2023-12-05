/// status : "success"
/// data : [{"_id":null,"sum":2},{"_id":"Canceled","sum":1},{"_id":"New","sum":15}]

class Taskcountsummarymodel {
  Taskcountsummarymodel({
      String? status, 
      List<Taskcount>? data,}){
    _status = status;
    _data = data;
}

  Taskcountsummarymodel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Taskcount.fromJson(v));
      });
    }
  }
  String? _status;
  List<Taskcount>? _data;
Taskcountsummarymodel copyWith({  String? status,
  List<Taskcount>? data,
}) => Taskcountsummarymodel(  status: status ?? _status,
  data: data ?? _data,
);
  String? get status => _status;
  List<Taskcount>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : null
/// sum : 2

class Taskcount {
  Taskcount({
      dynamic id, 
      num? sum,}){
    _id = id;
    _sum = sum;
}

  Taskcount.fromJson(dynamic json) {
    _id = json['_id'];
    _sum = json['sum'];
  }
  dynamic _id;
  num? _sum;
Taskcount copyWith({  dynamic id,
  num? sum,
}) => Taskcount(  id: id ?? _id,
  sum: sum ?? _sum,
);
  dynamic get id => _id;
  num? get sum => _sum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['sum'] = _sum;
    return map;
  }

}