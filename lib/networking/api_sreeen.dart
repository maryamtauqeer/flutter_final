import 'package:flutter/material.dart';
import 'package:flutter_final/networking/album_model.dart';
import 'package:flutter_final/networking/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class APIScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Album>> apiData = ref.watch(apiDataProvider);

    return apiData.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final album = data[index];
          return ListTile(
            title: Text(album.title),
            subtitle: Text('User ID: ${album.userId}, ID: ${album.id}'),
          );
        },
      ),
    );
  }
}
