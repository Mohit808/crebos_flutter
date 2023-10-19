/// title : "title"
/// description : "dexcription"
/// priority : 1

class Model {
  Model({
      String? title, 
      String? description, 
      num? priority,}){
    _title = title;
    _description = description;
    _priority = priority;
}

  Model.fromJson(dynamic json) {
    _title = json['title'];
    _description = json['description'];
    _priority = json['priority'];
  }
  String? _title;
  String? _description;
  num? _priority;
Model copyWith({  String? title,
  String? description,
  num? priority,
}) => Model(  title: title ?? _title,
  description: description ?? _description,
  priority: priority ?? _priority,
);
  String? get title => _title;
  String? get description => _description;
  num? get priority => _priority;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    return map;
  }

}