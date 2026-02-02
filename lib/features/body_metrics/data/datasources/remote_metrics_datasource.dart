// data/datasources/remote_metrics_datasource.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/body_metrics_model.dart';

class RemoteMetricsDatasource {
  final String baseUrl;
  final http.Client client;

  RemoteMetricsDatasource({
    required this.baseUrl,
    required this.client,
  });

  Future<List<BodyMetricsModel>> fetchUserMetrics(int userId) async {
    final response = await client.get(
      Uri.parse('$baseUrl/users/$userId/metrics'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load body metrics');
    }

    final List<dynamic> jsonList = json.decode(response.body);

    return jsonList
        .map((json) => BodyMetricsModel.fromJson(json))
        .toList();
  }

  Future<void> saveMetrics(BodyMetricsModel model, int userId) async {
    final response = await client.post(
      Uri.parse('$baseUrl/users/$userId/metrics'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(model.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to save body metrics');
    }
  }
}
