part of '../school_database.dart';

@DriftAccessor(tables: [RecycleBin])
class RecycleBinDao extends DatabaseAccessor<SchoolDatabase> with _$RecycleBinDaoMixin {
  RecycleBinDao(super.db);

  Future<int> addDeleted(String entityType, int entityId, String entityData) =>
      into(recycleBin).insert(RecycleBinCompanion.insert(
        entityType: entityType,
        entityId: entityId,
        entityData: entityData,
      ));

  Stream<List<RecycleBinData>> watchAll() =>
      (select(recycleBin)..orderBy([(r) => OrderingTerm.desc(r.deletedAt)])).watch();

  Future<List<RecycleBinData>> getAll() =>
      (select(recycleBin)..orderBy([(r) => OrderingTerm.desc(r.deletedAt)])).get();

  Future<void> restore(int id) => (delete(recycleBin)..where((r) => r.id.equals(id))).go();

  Future<void> deletePermanent(int id) => (delete(recycleBin)..where((r) => r.id.equals(id))).go();
}
