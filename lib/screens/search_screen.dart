import 'package:flutter/material.dart';
import 'package:google_search/screens/webview_screen.dart';
import 'package:google_search/widgets/loading_indicator.dart';
import 'package:google_search/widgets/message_snackbar.dart';
import '../data/models/search_result.dart';
import '../data/services/google_service.dart';
import '../data/services/search_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _searchApi = SearchService();
  final _searchGoogle = GoogleSearchService();

  List<SearchResult> _results = [];

  // adiciona a variável isLoading
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      return;
    }

    _isLoadingNotifier.value = true;

    dynamic results;

    try {
      //Realiza pesquisa na Api
      results = await _searchApi.search(query);
      MenssageSnackBar.show(context, 'Pesquisa Realizada Utilizando API');
    } catch (e) {
      //Caso não consiga acesso, realiza pesquisa direto a url da google
      results = await _searchGoogle.search(query);
      MenssageSnackBar.show(
          context, 'Pesquisa Realizada Utilizando url Google');
    }

    setState(() {
      _results = results;
      _isLoadingNotifier.value = false;
    });
  }

  void _openUrl(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(url: url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Pesquise aqui..',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _onSearch,
                  ),
                ),
                onSubmitted: (_) => _onSearch(),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<bool>(
                valueListenable: _isLoadingNotifier,
                builder: (context, isLoading, _) {
                  return Stack(
                    children: [
                      ListView.builder(
                        itemCount: _results.length,
                        itemBuilder: (context, index) {
                          final result = _results[index];
                          return ListTile(
                            title: Text(result.title),
                            subtitle: GestureDetector(
                              child: Text.rich(
                                TextSpan(
                                  text: result.url,
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              onTap: () => _openUrl(result.url),
                            ),
                          );
                        },
                      ),
                      if (isLoading) const LoadingIndicator()
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
