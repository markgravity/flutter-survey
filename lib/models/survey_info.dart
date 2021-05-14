import 'package:object_mapper/object_mapper.dart';

class SurveyInfo with Mappable {
  String? id;
  String? title;
  String? description;
  String? coverImageUrl;

  @override
  void mapping(Mapper map) {
    map<String>("id", id, (v) => id = v as String?);
    map<String>("attributes.title", title, (v) => title = v as String?);
    map<String>("attributes.description", description,
        (v) => description = v as String?);
    map<String>("attributes.cover_image_url", coverImageUrl,
        (v) => coverImageUrl = v as String?);
  }
}
