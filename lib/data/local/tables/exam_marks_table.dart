part of '../school_database.dart';

class ExamMarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get examId => integer().references(Exams, #id)();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get componentId => integer().references(ExamComponents, #id)();
  RealColumn get marksObtained => real().withDefault(const Constant(0.0))();

  @override
  List<Set<Column>> get uniqueKeys => [
        {examId, studentId, componentId},
      ];
}
