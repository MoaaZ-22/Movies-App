class SessionIdModel {
  bool? success;
  String? sessionId;

  SessionIdModel({this.success, this.sessionId});

  SessionIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    sessionId = json['session_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['session_id'] = sessionId;
    return data;
  }
}
