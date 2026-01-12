import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas'),
        backgroundColor: Colors.black,
      ),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _SearchBar(),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scroll) {
                      if (!provider.loadingMore &&
                          scroll.metrics.pixels >=
                              scroll.metrics.maxScrollExtent - 200) {
                        provider.loadMore();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount:
                          provider.movies.length +
                          (provider.loadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < provider.movies.length) {
                          return MovieCard(movie: provider.movies[index]);
                        }
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<MovieProvider>();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        onChanged: provider.search,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Buscar...',
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: const Icon(Icons.search, color: Colors.white54),
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
