
class ChatResponse {
  ChatResponse({
      this.id, 
      this.object, 
      this.created, 
      this.choices, 
      this.usage,});

  ChatResponse.fromJson(dynamic json) {
    id = json['id'];
    object = json['object'];
    created = json['created'];
    if (json['choices'] != null) {
      choices = [];
      json['choices'].forEach((v) {
        choices?.add(Choices.fromJson(v));
      });
    }
    usage = json['usage'] != null ? Usage.fromJson(json['usage']) : null;
  }
  String? id;
  String? object;
  int? created;
  List<Choices>? choices;
  Usage? usage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['object'] = object;
    map['created'] = created;
    if (choices != null) {
      map['choices'] = choices?.map((v) => v.toJson()).toList();
    }
    if (usage != null) {
      map['usage'] = usage?.toJson();
    }
    return map;
  }

}
class Choices {
  Choices({
    this.index,
    this.message,
    this.finishReason,});

  Choices.fromJson(dynamic json) {
    index = json['index'];
    message = json['message'] != null ? Message.fromJson(json['message']) : null;
    finishReason = json['finish_reason'];
  }
  int? index;
  Message? message;
  String? finishReason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['index'] = index;
    if (message != null) {
      map['message'] = message?.toJson();
    }
    map['finish_reason'] = finishReason;
    return map;
  }

}
class Message {
  Message({
    this.role,
    this.content,});

  Message.fromJson(dynamic json) {
    role = json['role'];
    content = json['content'];
  }
  String? role;
  String? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['role'] = role;
    map['content'] = content;
    return map;
  }

}
class Usage {
  Usage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,});

  Usage.fromJson(dynamic json) {
    promptTokens = json['prompt_tokens'];
    completionTokens = json['completion_tokens'];
    totalTokens = json['total_tokens'];
  }
  int? promptTokens;
  int? completionTokens;
  int? totalTokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prompt_tokens'] = promptTokens;
    map['completion_tokens'] = completionTokens;
    map['total_tokens'] = totalTokens;
    return map;
  }

}