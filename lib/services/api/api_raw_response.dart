part of 'api_service.dart';

class ApiRawResponse with Mappable {
  ApiRawObject? data;
  Map<String, dynamic>? meta;
  List<ApiRawObject>? included;

  @override
  void mapping(Mapper map) {
    map<ApiRawObject>("data", data, (v) => data = v as ApiRawObject?);
    map<Map<String, dynamic>>(
        "meta", meta, (v) => meta = v as Map<String, dynamic>?);
    map<ApiRawObject>(
        "included", included, (v) => included = v as List<ApiRawObject>?);
  }
}

class ApiRawObject with Mappable {
  String? id;
  String? type;
  Map<String, dynamic>? attributes;
  Map<String, dynamic>? relationships;

  @override
  void mapping(Mapper map) {
    map<String>("id", id, (v) => id = v as String);
    map<String>("type", type, (v) => type = v as String);
    map<Map<String, dynamic>>("attributes", attributes,
        (v) => attributes = v as Map<String, dynamic>);
    map<Map<String, dynamic>>("relationships", relationships,
        (v) => relationships = v as Map<String, dynamic>?);
  }
}
