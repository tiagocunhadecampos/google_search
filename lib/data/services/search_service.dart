import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../models/search_result.dart';

class SearchService {
  final baseUrl = 'http://192.168.0.158:3000';

  Future<List<SearchResult>> search(String query) async {
    final dio = Dio();
    final ip = await getIpAddress();
    dynamic response;

    try {
      response = await dio.get('$ip:3000/search?q=$query');
    } catch (e) {
      response = await dio.get('$baseUrl/search?q=$query');
    }

    if (response.statusCode == 200) {
      if (response.data is String) {
        final decodedData = jsonDecode(response.data);
        return [SearchResult.fromJson(decodedData)];
      } else {
        final List<dynamic> data = response.data;
        return data.map((json) => SearchResult.fromJson(json)).toList();
      }
    } else {
      throw Exception('Failed to load search results');
    }
  }
}

Future<String?> getIpAddress() async {
  final interfaces = await NetworkInterface.list();
  for (final interface in interfaces) {
    final addresses = interface.addresses;
    for (final address in addresses) {
      if (address.type == InternetAddressType.IPv4) {
        return address.address;
      }
    }
  }
  return null;
}
