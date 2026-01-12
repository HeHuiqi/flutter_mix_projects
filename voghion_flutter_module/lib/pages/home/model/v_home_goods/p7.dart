import 'dart:convert';

class P7 {
  String? labelImg;
  dynamic detailImg;
  String? activityName;
  String? activityCountry;
  dynamic activityId;
  int? activityType;
  String? tagImg;
  String? tagTitle;
  dynamic endTime;
  dynamic lessTime;
  int? position;
  dynamic jumpType;
  String? preTitle;
  String? preColor;
  String? textColor;
  String? routeUrl;

  P7({
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

  factory P7.fromMap(Map<String, dynamic> data) => P7(
    labelImg: data['labelImg'] as String?,
    detailImg: data['detailImg'] as dynamic,
    activityName: data['activityName'] as String?,
    activityCountry: data['activityCountry'] as String?,
    activityId: data['activityId'] as dynamic,
    activityType: data['activityType'] as int?,
    tagImg: data['tagImg'] as String?,
    tagTitle: data['tagTitle'] as String?,
    endTime: data['endTime'] as dynamic,
    lessTime: data['lessTime'] as dynamic,
    position: data['position'] as int?,
    jumpType: data['jumpType'] as dynamic,
    preTitle: data['preTitle'] as String?,
    preColor: data['preColor'] as String?,
    textColor: data['textColor'] as String?,
    routeUrl: data['routeUrl'] as String?,
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
  /// Parses the string and returns the resulting Json object as [P7].
  factory P7.fromJson(String data) {
    return P7.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [P7] to a JSON string.
  String toJson() => json.encode(toMap());
}
