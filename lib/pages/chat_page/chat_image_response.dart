/// created : 1589478378
/// data : [{"url":"https://..."},{"url":"https://..."}]

class ChatImageResponse {
  num? _created;
  List<DataImage>? _data;
  ChatImageResponse({
      num? created,
      List<DataImage>? data,}){
    _created = created;
    _data = data;
}

  ChatImageResponse.fromJson(dynamic json) {
    _created = json['created'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DataImage.fromJson(v));
      });
    }
  }

ChatImageResponse copyWith({  num? created,
  List<DataImage>? data,
}) => ChatImageResponse(  created: created ?? _created,
  data: data ?? _data,
);
  num? get created => _created;
  List<DataImage>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['created'] = _created;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// url : "https://..."

class DataImage {
  DataImage({
      String? url,}){
    _url = url;
}

  DataImage.fromJson(dynamic json) {
    _url = json['url'];
  }
  String? _url;
DataImage copyWith({  String? url,
}) => DataImage(  url: url ?? _url,
);
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    return map;
  }

}