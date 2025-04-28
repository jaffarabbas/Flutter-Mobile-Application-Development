import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchprovider = StateNotifierProvider<SearchNotifer,SearchState>((ref) {
  return SearchNotifer();
});

class SearchNotifer extends StateNotifier<SearchState> {
  SearchNotifer() : super(SearchState(search: ''));

  void setSearch(String search) {
    state = state.copyWith(search: search);
  }
}


class SearchState {
  final String search;

  SearchState({required this.search});

  SearchState copyWith({String? search}) {
    return SearchState(
      search: search ?? this.search,
    );
  }
}

