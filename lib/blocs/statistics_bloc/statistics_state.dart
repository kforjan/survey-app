part of 'statistics_bloc.dart';

@immutable
abstract class StatisticsState {}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  StatisticsLoaded({
    required this.answerStatistics,
    required this.questions,
  });

  final Map<String, dynamic> answerStatistics;
  final List<Question> questions;
}

class NoStatisticsFound extends StatisticsState {}

class ConnectionFailure extends StatisticsState {}
