import 'package:object_mapper/object_mapper.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class SurveyInfo extends Equatable with Mappable {
  String? title;
  String? description;
  String? coverImageUrl;

  @override
  void mapping(Mapper map) {
    map<String>("title", title, (v) => title = v as String?);
    map<String>("description", description, (v) => description = v as String?);
    map<String>(
        "cover_image_url", coverImageUrl, (v) => coverImageUrl = v as String?);
  }

  @override
  List<Object?> get props => [title, description, coverImageUrl];
}
