part of 'exam_degree_cubit.dart';

@immutable
abstract class ExamDegreeState {}

class ExamDegreeInitial extends ExamDegreeState {}
class ExamDegreeDetails extends ExamDegreeState {
  final DegreeDetails degreeDetails;

  ExamDegreeDetails(this.degreeDetails);
}
