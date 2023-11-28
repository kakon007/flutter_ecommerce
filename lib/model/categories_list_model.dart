// To parse this JSON data, do
//
//     final categoriesListModel = categoriesListModelFromJson(jsonString);

import 'dart:convert';

List<String> categoriesListModelFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String categoriesListModelToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
