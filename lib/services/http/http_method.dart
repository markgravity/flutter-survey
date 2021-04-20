part of 'http_service.dart';

class HttpMethod extends Enum<String> {
  factory HttpMethod(String rawValue) => Enum.factory(values, rawValue);
  const HttpMethod._(String rawValue) : super(rawValue);

  static const get = HttpMethod._("get");
  static const post = HttpMethod._("post");
  static const put = HttpMethod._("put");
  static const patch = HttpMethod._("patch");
  static const delete = HttpMethod._("delete");

  static List<HttpMethod> values = [get, post, put, patch, delete];
}
