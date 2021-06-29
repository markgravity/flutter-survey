import 'package:object_mapper/object_mapper.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class SurveyInfo extends Equatable with Mappable {
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
    map<String>("attributes.cover_image_url", coverImageUrl, (v) {
      final url = v as String?;
      coverImageUrl = url != null ? "${url}l" : null;
    });
  }

  @override
  List<Object?> get props => [title, description, coverImageUrl];
}
