class Cast {
  int? id;
  String? name;
  String? profilePath;

  Cast({
    this.id,
    this.name,
    this.profilePath
  });

  Cast.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['profile_path'] = profilePath;
    return data;
  }
}

