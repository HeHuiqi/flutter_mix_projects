import 'dart:convert';

class TagInfoList {
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

  TagInfoList({
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

  factory TagInfoList.fromMap(Map<String, dynamic> data) => TagInfoList(
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
  /// Parses the string and returns the resulting Json object as [TagInfoList].
  factory TagInfoList.fromJson(String data) {
    return TagInfoList.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TagInfoList] to a JSON string.
  String toJson() => json.encode(toMap());
}
