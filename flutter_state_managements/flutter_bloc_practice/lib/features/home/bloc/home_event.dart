part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishListButtonClickedEvent extends HomeEvent {
  final ProductDataModel dataModel;

  HomeProductWishListButtonClickedEvent({required this.dataModel});
}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel dataModel;

  HomeProductCartButtonClickedEvent({required this.dataModel});
}

class HomeWishListButtonNavigateEvent extends HomeEvent {}

class HomeCartButtonNavigateEvent extends HomeEvent {}
