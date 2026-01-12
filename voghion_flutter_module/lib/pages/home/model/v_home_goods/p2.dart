import 'dart:convert';

class P2 {
  String? labelImg;
  dynamic detailImg;
  String? activityName;
  String? activityCountry;
  int? activityId;
  int? activityType;
  String? tagImg;
  dynamic tagTitle;
  int? endTime;
  int? lessTime;
  int? position;
  dynamic jumpType;
  dynamic preTitle;
  dynamic preColor;
  dynamic textColor;
  dynamic routeUrl;

  P2({
    this.labelImg,
    this.detailImg,
    this.activityName,
    this.activityCountry,
    this.activityId,
    this.activityType,
    this.tagImg,
    this.tagTitle,
    this.endTime,
    this.lessTime,
    this.position,
    this.jumpType,
    this.preTitle,
    this.preColor,
    this.textColor,
    this.routeUrl,
  });

  factory P2.fromMap(Map<String, dynamic> data) => P2(
    labelImg: data['labelImg'] as String?,
    detailImg: data['detailImg'] as dynamic,
    activityName: data['activityName'] as String?,
    activityCountry: data['activityCountry'] as String?,
    activityId: data['activityId'] as int?,
    activityType: data['activityType'] as int?,
    tagImg: data['tagImg'] as String?,
    tagTitle: data['tagTitle'] as dynamic,
    endTime: data['endTime'] as int?,
    lessTime: data['lessTime'] as int?,
    position: data['position'] as int?,
    jumpType: data['jumpType'] as dynamic,
    preTitle: data['preTitle'] as dynamic,
    preColor: data['preColor'] as dynamic,
    textColor: data['textColor'] as dynamic,
    routeUrl: data['routeUrl'] as dynamic,
  );

  Map<String, dynamic> toMap() => {
    'labelImg': labelImg,
    'detailImg': detailImg,
    'activityName': activityName,
    'activityCountry': activityCountry,
    'activityId': activityId,
    'activityType': activityType,
    'tagImg': tagImg,
    'tagTitle': tagTitle,
    'endTime': endTime,
    'lessTime': lessTime,
    'position': position,
    'jumpType': jumpType,
    'preTitle': preTitle,
    'preColor': preColor,
    'textColor': textColor,
    'routeUrl': routeUrl,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [P2].
  factory P2.fromJson(String data) {
    return P2.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [P2] to a JSON string.
  String toJson() => json.encode(toMap());
}
