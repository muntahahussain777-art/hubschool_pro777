part of '../school_database.dart';

@DriftAccessor(tables: [SchoolSettings])
class SchoolSettingsDao extends DatabaseAccessor<SchoolDatabase> with _$SchoolSettingsDaoMixin {
  SchoolSettingsDao(super.db);

  Future<String?> get(String key) async {
    final row = await (select(schoolSettings)..where((s) => s.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<void> set(String key, String value) async {
    await into(schoolSettings).insertOnConflictUpdate(
      SchoolSettingsCompanion.insert(key: key, value: value),
    );
  }

  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final v = await get(key);
    return v == 'true' ? true : (v == 'false' ? false : defaultValue);
  }

  Future<void> setBool(String key, bool value) => set(key, value.toString());
}
