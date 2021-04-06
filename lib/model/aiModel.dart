// To parse this JSON data, do
//
//     final aiPred = aiPredFromJson(jsonString);

import 'dart:convert';

List<AiPred> aiPredFromJson(String str) => List<AiPred>.from(json.decode(str).map((x) => AiPred.fromJson(x)));

String aiPredToJson(List<AiPred> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AiPred {
  AiPred({
    this.confidence,
    this.index,
    this.label,
  });

  final double confidence;
  final int index;
  final String label;

  factory AiPred.fromJson(Map<String, dynamic> json) => AiPred(
    confidence: json["confidence"].toDouble(),
    index: json["index"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "confidence": confidence,
    "index": index,
    "label": label,
  };
}
