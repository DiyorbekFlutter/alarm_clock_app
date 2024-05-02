class Model {
  String dateTame;
  List<String> days;
  bool enabled;
  Model({required this.dateTame, required this.days, required this.enabled});

  factory Model.fromJson(Map<String, dynamic> json){
    return Model(
      dateTame: json["dateTame"],
      days: List<String>.from(json["days"].map((e) => e.toString())),
      enabled: json["enabled"]
    );
  }

  Map<String, dynamic> get toJson => {
    "dateTame": dateTame,
    "days": days,
    "enabled": enabled
  };
}

List<Map<String, dynamic>> models = [];
