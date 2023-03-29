import '../models/search_result.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class GoogleSearchService {
  final _baseUrl = 'https://www.google.com/search?q=';

  Future<List<SearchResult>> search(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl$query'));

    final document = parser.parse(response.body);
    final links = document.querySelectorAll('a');

    final results = <SearchResult>[];
    for (final link in links) {
      final url = link.attributes['href'];
      if (url != null && url.startsWith('/url?q=')) {
        final title = link.text;
        final cleanedUrl = _cleanUrl(url);
        Map<String, dynamic> dados = {'title' : title, 'url' : cleanedUrl};
        results.add(SearchResult.fromJson(dados));
      }
    }

    return results;
  }

  String _cleanUrl(String url) {
    return Uri.decodeFull(url.substring('/url?q='.length).split('&')[0]);
  }
}