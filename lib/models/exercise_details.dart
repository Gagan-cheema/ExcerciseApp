class ExerciseDetails {
  String? bodyPart;
  String? equipment;
  String? gifUrl;
  String? id;
  String? name;
  String? target;

  ExerciseDetails(
      {this.bodyPart,
      this.equipment,
      this.gifUrl,
      this.id,
      this.name,
      this.target});

  ExerciseDetails.fromJson(Map<String, dynamic> json) {
    bodyPart = json['bodyPart'];
    equipment = json['equipment'];
    gifUrl = json['gifUrl'];
    id = json['id'];
    name = json['name'];
    target = json['target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bodyPart'] = bodyPart;
    data['equipment'] = equipment;
    data['gifUrl'] = gifUrl;
    data['id'] = id;
    data['name'] = name;
    data['target'] = target;
    return data;
  }
}
