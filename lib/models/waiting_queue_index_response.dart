// To parse this JSON data, do
//
//     final waitingQueueIndexResponse = waitingQueueIndexResponseFromJson(jsonString);

import 'dart:convert';

WaitingQueueIndexResponse waitingQueueIndexResponseFromJson(String str) =>
    WaitingQueueIndexResponse.fromJson(json.decode(str));

String waitingQueueIndexResponseToJson(WaitingQueueIndexResponse data) =>
    json.encode(data.toJson());

class WaitingQueueIndexResponse {
  WaitingQueueIndexResponse({
    this.index,
  });

  int? index;

  factory WaitingQueueIndexResponse.fromJson(Map<String, dynamic> json) =>
      WaitingQueueIndexResponse(
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
      };
}
