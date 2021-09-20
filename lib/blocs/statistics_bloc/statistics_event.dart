part of 'statistics_bloc.dart';

@immutable
abstract class StatisticsEvent {}

class LoadStatistics extends StatisticsEvent {
  LoadStatistics(this.id);
  final String id;
}
