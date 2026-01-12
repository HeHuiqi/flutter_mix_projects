import 'dart:convert';

import 'p2.dart';
import 'p6.dart';
import 'p7.dart';

class TagInfoMap {
  List<P7>? p7;
  List<P6>? p6;
  List<P2>? p2;

  TagInfoMap({this.p7, this.p6, this.p2});

  factory TagInfoMap.fromMap(Map<String, dynamic> data) => TagInfoMap(
    p7: (data['P7'] as List<dynamic>?)
        ?.map((e) => P7.fromMap(e as Map<String, dynamic>))
        .toList(),
    p6: (data['P6'] as List<dynamic>?)
        ?.map((e) => P6.fromMap(e as Map<String, dynamic>))
        .toList(),
    p2: (data['P2'] as List<dynamic>?)
        ?.map((e) => P2.fromMap(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    'P7': p7?.map((e) => e.toMap()).toList(),
    'P6': p6?.map((e) => e.toMap()).toList(),
    'P2': p2?.map((e) => e.toMap()).toList(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TagInfoMap].
  factory TagInfoMap.fromJson(String data) {
    return TagInfoMap.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TagInfoMap] to a JSON string.
  String toJson() => json.encode(toMap());
}
