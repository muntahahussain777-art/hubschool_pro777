// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_database.dart';

// ignore_for_file: type=lint
class $RolesTable extends Roles with TableInfo<$RolesTable, Role> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RolesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, code, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'roles';
  @override
  VerificationContext validateIntegrity(Insertable<Role> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Role map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Role(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $RolesTable createAlias(String alias) {
    return $RolesTable(attachedDatabase, alias);
  }
}

class Role extends DataClass implements Insertable<Role> {
  final int id;
  final String code;
  final String name;
  const Role({required this.id, required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  RolesCompanion toCompanion(bool nullToAbsent) {
    return RolesCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
    );
  }

  factory Role.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Role(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
    };
  }

  Role copyWith({int? id, String? code, String? name}) => Role(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
      );
  Role copyWithCompanion(RolesCompanion data) {
    return Role(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Role(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Role &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name);
}

class RolesCompanion extends UpdateCompanion<Role> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  const RolesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
  });
  RolesCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
  })  : code = Value(code),
        name = Value(name);
  static Insertable<Role> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
    });
  }

  RolesCompanion copyWith(
      {Value<int>? id, Value<String>? code, Value<String>? name}) {
    return RolesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RolesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _passwordHashMeta =
      const VerificationMeta('passwordHash');
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
      'password_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleIdMeta = const VerificationMeta('roleId');
  @override
  late final GeneratedColumn<int> roleId = GeneratedColumn<int>(
      'role_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES roles (id)'));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, username, passwordHash, roleId, isActive, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
          _passwordHashMeta,
          passwordHash.isAcceptableOrUnknown(
              data['password_hash']!, _passwordHashMeta));
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('role_id')) {
      context.handle(_roleIdMeta,
          roleId.isAcceptableOrUnknown(data['role_id']!, _roleIdMeta));
    } else if (isInserting) {
      context.missing(_roleIdMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      passwordHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password_hash'])!,
      roleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}role_id'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String passwordHash;
  final int roleId;
  final bool isActive;
  final DateTime createdAt;
  const User(
      {required this.id,
      required this.username,
      required this.passwordHash,
      required this.roleId,
      required this.isActive,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password_hash'] = Variable<String>(passwordHash);
    map['role_id'] = Variable<int>(roleId);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      passwordHash: Value(passwordHash),
      roleId: Value(roleId),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      roleId: serializer.fromJson<int>(json['roleId']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'roleId': serializer.toJson<int>(roleId),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  User copyWith(
          {int? id,
          String? username,
          String? passwordHash,
          int? roleId,
          bool? isActive,
          DateTime? createdAt}) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        passwordHash: passwordHash ?? this.passwordHash,
        roleId: roleId ?? this.roleId,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      roleId: data.roleId.present ? data.roleId.value : this.roleId,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('roleId: $roleId, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, username, passwordHash, roleId, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.passwordHash == this.passwordHash &&
          other.roleId == this.roleId &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> passwordHash;
  final Value<int> roleId;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.roleId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String passwordHash,
    required int roleId,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : username = Value(username),
        passwordHash = Value(passwordHash),
        roleId = Value(roleId);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? passwordHash,
    Expression<int>? roleId,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (roleId != null) 'role_id': roleId,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? passwordHash,
      Value<int>? roleId,
      Value<bool>? isActive,
      Value<DateTime>? createdAt}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      passwordHash: passwordHash ?? this.passwordHash,
      roleId: roleId ?? this.roleId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (roleId.present) {
      map['role_id'] = Variable<int>(roleId.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('roleId: $roleId, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ClassroomsTable extends Classrooms
    with TableInfo<$ClassroomsTable, Classroom> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClassroomsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sectionMeta =
      const VerificationMeta('section');
  @override
  late final GeneratedColumn<String> section = GeneratedColumn<String>(
      'section', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('A'));
  static const VerificationMeta _academicYearMeta =
      const VerificationMeta('academicYear');
  @override
  late final GeneratedColumn<int> academicYear = GeneratedColumn<int>(
      'academic_year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, section, academicYear];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'classrooms';
  @override
  VerificationContext validateIntegrity(Insertable<Classroom> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('section')) {
      context.handle(_sectionMeta,
          section.isAcceptableOrUnknown(data['section']!, _sectionMeta));
    }
    if (data.containsKey('academic_year')) {
      context.handle(
          _academicYearMeta,
          academicYear.isAcceptableOrUnknown(
              data['academic_year']!, _academicYearMeta));
    } else if (isInserting) {
      context.missing(_academicYearMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Classroom map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Classroom(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      section: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}section'])!,
      academicYear: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}academic_year'])!,
    );
  }

  @override
  $ClassroomsTable createAlias(String alias) {
    return $ClassroomsTable(attachedDatabase, alias);
  }
}

class Classroom extends DataClass implements Insertable<Classroom> {
  final int id;
  final String name;
  final String section;
  final int academicYear;
  const Classroom(
      {required this.id,
      required this.name,
      required this.section,
      required this.academicYear});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['section'] = Variable<String>(section);
    map['academic_year'] = Variable<int>(academicYear);
    return map;
  }

  ClassroomsCompanion toCompanion(bool nullToAbsent) {
    return ClassroomsCompanion(
      id: Value(id),
      name: Value(name),
      section: Value(section),
      academicYear: Value(academicYear),
    );
  }

  factory Classroom.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Classroom(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      section: serializer.fromJson<String>(json['section']),
      academicYear: serializer.fromJson<int>(json['academicYear']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'section': serializer.toJson<String>(section),
      'academicYear': serializer.toJson<int>(academicYear),
    };
  }

  Classroom copyWith(
          {int? id, String? name, String? section, int? academicYear}) =>
      Classroom(
        id: id ?? this.id,
        name: name ?? this.name,
        section: section ?? this.section,
        academicYear: academicYear ?? this.academicYear,
      );
  Classroom copyWithCompanion(ClassroomsCompanion data) {
    return Classroom(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      section: data.section.present ? data.section.value : this.section,
      academicYear: data.academicYear.present
          ? data.academicYear.value
          : this.academicYear,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Classroom(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('section: $section, ')
          ..write('academicYear: $academicYear')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, section, academicYear);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Classroom &&
          other.id == this.id &&
          other.name == this.name &&
          other.section == this.section &&
          other.academicYear == this.academicYear);
}

class ClassroomsCompanion extends UpdateCompanion<Classroom> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> section;
  final Value<int> academicYear;
  const ClassroomsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.section = const Value.absent(),
    this.academicYear = const Value.absent(),
  });
  ClassroomsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.section = const Value.absent(),
    required int academicYear,
  })  : name = Value(name),
        academicYear = Value(academicYear);
  static Insertable<Classroom> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? section,
    Expression<int>? academicYear,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (section != null) 'section': section,
      if (academicYear != null) 'academic_year': academicYear,
    });
  }

  ClassroomsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? section,
      Value<int>? academicYear}) {
    return ClassroomsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      section: section ?? this.section,
      academicYear: academicYear ?? this.academicYear,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (section.present) {
      map['section'] = Variable<String>(section.value);
    }
    if (academicYear.present) {
      map['academic_year'] = Variable<int>(academicYear.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassroomsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('section: $section, ')
          ..write('academicYear: $academicYear')
          ..write(')'))
        .toString();
  }
}

class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _admissionNoMeta =
      const VerificationMeta('admissionNo');
  @override
  late final GeneratedColumn<String> admissionNo = GeneratedColumn<String>(
      'admission_no', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fatherNameMeta =
      const VerificationMeta('fatherName');
  @override
  late final GeneratedColumn<String> fatherName = GeneratedColumn<String>(
      'father_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dobMeta = const VerificationMeta('dob');
  @override
  late final GeneratedColumn<DateTime> dob = GeneratedColumn<DateTime>(
      'dob', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _qrTokenMeta =
      const VerificationMeta('qrToken');
  @override
  late final GeneratedColumn<String> qrToken = GeneratedColumn<String>(
      'qr_token', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _classroomIdMeta =
      const VerificationMeta('classroomId');
  @override
  late final GeneratedColumn<int> classroomId = GeneratedColumn<int>(
      'classroom_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES classrooms (id)'));
  static const VerificationMeta _monthlyFeeMeta =
      const VerificationMeta('monthlyFee');
  @override
  late final GeneratedColumn<int> monthlyFee = GeneratedColumn<int>(
      'monthly_fee', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _previousSchoolMeta =
      const VerificationMeta('previousSchool');
  @override
  late final GeneratedColumn<String> previousSchool = GeneratedColumn<String>(
      'previous_school', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        admissionNo,
        fullName,
        fatherName,
        dob,
        phone,
        address,
        photoPath,
        qrToken,
        classroomId,
        monthlyFee,
        previousSchool,
        gender,
        isActive,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(Insertable<Student> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('admission_no')) {
      context.handle(
          _admissionNoMeta,
          admissionNo.isAcceptableOrUnknown(
              data['admission_no']!, _admissionNoMeta));
    } else if (isInserting) {
      context.missing(_admissionNoMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('father_name')) {
      context.handle(
          _fatherNameMeta,
          fatherName.isAcceptableOrUnknown(
              data['father_name']!, _fatherNameMeta));
    } else if (isInserting) {
      context.missing(_fatherNameMeta);
    }
    if (data.containsKey('dob')) {
      context.handle(
          _dobMeta, dob.isAcceptableOrUnknown(data['dob']!, _dobMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    }
    if (data.containsKey('qr_token')) {
      context.handle(_qrTokenMeta,
          qrToken.isAcceptableOrUnknown(data['qr_token']!, _qrTokenMeta));
    } else if (isInserting) {
      context.missing(_qrTokenMeta);
    }
    if (data.containsKey('classroom_id')) {
      context.handle(
          _classroomIdMeta,
          classroomId.isAcceptableOrUnknown(
              data['classroom_id']!, _classroomIdMeta));
    }
    if (data.containsKey('monthly_fee')) {
      context.handle(
          _monthlyFeeMeta,
          monthlyFee.isAcceptableOrUnknown(
              data['monthly_fee']!, _monthlyFeeMeta));
    }
    if (data.containsKey('previous_school')) {
      context.handle(
          _previousSchoolMeta,
          previousSchool.isAcceptableOrUnknown(
              data['previous_school']!, _previousSchoolMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      admissionNo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}admission_no'])!,
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      fatherName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}father_name'])!,
      dob: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}dob']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_path']),
      qrToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}qr_token'])!,
      classroomId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}classroom_id']),
      monthlyFee: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}monthly_fee'])!,
      previousSchool: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}previous_school']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class Student extends DataClass implements Insertable<Student> {
  final int id;
  final String admissionNo;
  final String fullName;
  final String fatherName;
  final DateTime? dob;
  final String? phone;
  final String? address;
  final String? photoPath;
  final String qrToken;
  final int? classroomId;
  final int monthlyFee;
  final String? previousSchool;
  final String? gender;
  final bool isActive;
  final DateTime createdAt;
  const Student(
      {required this.id,
      required this.admissionNo,
      required this.fullName,
      required this.fatherName,
      this.dob,
      this.phone,
      this.address,
      this.photoPath,
      required this.qrToken,
      this.classroomId,
      required this.monthlyFee,
      this.previousSchool,
      this.gender,
      required this.isActive,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['admission_no'] = Variable<String>(admissionNo);
    map['full_name'] = Variable<String>(fullName);
    map['father_name'] = Variable<String>(fatherName);
    if (!nullToAbsent || dob != null) {
      map['dob'] = Variable<DateTime>(dob);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['qr_token'] = Variable<String>(qrToken);
    if (!nullToAbsent || classroomId != null) {
      map['classroom_id'] = Variable<int>(classroomId);
    }
    map['monthly_fee'] = Variable<int>(monthlyFee);
    if (!nullToAbsent || previousSchool != null) {
      map['previous_school'] = Variable<String>(previousSchool);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      id: Value(id),
      admissionNo: Value(admissionNo),
      fullName: Value(fullName),
      fatherName: Value(fatherName),
      dob: dob == null && nullToAbsent ? const Value.absent() : Value(dob),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      qrToken: Value(qrToken),
      classroomId: classroomId == null && nullToAbsent
          ? const Value.absent()
          : Value(classroomId),
      monthlyFee: Value(monthlyFee),
      previousSchool: previousSchool == null && nullToAbsent
          ? const Value.absent()
          : Value(previousSchool),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory Student.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
      id: serializer.fromJson<int>(json['id']),
      admissionNo: serializer.fromJson<String>(json['admissionNo']),
      fullName: serializer.fromJson<String>(json['fullName']),
      fatherName: serializer.fromJson<String>(json['fatherName']),
      dob: serializer.fromJson<DateTime?>(json['dob']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      qrToken: serializer.fromJson<String>(json['qrToken']),
      classroomId: serializer.fromJson<int?>(json['classroomId']),
      monthlyFee: serializer.fromJson<int>(json['monthlyFee']),
      previousSchool: serializer.fromJson<String?>(json['previousSchool']),
      gender: serializer.fromJson<String?>(json['gender']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'admissionNo': serializer.toJson<String>(admissionNo),
      'fullName': serializer.toJson<String>(fullName),
      'fatherName': serializer.toJson<String>(fatherName),
      'dob': serializer.toJson<DateTime?>(dob),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'photoPath': serializer.toJson<String?>(photoPath),
      'qrToken': serializer.toJson<String>(qrToken),
      'classroomId': serializer.toJson<int?>(classroomId),
      'monthlyFee': serializer.toJson<int>(monthlyFee),
      'previousSchool': serializer.toJson<String?>(previousSchool),
      'gender': serializer.toJson<String?>(gender),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Student copyWith(
          {int? id,
          String? admissionNo,
          String? fullName,
          String? fatherName,
          Value<DateTime?> dob = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<String?> photoPath = const Value.absent(),
          String? qrToken,
          Value<int?> classroomId = const Value.absent(),
          int? monthlyFee,
          Value<String?> previousSchool = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          bool? isActive,
          DateTime? createdAt}) =>
      Student(
        id: id ?? this.id,
        admissionNo: admissionNo ?? this.admissionNo,
        fullName: fullName ?? this.fullName,
        fatherName: fatherName ?? this.fatherName,
        dob: dob.present ? dob.value : this.dob,
        phone: phone.present ? phone.value : this.phone,
        address: address.present ? address.value : this.address,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
        qrToken: qrToken ?? this.qrToken,
        classroomId: classroomId.present ? classroomId.value : this.classroomId,
        monthlyFee: monthlyFee ?? this.monthlyFee,
        previousSchool:
            previousSchool.present ? previousSchool.value : this.previousSchool,
        gender: gender.present ? gender.value : this.gender,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
      );
  Student copyWithCompanion(StudentsCompanion data) {
    return Student(
      id: data.id.present ? data.id.value : this.id,
      admissionNo:
          data.admissionNo.present ? data.admissionNo.value : this.admissionNo,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      fatherName:
          data.fatherName.present ? data.fatherName.value : this.fatherName,
      dob: data.dob.present ? data.dob.value : this.dob,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      qrToken: data.qrToken.present ? data.qrToken.value : this.qrToken,
      classroomId:
          data.classroomId.present ? data.classroomId.value : this.classroomId,
      monthlyFee:
          data.monthlyFee.present ? data.monthlyFee.value : this.monthlyFee,
      previousSchool: data.previousSchool.present
          ? data.previousSchool.value
          : this.previousSchool,
      gender: data.gender.present ? data.gender.value : this.gender,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('id: $id, ')
          ..write('admissionNo: $admissionNo, ')
          ..write('fullName: $fullName, ')
          ..write('fatherName: $fatherName, ')
          ..write('dob: $dob, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('photoPath: $photoPath, ')
          ..write('qrToken: $qrToken, ')
          ..write('classroomId: $classroomId, ')
          ..write('monthlyFee: $monthlyFee, ')
          ..write('previousSchool: $previousSchool, ')
          ..write('gender: $gender, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      admissionNo,
      fullName,
      fatherName,
      dob,
      phone,
      address,
      photoPath,
      qrToken,
      classroomId,
      monthlyFee,
      previousSchool,
      gender,
      isActive,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          other.id == this.id &&
          other.admissionNo == this.admissionNo &&
          other.fullName == this.fullName &&
          other.fatherName == this.fatherName &&
          other.dob == this.dob &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.photoPath == this.photoPath &&
          other.qrToken == this.qrToken &&
          other.classroomId == this.classroomId &&
          other.monthlyFee == this.monthlyFee &&
          other.previousSchool == this.previousSchool &&
          other.gender == this.gender &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<int> id;
  final Value<String> admissionNo;
  final Value<String> fullName;
  final Value<String> fatherName;
  final Value<DateTime?> dob;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<String?> photoPath;
  final Value<String> qrToken;
  final Value<int?> classroomId;
  final Value<int> monthlyFee;
  final Value<String?> previousSchool;
  final Value<String?> gender;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.admissionNo = const Value.absent(),
    this.fullName = const Value.absent(),
    this.fatherName = const Value.absent(),
    this.dob = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.qrToken = const Value.absent(),
    this.classroomId = const Value.absent(),
    this.monthlyFee = const Value.absent(),
    this.previousSchool = const Value.absent(),
    this.gender = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  StudentsCompanion.insert({
    this.id = const Value.absent(),
    required String admissionNo,
    required String fullName,
    required String fatherName,
    this.dob = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.photoPath = const Value.absent(),
    required String qrToken,
    this.classroomId = const Value.absent(),
    this.monthlyFee = const Value.absent(),
    this.previousSchool = const Value.absent(),
    this.gender = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : admissionNo = Value(admissionNo),
        fullName = Value(fullName),
        fatherName = Value(fatherName),
        qrToken = Value(qrToken);
  static Insertable<Student> custom({
    Expression<int>? id,
    Expression<String>? admissionNo,
    Expression<String>? fullName,
    Expression<String>? fatherName,
    Expression<DateTime>? dob,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? photoPath,
    Expression<String>? qrToken,
    Expression<int>? classroomId,
    Expression<int>? monthlyFee,
    Expression<String>? previousSchool,
    Expression<String>? gender,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (admissionNo != null) 'admission_no': admissionNo,
      if (fullName != null) 'full_name': fullName,
      if (fatherName != null) 'father_name': fatherName,
      if (dob != null) 'dob': dob,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (photoPath != null) 'photo_path': photoPath,
      if (qrToken != null) 'qr_token': qrToken,
      if (classroomId != null) 'classroom_id': classroomId,
      if (monthlyFee != null) 'monthly_fee': monthlyFee,
      if (previousSchool != null) 'previous_school': previousSchool,
      if (gender != null) 'gender': gender,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  StudentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? admissionNo,
      Value<String>? fullName,
      Value<String>? fatherName,
      Value<DateTime?>? dob,
      Value<String?>? phone,
      Value<String?>? address,
      Value<String?>? photoPath,
      Value<String>? qrToken,
      Value<int?>? classroomId,
      Value<int>? monthlyFee,
      Value<String?>? previousSchool,
      Value<String?>? gender,
      Value<bool>? isActive,
      Value<DateTime>? createdAt}) {
    return StudentsCompanion(
      id: id ?? this.id,
      admissionNo: admissionNo ?? this.admissionNo,
      fullName: fullName ?? this.fullName,
      fatherName: fatherName ?? this.fatherName,
      dob: dob ?? this.dob,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      photoPath: photoPath ?? this.photoPath,
      qrToken: qrToken ?? this.qrToken,
      classroomId: classroomId ?? this.classroomId,
      monthlyFee: monthlyFee ?? this.monthlyFee,
      previousSchool: previousSchool ?? this.previousSchool,
      gender: gender ?? this.gender,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (admissionNo.present) {
      map['admission_no'] = Variable<String>(admissionNo.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (fatherName.present) {
      map['father_name'] = Variable<String>(fatherName.value);
    }
    if (dob.present) {
      map['dob'] = Variable<DateTime>(dob.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (qrToken.present) {
      map['qr_token'] = Variable<String>(qrToken.value);
    }
    if (classroomId.present) {
      map['classroom_id'] = Variable<int>(classroomId.value);
    }
    if (monthlyFee.present) {
      map['monthly_fee'] = Variable<int>(monthlyFee.value);
    }
    if (previousSchool.present) {
      map['previous_school'] = Variable<String>(previousSchool.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('admissionNo: $admissionNo, ')
          ..write('fullName: $fullName, ')
          ..write('fatherName: $fatherName, ')
          ..write('dob: $dob, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('photoPath: $photoPath, ')
          ..write('qrToken: $qrToken, ')
          ..write('classroomId: $classroomId, ')
          ..write('monthlyFee: $monthlyFee, ')
          ..write('previousSchool: $previousSchool, ')
          ..write('gender: $gender, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $EnrollmentsTable extends Enrollments
    with TableInfo<$EnrollmentsTable, Enrollment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EnrollmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _studentIdMeta =
      const VerificationMeta('studentId');
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
      'student_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES students (id)'));
  static const VerificationMeta _classroomIdMeta =
      const VerificationMeta('classroomId');
  @override
  late final GeneratedColumn<int> classroomId = GeneratedColumn<int>(
      'classroom_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES classrooms (id)'));
  static const VerificationMeta _enrolledOnMeta =
      const VerificationMeta('enrolledOn');
  @override
  late final GeneratedColumn<DateTime> enrolledOn = GeneratedColumn<DateTime>(
      'enrolled_on', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _currentMeta =
      const VerificationMeta('current');
  @override
  late final GeneratedColumn<bool> current = GeneratedColumn<bool>(
      'current', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("current" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, studentId, classroomId, enrolledOn, current];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'enrollments';
  @override
  VerificationContext validateIntegrity(Insertable<Enrollment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(_studentIdMeta,
          studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta));
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('classroom_id')) {
      context.handle(
          _classroomIdMeta,
          classroomId.isAcceptableOrUnknown(
              data['classroom_id']!, _classroomIdMeta));
    } else if (isInserting) {
      context.missing(_classroomIdMeta);
    }
    if (data.containsKey('enrolled_on')) {
      context.handle(
          _enrolledOnMeta,
          enrolledOn.isAcceptableOrUnknown(
              data['enrolled_on']!, _enrolledOnMeta));
    }
    if (data.containsKey('current')) {
      context.handle(_currentMeta,
          current.isAcceptableOrUnknown(data['current']!, _currentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Enrollment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Enrollment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      studentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}student_id'])!,
      classroomId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}classroom_id'])!,
      enrolledOn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}enrolled_on'])!,
      current: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}current'])!,
    );
  }

  @override
  $EnrollmentsTable createAlias(String alias) {
    return $EnrollmentsTable(attachedDatabase, alias);
  }
}

class Enrollment extends DataClass implements Insertable<Enrollment> {
  final int id;
  final int studentId;
  final int classroomId;
  final DateTime enrolledOn;
  final bool current;
  const Enrollment(
      {required this.id,
      required this.studentId,
      required this.classroomId,
      required this.enrolledOn,
      required this.current});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['classroom_id'] = Variable<int>(classroomId);
    map['enrolled_on'] = Variable<DateTime>(enrolledOn);
    map['current'] = Variable<bool>(current);
    return map;
  }

  EnrollmentsCompanion toCompanion(bool nullToAbsent) {
    return EnrollmentsCompanion(
      id: Value(id),
      studentId: Value(studentId),
      classroomId: Value(classroomId),
      enrolledOn: Value(enrolledOn),
      current: Value(current),
    );
  }

  factory Enrollment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Enrollment(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      classroomId: serializer.fromJson<int>(json['classroomId']),
      enrolledOn: serializer.fromJson<DateTime>(json['enrolledOn']),
      current: serializer.fromJson<bool>(json['current']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'classroomId': serializer.toJson<int>(classroomId),
      'enrolledOn': serializer.toJson<DateTime>(enrolledOn),
      'current': serializer.toJson<bool>(current),
    };
  }

  Enrollment copyWith(
          {int? id,
          int? studentId,
          int? classroomId,
          DateTime? enrolledOn,
          bool? current}) =>
      Enrollment(
        id: id ?? this.id,
        studentId: studentId ?? this.studentId,
        classroomId: classroomId ?? this.classroomId,
        enrolledOn: enrolledOn ?? this.enrolledOn,
        current: current ?? this.current,
      );
  Enrollment copyWithCompanion(EnrollmentsCompanion data) {
    return Enrollment(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      classroomId:
          data.classroomId.present ? data.classroomId.value : this.classroomId,
      enrolledOn:
          data.enrolledOn.present ? data.enrolledOn.value : this.enrolledOn,
      current: data.current.present ? data.current.value : this.current,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Enrollment(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('classroomId: $classroomId, ')
          ..write('enrolledOn: $enrolledOn, ')
          ..write('current: $current')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, studentId, classroomId, enrolledOn, current);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Enrollment &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.classroomId == this.classroomId &&
          other.enrolledOn == this.enrolledOn &&
          other.current == this.current);
}

class EnrollmentsCompanion extends UpdateCompanion<Enrollment> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int> classroomId;
  final Value<DateTime> enrolledOn;
  final Value<bool> current;
  const EnrollmentsCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.classroomId = const Value.absent(),
    this.enrolledOn = const Value.absent(),
    this.current = const Value.absent(),
  });
  EnrollmentsCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required int classroomId,
    this.enrolledOn = const Value.absent(),
    this.current = const Value.absent(),
  })  : studentId = Value(studentId),
        classroomId = Value(classroomId);
  static Insertable<Enrollment> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? classroomId,
    Expression<DateTime>? enrolledOn,
    Expression<bool>? current,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (classroomId != null) 'classroom_id': classroomId,
      if (enrolledOn != null) 'enrolled_on': enrolledOn,
      if (current != null) 'current': current,
    });
  }

  EnrollmentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? studentId,
      Value<int>? classroomId,
      Value<DateTime>? enrolledOn,
      Value<bool>? current}) {
    return EnrollmentsCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      classroomId: classroomId ?? this.classroomId,
      enrolledOn: enrolledOn ?? this.enrolledOn,
      current: current ?? this.current,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (classroomId.present) {
      map['classroom_id'] = Variable<int>(classroomId.value);
    }
    if (enrolledOn.present) {
      map['enrolled_on'] = Variable<DateTime>(enrolledOn.value);
    }
    if (current.present) {
      map['current'] = Variable<bool>(current.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EnrollmentsCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('classroomId: $classroomId, ')
          ..write('enrolledOn: $enrolledOn, ')
          ..write('current: $current')
          ..write(')'))
        .toString();
  }
}

class $FeeHeadsTable extends FeeHeads with TableInfo<$FeeHeadsTable, FeeHead> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeeHeadsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isDiscountMeta =
      const VerificationMeta('isDiscount');
  @override
  late final GeneratedColumn<bool> isDiscount = GeneratedColumn<bool>(
      'is_discount', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_discount" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, code, name, isDiscount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fee_heads';
  @override
  VerificationContext validateIntegrity(Insertable<FeeHead> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_discount')) {
      context.handle(
          _isDiscountMeta,
          isDiscount.isAcceptableOrUnknown(
              data['is_discount']!, _isDiscountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeeHead map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeeHead(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      isDiscount: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_discount'])!,
    );
  }

  @override
  $FeeHeadsTable createAlias(String alias) {
    return $FeeHeadsTable(attachedDatabase, alias);
  }
}

class FeeHead extends DataClass implements Insertable<FeeHead> {
  final int id;
  final String code;
  final String name;
  final bool isDiscount;
  const FeeHead(
      {required this.id,
      required this.code,
      required this.name,
      required this.isDiscount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['is_discount'] = Variable<bool>(isDiscount);
    return map;
  }

  FeeHeadsCompanion toCompanion(bool nullToAbsent) {
    return FeeHeadsCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      isDiscount: Value(isDiscount),
    );
  }

  factory FeeHead.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeeHead(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      isDiscount: serializer.fromJson<bool>(json['isDiscount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'isDiscount': serializer.toJson<bool>(isDiscount),
    };
  }

  FeeHead copyWith({int? id, String? code, String? name, bool? isDiscount}) =>
      FeeHead(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        isDiscount: isDiscount ?? this.isDiscount,
      );
  FeeHead copyWithCompanion(FeeHeadsCompanion data) {
    return FeeHead(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      isDiscount:
          data.isDiscount.present ? data.isDiscount.value : this.isDiscount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeeHead(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('isDiscount: $isDiscount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, name, isDiscount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeeHead &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.isDiscount == this.isDiscount);
}

class FeeHeadsCompanion extends UpdateCompanion<FeeHead> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<bool> isDiscount;
  const FeeHeadsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.isDiscount = const Value.absent(),
  });
  FeeHeadsCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    this.isDiscount = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<FeeHead> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<bool>? isDiscount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (isDiscount != null) 'is_discount': isDiscount,
    });
  }

  FeeHeadsCompanion copyWith(
      {Value<int>? id,
      Value<String>? code,
      Value<String>? name,
      Value<bool>? isDiscount}) {
    return FeeHeadsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      isDiscount: isDiscount ?? this.isDiscount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isDiscount.present) {
      map['is_discount'] = Variable<bool>(isDiscount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeeHeadsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('isDiscount: $isDiscount')
          ..write(')'))
        .toString();
  }
}

class $FeeStructuresTable extends FeeStructures
    with TableInfo<$FeeStructuresTable, FeeStructure> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeeStructuresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _classroomIdMeta =
      const VerificationMeta('classroomId');
  @override
  late final GeneratedColumn<int> classroomId = GeneratedColumn<int>(
      'classroom_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES classrooms (id)'));
  static const VerificationMeta _feeHeadIdMeta =
      const VerificationMeta('feeHeadId');
  @override
  late final GeneratedColumn<int> feeHeadId = GeneratedColumn<int>(
      'fee_head_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES fee_heads (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
      'frequency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('monthly'));
  static const VerificationMeta _effectiveFromMeta =
      const VerificationMeta('effectiveFrom');
  @override
  late final GeneratedColumn<DateTime> effectiveFrom =
      GeneratedColumn<DateTime>('effective_from', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _effectiveToMeta =
      const VerificationMeta('effectiveTo');
  @override
  late final GeneratedColumn<DateTime> effectiveTo = GeneratedColumn<DateTime>(
      'effective_to', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        classroomId,
        feeHeadId,
        amount,
        frequency,
        effectiveFrom,
        effectiveTo
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fee_structures';
  @override
  VerificationContext validateIntegrity(Insertable<FeeStructure> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('classroom_id')) {
      context.handle(
          _classroomIdMeta,
          classroomId.isAcceptableOrUnknown(
              data['classroom_id']!, _classroomIdMeta));
    } else if (isInserting) {
      context.missing(_classroomIdMeta);
    }
    if (data.containsKey('fee_head_id')) {
      context.handle(
          _feeHeadIdMeta,
          feeHeadId.isAcceptableOrUnknown(
              data['fee_head_id']!, _feeHeadIdMeta));
    } else if (isInserting) {
      context.missing(_feeHeadIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    }
    if (data.containsKey('effective_from')) {
      context.handle(
          _effectiveFromMeta,
          effectiveFrom.isAcceptableOrUnknown(
              data['effective_from']!, _effectiveFromMeta));
    } else if (isInserting) {
      context.missing(_effectiveFromMeta);
    }
    if (data.containsKey('effective_to')) {
      context.handle(
          _effectiveToMeta,
          effectiveTo.isAcceptableOrUnknown(
              data['effective_to']!, _effectiveToMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeeStructure map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeeStructure(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      classroomId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}classroom_id'])!,
      feeHeadId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fee_head_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frequency'])!,
      effectiveFrom: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}effective_from'])!,
      effectiveTo: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}effective_to']),
    );
  }

  @override
  $FeeStructuresTable createAlias(String alias) {
    return $FeeStructuresTable(attachedDatabase, alias);
  }
}

class FeeStructure extends DataClass implements Insertable<FeeStructure> {
  final int id;
  final int classroomId;
  final int feeHeadId;
  final int amount;
  final String frequency;
  final DateTime effectiveFrom;
  final DateTime? effectiveTo;
  const FeeStructure(
      {required this.id,
      required this.classroomId,
      required this.feeHeadId,
      required this.amount,
      required this.frequency,
      required this.effectiveFrom,
      this.effectiveTo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['classroom_id'] = Variable<int>(classroomId);
    map['fee_head_id'] = Variable<int>(feeHeadId);
    map['amount'] = Variable<int>(amount);
    map['frequency'] = Variable<String>(frequency);
    map['effective_from'] = Variable<DateTime>(effectiveFrom);
    if (!nullToAbsent || effectiveTo != null) {
      map['effective_to'] = Variable<DateTime>(effectiveTo);
    }
    return map;
  }

  FeeStructuresCompanion toCompanion(bool nullToAbsent) {
    return FeeStructuresCompanion(
      id: Value(id),
      classroomId: Value(classroomId),
      feeHeadId: Value(feeHeadId),
      amount: Value(amount),
      frequency: Value(frequency),
      effectiveFrom: Value(effectiveFrom),
      effectiveTo: effectiveTo == null && nullToAbsent
          ? const Value.absent()
          : Value(effectiveTo),
    );
  }

  factory FeeStructure.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeeStructure(
      id: serializer.fromJson<int>(json['id']),
      classroomId: serializer.fromJson<int>(json['classroomId']),
      feeHeadId: serializer.fromJson<int>(json['feeHeadId']),
      amount: serializer.fromJson<int>(json['amount']),
      frequency: serializer.fromJson<String>(json['frequency']),
      effectiveFrom: serializer.fromJson<DateTime>(json['effectiveFrom']),
      effectiveTo: serializer.fromJson<DateTime?>(json['effectiveTo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'classroomId': serializer.toJson<int>(classroomId),
      'feeHeadId': serializer.toJson<int>(feeHeadId),
      'amount': serializer.toJson<int>(amount),
      'frequency': serializer.toJson<String>(frequency),
      'effectiveFrom': serializer.toJson<DateTime>(effectiveFrom),
      'effectiveTo': serializer.toJson<DateTime?>(effectiveTo),
    };
  }

  FeeStructure copyWith(
          {int? id,
          int? classroomId,
          int? feeHeadId,
          int? amount,
          String? frequency,
          DateTime? effectiveFrom,
          Value<DateTime?> effectiveTo = const Value.absent()}) =>
      FeeStructure(
        id: id ?? this.id,
        classroomId: classroomId ?? this.classroomId,
        feeHeadId: feeHeadId ?? this.feeHeadId,
        amount: amount ?? this.amount,
        frequency: frequency ?? this.frequency,
        effectiveFrom: effectiveFrom ?? this.effectiveFrom,
        effectiveTo: effectiveTo.present ? effectiveTo.value : this.effectiveTo,
      );
  FeeStructure copyWithCompanion(FeeStructuresCompanion data) {
    return FeeStructure(
      id: data.id.present ? data.id.value : this.id,
      classroomId:
          data.classroomId.present ? data.classroomId.value : this.classroomId,
      feeHeadId: data.feeHeadId.present ? data.feeHeadId.value : this.feeHeadId,
      amount: data.amount.present ? data.amount.value : this.amount,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      effectiveFrom: data.effectiveFrom.present
          ? data.effectiveFrom.value
          : this.effectiveFrom,
      effectiveTo:
          data.effectiveTo.present ? data.effectiveTo.value : this.effectiveTo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeeStructure(')
          ..write('id: $id, ')
          ..write('classroomId: $classroomId, ')
          ..write('feeHeadId: $feeHeadId, ')
          ..write('amount: $amount, ')
          ..write('frequency: $frequency, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('effectiveTo: $effectiveTo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, classroomId, feeHeadId, amount, frequency,
      effectiveFrom, effectiveTo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeeStructure &&
          other.id == this.id &&
          other.classroomId == this.classroomId &&
          other.feeHeadId == this.feeHeadId &&
          other.amount == this.amount &&
          other.frequency == this.frequency &&
          other.effectiveFrom == this.effectiveFrom &&
          other.effectiveTo == this.effectiveTo);
}

class FeeStructuresCompanion extends UpdateCompanion<FeeStructure> {
  final Value<int> id;
  final Value<int> classroomId;
  final Value<int> feeHeadId;
  final Value<int> amount;
  final Value<String> frequency;
  final Value<DateTime> effectiveFrom;
  final Value<DateTime?> effectiveTo;
  const FeeStructuresCompanion({
    this.id = const Value.absent(),
    this.classroomId = const Value.absent(),
    this.feeHeadId = const Value.absent(),
    this.amount = const Value.absent(),
    this.frequency = const Value.absent(),
    this.effectiveFrom = const Value.absent(),
    this.effectiveTo = const Value.absent(),
  });
  FeeStructuresCompanion.insert({
    this.id = const Value.absent(),
    required int classroomId,
    required int feeHeadId,
    required int amount,
    this.frequency = const Value.absent(),
    required DateTime effectiveFrom,
    this.effectiveTo = const Value.absent(),
  })  : classroomId = Value(classroomId),
        feeHeadId = Value(feeHeadId),
        amount = Value(amount),
        effectiveFrom = Value(effectiveFrom);
  static Insertable<FeeStructure> custom({
    Expression<int>? id,
    Expression<int>? classroomId,
    Expression<int>? feeHeadId,
    Expression<int>? amount,
    Expression<String>? frequency,
    Expression<DateTime>? effectiveFrom,
    Expression<DateTime>? effectiveTo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (classroomId != null) 'classroom_id': classroomId,
      if (feeHeadId != null) 'fee_head_id': feeHeadId,
      if (amount != null) 'amount': amount,
      if (frequency != null) 'frequency': frequency,
      if (effectiveFrom != null) 'effective_from': effectiveFrom,
      if (effectiveTo != null) 'effective_to': effectiveTo,
    });
  }

  FeeStructuresCompanion copyWith(
      {Value<int>? id,
      Value<int>? classroomId,
      Value<int>? feeHeadId,
      Value<int>? amount,
      Value<String>? frequency,
      Value<DateTime>? effectiveFrom,
      Value<DateTime?>? effectiveTo}) {
    return FeeStructuresCompanion(
      id: id ?? this.id,
      classroomId: classroomId ?? this.classroomId,
      feeHeadId: feeHeadId ?? this.feeHeadId,
      amount: amount ?? this.amount,
      frequency: frequency ?? this.frequency,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      effectiveTo: effectiveTo ?? this.effectiveTo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (classroomId.present) {
      map['classroom_id'] = Variable<int>(classroomId.value);
    }
    if (feeHeadId.present) {
      map['fee_head_id'] = Variable<int>(feeHeadId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (effectiveFrom.present) {
      map['effective_from'] = Variable<DateTime>(effectiveFrom.value);
    }
    if (effectiveTo.present) {
      map['effective_to'] = Variable<DateTime>(effectiveTo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeeStructuresCompanion(')
          ..write('id: $id, ')
          ..write('classroomId: $classroomId, ')
          ..write('feeHeadId: $feeHeadId, ')
          ..write('amount: $amount, ')
          ..write('frequency: $frequency, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('effectiveTo: $effectiveTo')
          ..write(')'))
        .toString();
  }
}

class $FeeInvoicesTable extends FeeInvoices
    with TableInfo<$FeeInvoicesTable, FeeInvoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeeInvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _studentIdMeta =
      const VerificationMeta('studentId');
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
      'student_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES students (id)'));
  static const VerificationMeta _monthKeyMeta =
      const VerificationMeta('monthKey');
  @override
  late final GeneratedColumn<String> monthKey = GeneratedColumn<String>(
      'month_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  @override
  late final GeneratedColumn<int> totalAmount = GeneratedColumn<int>(
      'total_amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _discountAmountMeta =
      const VerificationMeta('discountAmount');
  @override
  late final GeneratedColumn<int> discountAmount = GeneratedColumn<int>(
      'discount_amount', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _netAmountMeta =
      const VerificationMeta('netAmount');
  @override
  late final GeneratedColumn<int> netAmount = GeneratedColumn<int>(
      'net_amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _paidAmountMeta =
      const VerificationMeta('paidAmount');
  @override
  late final GeneratedColumn<int> paidAmount = GeneratedColumn<int>(
      'paid_amount', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _dueAmountMeta =
      const VerificationMeta('dueAmount');
  @override
  late final GeneratedColumn<int> dueAmount = GeneratedColumn<int>(
      'due_amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('unpaid'));
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        studentId,
        monthKey,
        totalAmount,
        discountAmount,
        netAmount,
        paidAmount,
        dueAmount,
        status,
        dueDate,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fee_invoices';
  @override
  VerificationContext validateIntegrity(Insertable<FeeInvoice> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(_studentIdMeta,
          studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta));
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('month_key')) {
      context.handle(_monthKeyMeta,
          monthKey.isAcceptableOrUnknown(data['month_key']!, _monthKeyMeta));
    } else if (isInserting) {
      context.missing(_monthKeyMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount']!, _totalAmountMeta));
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('discount_amount')) {
      context.handle(
          _discountAmountMeta,
          discountAmount.isAcceptableOrUnknown(
              data['discount_amount']!, _discountAmountMeta));
    }
    if (data.containsKey('net_amount')) {
      context.handle(_netAmountMeta,
          netAmount.isAcceptableOrUnknown(data['net_amount']!, _netAmountMeta));
    } else if (isInserting) {
      context.missing(_netAmountMeta);
    }
    if (data.containsKey('paid_amount')) {
      context.handle(
          _paidAmountMeta,
          paidAmount.isAcceptableOrUnknown(
              data['paid_amount']!, _paidAmountMeta));
    }
    if (data.containsKey('due_amount')) {
      context.handle(_dueAmountMeta,
          dueAmount.isAcceptableOrUnknown(data['due_amount']!, _dueAmountMeta));
    } else if (isInserting) {
      context.missing(_dueAmountMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeeInvoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeeInvoice(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      studentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}student_id'])!,
      monthKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}month_key'])!,
      totalAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_amount'])!,
      discountAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}discount_amount'])!,
      netAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}net_amount'])!,
      paidAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}paid_amount'])!,
      dueAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}due_amount'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FeeInvoicesTable createAlias(String alias) {
    return $FeeInvoicesTable(attachedDatabase, alias);
  }
}

class FeeInvoice extends DataClass implements Insertable<FeeInvoice> {
  final int id;
  final int studentId;
  final String monthKey;
  final int totalAmount;
  final int discountAmount;
  final int netAmount;
  final int paidAmount;
  final int dueAmount;
  final String status;
  final DateTime? dueDate;
  final DateTime createdAt;
  const FeeInvoice(
      {required this.id,
      required this.studentId,
      required this.monthKey,
      required this.totalAmount,
      required this.discountAmount,
      required this.netAmount,
      required this.paidAmount,
      required this.dueAmount,
      required this.status,
      this.dueDate,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['month_key'] = Variable<String>(monthKey);
    map['total_amount'] = Variable<int>(totalAmount);
    map['discount_amount'] = Variable<int>(discountAmount);
    map['net_amount'] = Variable<int>(netAmount);
    map['paid_amount'] = Variable<int>(paidAmount);
    map['due_amount'] = Variable<int>(dueAmount);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FeeInvoicesCompanion toCompanion(bool nullToAbsent) {
    return FeeInvoicesCompanion(
      id: Value(id),
      studentId: Value(studentId),
      monthKey: Value(monthKey),
      totalAmount: Value(totalAmount),
      discountAmount: Value(discountAmount),
      netAmount: Value(netAmount),
      paidAmount: Value(paidAmount),
      dueAmount: Value(dueAmount),
      status: Value(status),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      createdAt: Value(createdAt),
    );
  }

  factory FeeInvoice.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeeInvoice(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      monthKey: serializer.fromJson<String>(json['monthKey']),
      totalAmount: serializer.fromJson<int>(json['totalAmount']),
      discountAmount: serializer.fromJson<int>(json['discountAmount']),
      netAmount: serializer.fromJson<int>(json['netAmount']),
      paidAmount: serializer.fromJson<int>(json['paidAmount']),
      dueAmount: serializer.fromJson<int>(json['dueAmount']),
      status: serializer.fromJson<String>(json['status']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'monthKey': serializer.toJson<String>(monthKey),
      'totalAmount': serializer.toJson<int>(totalAmount),
      'discountAmount': serializer.toJson<int>(discountAmount),
      'netAmount': serializer.toJson<int>(netAmount),
      'paidAmount': serializer.toJson<int>(paidAmount),
      'dueAmount': serializer.toJson<int>(dueAmount),
      'status': serializer.toJson<String>(status),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FeeInvoice copyWith(
          {int? id,
          int? studentId,
          String? monthKey,
          int? totalAmount,
          int? discountAmount,
          int? netAmount,
          int? paidAmount,
          int? dueAmount,
          String? status,
          Value<DateTime?> dueDate = const Value.absent(),
          DateTime? createdAt}) =>
      FeeInvoice(
        id: id ?? this.id,
        studentId: studentId ?? this.studentId,
        monthKey: monthKey ?? this.monthKey,
        totalAmount: totalAmount ?? this.totalAmount,
        discountAmount: discountAmount ?? this.discountAmount,
        netAmount: netAmount ?? this.netAmount,
        paidAmount: paidAmount ?? this.paidAmount,
        dueAmount: dueAmount ?? this.dueAmount,
        status: status ?? this.status,
        dueDate: dueDate.present ? dueDate.value : this.dueDate,
        createdAt: createdAt ?? this.createdAt,
      );
  FeeInvoice copyWithCompanion(FeeInvoicesCompanion data) {
    return FeeInvoice(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      monthKey: data.monthKey.present ? data.monthKey.value : this.monthKey,
      totalAmount:
          data.totalAmount.present ? data.totalAmount.value : this.totalAmount,
      discountAmount: data.discountAmount.present
          ? data.discountAmount.value
          : this.discountAmount,
      netAmount: data.netAmount.present ? data.netAmount.value : this.netAmount,
      paidAmount:
          data.paidAmount.present ? data.paidAmount.value : this.paidAmount,
      dueAmount: data.dueAmount.present ? data.dueAmount.value : this.dueAmount,
      status: data.status.present ? data.status.value : this.status,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeeInvoice(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('monthKey: $monthKey, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('netAmount: $netAmount, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('dueAmount: $dueAmount, ')
          ..write('status: $status, ')
          ..write('dueDate: $dueDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      studentId,
      monthKey,
      totalAmount,
      discountAmount,
      netAmount,
      paidAmount,
      dueAmount,
      status,
      dueDate,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeeInvoice &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.monthKey == this.monthKey &&
          other.totalAmount == this.totalAmount &&
          other.discountAmount == this.discountAmount &&
          other.netAmount == this.netAmount &&
          other.paidAmount == this.paidAmount &&
          other.dueAmount == this.dueAmount &&
          other.status == this.status &&
          other.dueDate == this.dueDate &&
          other.createdAt == this.createdAt);
}

class FeeInvoicesCompanion extends UpdateCompanion<FeeInvoice> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<String> monthKey;
  final Value<int> totalAmount;
  final Value<int> discountAmount;
  final Value<int> netAmount;
  final Value<int> paidAmount;
  final Value<int> dueAmount;
  final Value<String> status;
  final Value<DateTime?> dueDate;
  final Value<DateTime> createdAt;
  const FeeInvoicesCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.monthKey = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.netAmount = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.dueAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FeeInvoicesCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required String monthKey,
    required int totalAmount,
    this.discountAmount = const Value.absent(),
    required int netAmount,
    this.paidAmount = const Value.absent(),
    required int dueAmount,
    this.status = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : studentId = Value(studentId),
        monthKey = Value(monthKey),
        totalAmount = Value(totalAmount),
        netAmount = Value(netAmount),
        dueAmount = Value(dueAmount);
  static Insertable<FeeInvoice> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<String>? monthKey,
    Expression<int>? totalAmount,
    Expression<int>? discountAmount,
    Expression<int>? netAmount,
    Expression<int>? paidAmount,
    Expression<int>? dueAmount,
    Expression<String>? status,
    Expression<DateTime>? dueDate,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (monthKey != null) 'month_key': monthKey,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (discountAmount != null) 'discount_amount': discountAmount,
      if (netAmount != null) 'net_amount': netAmount,
      if (paidAmount != null) 'paid_amount': paidAmount,
      if (dueAmount != null) 'due_amount': dueAmount,
      if (status != null) 'status': status,
      if (dueDate != null) 'due_date': dueDate,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FeeInvoicesCompanion copyWith(
      {Value<int>? id,
      Value<int>? studentId,
      Value<String>? monthKey,
      Value<int>? totalAmount,
      Value<int>? discountAmount,
      Value<int>? netAmount,
      Value<int>? paidAmount,
      Value<int>? dueAmount,
      Value<String>? status,
      Value<DateTime?>? dueDate,
      Value<DateTime>? createdAt}) {
    return FeeInvoicesCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      monthKey: monthKey ?? this.monthKey,
      totalAmount: totalAmount ?? this.totalAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      netAmount: netAmount ?? this.netAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      dueAmount: dueAmount ?? this.dueAmount,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (monthKey.present) {
      map['month_key'] = Variable<String>(monthKey.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<int>(totalAmount.value);
    }
    if (discountAmount.present) {
      map['discount_amount'] = Variable<int>(discountAmount.value);
    }
    if (netAmount.present) {
      map['net_amount'] = Variable<int>(netAmount.value);
    }
    if (paidAmount.present) {
      map['paid_amount'] = Variable<int>(paidAmount.value);
    }
    if (dueAmount.present) {
      map['due_amount'] = Variable<int>(dueAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeeInvoicesCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('monthKey: $monthKey, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('netAmount: $netAmount, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('dueAmount: $dueAmount, ')
          ..write('status: $status, ')
          ..write('dueDate: $dueDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $FeeInvoiceLinesTable extends FeeInvoiceLines
    with TableInfo<$FeeInvoiceLinesTable, FeeInvoiceLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeeInvoiceLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _invoiceIdMeta =
      const VerificationMeta('invoiceId');
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
      'invoice_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES fee_invoices (id)'));
  static const VerificationMeta _feeHeadIdMeta =
      const VerificationMeta('feeHeadId');
  @override
  late final GeneratedColumn<int> feeHeadId = GeneratedColumn<int>(
      'fee_head_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES fee_heads (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, invoiceId, feeHeadId, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fee_invoice_lines';
  @override
  VerificationContext validateIntegrity(Insertable<FeeInvoiceLine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(_invoiceIdMeta,
          invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta));
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('fee_head_id')) {
      context.handle(
          _feeHeadIdMeta,
          feeHeadId.isAcceptableOrUnknown(
              data['fee_head_id']!, _feeHeadIdMeta));
    } else if (isInserting) {
      context.missing(_feeHeadIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeeInvoiceLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeeInvoiceLine(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      invoiceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}invoice_id'])!,
      feeHeadId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fee_head_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
    );
  }

  @override
  $FeeInvoiceLinesTable createAlias(String alias) {
    return $FeeInvoiceLinesTable(attachedDatabase, alias);
  }
}

class FeeInvoiceLine extends DataClass implements Insertable<FeeInvoiceLine> {
  final int id;
  final int invoiceId;
  final int feeHeadId;
  final int amount;
  const FeeInvoiceLine(
      {required this.id,
      required this.invoiceId,
      required this.feeHeadId,
      required this.amount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['fee_head_id'] = Variable<int>(feeHeadId);
    map['amount'] = Variable<int>(amount);
    return map;
  }

  FeeInvoiceLinesCompanion toCompanion(bool nullToAbsent) {
    return FeeInvoiceLinesCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      feeHeadId: Value(feeHeadId),
      amount: Value(amount),
    );
  }

  factory FeeInvoiceLine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeeInvoiceLine(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      feeHeadId: serializer.fromJson<int>(json['feeHeadId']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'feeHeadId': serializer.toJson<int>(feeHeadId),
      'amount': serializer.toJson<int>(amount),
    };
  }

  FeeInvoiceLine copyWith(
          {int? id, int? invoiceId, int? feeHeadId, int? amount}) =>
      FeeInvoiceLine(
        id: id ?? this.id,
        invoiceId: invoiceId ?? this.invoiceId,
        feeHeadId: feeHeadId ?? this.feeHeadId,
        amount: amount ?? this.amount,
      );
  FeeInvoiceLine copyWithCompanion(FeeInvoiceLinesCompanion data) {
    return FeeInvoiceLine(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      feeHeadId: data.feeHeadId.present ? data.feeHeadId.value : this.feeHeadId,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeeInvoiceLine(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('feeHeadId: $feeHeadId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, invoiceId, feeHeadId, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeeInvoiceLine &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.feeHeadId == this.feeHeadId &&
          other.amount == this.amount);
}

class FeeInvoiceLinesCompanion extends UpdateCompanion<FeeInvoiceLine> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<int> feeHeadId;
  final Value<int> amount;
  const FeeInvoiceLinesCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.feeHeadId = const Value.absent(),
    this.amount = const Value.absent(),
  });
  FeeInvoiceLinesCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required int feeHeadId,
    required int amount,
  })  : invoiceId = Value(invoiceId),
        feeHeadId = Value(feeHeadId),
        amount = Value(amount);
  static Insertable<FeeInvoiceLine> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<int>? feeHeadId,
    Expression<int>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (feeHeadId != null) 'fee_head_id': feeHeadId,
      if (amount != null) 'amount': amount,
    });
  }

  FeeInvoiceLinesCompanion copyWith(
      {Value<int>? id,
      Value<int>? invoiceId,
      Value<int>? feeHeadId,
      Value<int>? amount}) {
    return FeeInvoiceLinesCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      feeHeadId: feeHeadId ?? this.feeHeadId,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (feeHeadId.present) {
      map['fee_head_id'] = Variable<int>(feeHeadId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeeInvoiceLinesCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('feeHeadId: $feeHeadId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $FeePaymentsTable extends FeePayments
    with TableInfo<$FeePaymentsTable, FeePayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeePaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _studentIdMeta =
      const VerificationMeta('studentId');
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
      'student_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES students (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
      'method', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('cash'));
  static const VerificationMeta _referenceNoMeta =
      const VerificationMeta('referenceNo');
  @override
  late final GeneratedColumn<String> referenceNo = GeneratedColumn<String>(
      'reference_no', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
      'paid_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _receivedByMeta =
      const VerificationMeta('receivedBy');
  @override
  late final GeneratedColumn<int> receivedBy = GeneratedColumn<int>(
      'received_by', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, studentId, amount, method, referenceNo, paidAt, receivedBy];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fee_payments';
  @override
  VerificationContext validateIntegrity(Insertable<FeePayment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(_studentIdMeta,
          studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta));
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('method')) {
      context.handle(_methodMeta,
          method.isAcceptableOrUnknown(data['method']!, _methodMeta));
    }
    if (data.containsKey('reference_no')) {
      context.handle(
          _referenceNoMeta,
          referenceNo.isAcceptableOrUnknown(
              data['reference_no']!, _referenceNoMeta));
    }
    if (data.containsKey('paid_at')) {
      context.handle(_paidAtMeta,
          paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta));
    }
    if (data.containsKey('received_by')) {
      context.handle(
          _receivedByMeta,
          receivedBy.isAcceptableOrUnknown(
              data['received_by']!, _receivedByMeta));
    } else if (isInserting) {
      context.missing(_receivedByMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeePayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeePayment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      studentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}student_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      method: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}method'])!,
      referenceNo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference_no']),
      paidAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}paid_at'])!,
      receivedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}received_by'])!,
    );
  }

  @override
  $FeePaymentsTable createAlias(String alias) {
    return $FeePaymentsTable(attachedDatabase, alias);
  }
}

class FeePayment extends DataClass implements Insertable<FeePayment> {
  final int id;
  final int studentId;
  final int amount;
  final String method;
  final String? referenceNo;
  final DateTime paidAt;
  final int receivedBy;
  const FeePayment(
      {required this.id,
      required this.studentId,
      required this.amount,
      required this.method,
      this.referenceNo,
      required this.paidAt,
      required this.receivedBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['amount'] = Variable<int>(amount);
    map['method'] = Variable<String>(method);
    if (!nullToAbsent || referenceNo != null) {
      map['reference_no'] = Variable<String>(referenceNo);
    }
    map['paid_at'] = Variable<DateTime>(paidAt);
    map['received_by'] = Variable<int>(receivedBy);
    return map;
  }

  FeePaymentsCompanion toCompanion(bool nullToAbsent) {
    return FeePaymentsCompanion(
      id: Value(id),
      studentId: Value(studentId),
      amount: Value(amount),
      method: Value(method),
      referenceNo: referenceNo == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceNo),
      paidAt: Value(paidAt),
      receivedBy: Value(receivedBy),
    );
  }

  factory FeePayment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeePayment(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      amount: serializer.fromJson<int>(json['amount']),
      method: serializer.fromJson<String>(json['method']),
      referenceNo: serializer.fromJson<String?>(json['referenceNo']),
      paidAt: serializer.fromJson<DateTime>(json['paidAt']),
      receivedBy: serializer.fromJson<int>(json['receivedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'amount': serializer.toJson<int>(amount),
      'method': serializer.toJson<String>(method),
      'referenceNo': serializer.toJson<String?>(referenceNo),
      'paidAt': serializer.toJson<DateTime>(paidAt),
      'receivedBy': serializer.toJson<int>(receivedBy),
    };
  }

  FeePayment copyWith(
          {int? id,
          int? studentId,
          int? amount,
          String? method,
          Value<String?> referenceNo = const Value.absent(),
          DateTime? paidAt,
          int? receivedBy}) =>
      FeePayment(
        id: id ?? this.id,
        studentId: studentId ?? this.studentId,
        amount: amount ?? this.amount,
        method: method ?? this.method,
        referenceNo: referenceNo.present ? referenceNo.value : this.referenceNo,
        paidAt: paidAt ?? this.paidAt,
        receivedBy: receivedBy ?? this.receivedBy,
      );
  FeePayment copyWithCompanion(FeePaymentsCompanion data) {
    return FeePayment(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      amount: data.amount.present ? data.amount.value : this.amount,
      method: data.method.present ? data.method.value : this.method,
      referenceNo:
          data.referenceNo.present ? data.referenceNo.value : this.referenceNo,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
      receivedBy:
          data.receivedBy.present ? data.receivedBy.value : this.receivedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeePayment(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('amount: $amount, ')
          ..write('method: $method, ')
          ..write('referenceNo: $referenceNo, ')
          ..write('paidAt: $paidAt, ')
          ..write('receivedBy: $receivedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, studentId, amount, method, referenceNo, paidAt, receivedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeePayment &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.amount == this.amount &&
          other.method == this.method &&
          other.referenceNo == this.referenceNo &&
          other.paidAt == this.paidAt &&
          other.receivedBy == this.receivedBy);
}

class FeePaymentsCompanion extends UpdateCompanion<FeePayment> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int> amount;
  final Value<String> method;
  final Value<String?> referenceNo;
  final Value<DateTime> paidAt;
  final Value<int> receivedBy;
  const FeePaymentsCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.amount = const Value.absent(),
    this.method = const Value.absent(),
    this.referenceNo = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.receivedBy = const Value.absent(),
  });
  FeePaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required int amount,
    this.method = const Value.absent(),
    this.referenceNo = const Value.absent(),
    this.paidAt = const Value.absent(),
    required int receivedBy,
  })  : studentId = Value(studentId),
        amount = Value(amount),
        receivedBy = Value(receivedBy);
  static Insertable<FeePayment> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? amount,
    Expression<String>? method,
    Expression<String>? referenceNo,
    Expression<DateTime>? paidAt,
    Expression<int>? receivedBy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (amount != null) 'amount': amount,
      if (method != null) 'method': method,
      if (referenceNo != null) 'reference_no': referenceNo,
      if (paidAt != null) 'paid_at': paidAt,
      if (receivedBy != null) 'received_by': receivedBy,
    });
  }

  FeePaymentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? studentId,
      Value<int>? amount,
      Value<String>? method,
      Value<String?>? referenceNo,
      Value<DateTime>? paidAt,
      Value<int>? receivedBy}) {
    return FeePaymentsCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      amount: amount ?? this.amount,
      method: method ?? this.method,
      referenceNo: referenceNo ?? this.referenceNo,
      paidAt: paidAt ?? this.paidAt,
      receivedBy: receivedBy ?? this.receivedBy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (referenceNo.present) {
      map['reference_no'] = Variable<String>(referenceNo.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    if (receivedBy.present) {
      map['received_by'] = Variable<int>(receivedBy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeePaymentsCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('amount: $amount, ')
          ..write('method: $method, ')
          ..write('referenceNo: $referenceNo, ')
          ..write('paidAt: $paidAt, ')
          ..write('receivedBy: $receivedBy')
          ..write(')'))
        .toString();
  }
}

class $FeePaymentAllocationsTable extends FeePaymentAllocations
    with TableInfo<$FeePaymentAllocationsTable, FeePaymentAllocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeePaymentAllocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _paymentIdMeta =
      const VerificationMeta('paymentId');
  @override
  late final GeneratedColumn<int> paymentId = GeneratedColumn<int>(
      'payment_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES fee_payments (id)'));
  static const VerificationMeta _invoiceIdMeta =
      const VerificationMeta('invoiceId');
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
      'invoice_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES fee_invoices (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, paymentId, invoiceId, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fee_payment_allocations';
  @override
  VerificationContext validateIntegrity(
      Insertable<FeePaymentAllocation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('payment_id')) {
      context.handle(_paymentIdMeta,
          paymentId.isAcceptableOrUnknown(data['payment_id']!, _paymentIdMeta));
    } else if (isInserting) {
      context.missing(_paymentIdMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(_invoiceIdMeta,
          invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta));
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeePaymentAllocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeePaymentAllocation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      paymentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_id'])!,
      invoiceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}invoice_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
    );
  }

  @override
  $FeePaymentAllocationsTable createAlias(String alias) {
    return $FeePaymentAllocationsTable(attachedDatabase, alias);
  }
}

class FeePaymentAllocation extends DataClass
    implements Insertable<FeePaymentAllocation> {
  final int id;
  final int paymentId;
  final int invoiceId;
  final int amount;
  const FeePaymentAllocation(
      {required this.id,
      required this.paymentId,
      required this.invoiceId,
      required this.amount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['payment_id'] = Variable<int>(paymentId);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['amount'] = Variable<int>(amount);
    return map;
  }

  FeePaymentAllocationsCompanion toCompanion(bool nullToAbsent) {
    return FeePaymentAllocationsCompanion(
      id: Value(id),
      paymentId: Value(paymentId),
      invoiceId: Value(invoiceId),
      amount: Value(amount),
    );
  }

  factory FeePaymentAllocation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeePaymentAllocation(
      id: serializer.fromJson<int>(json['id']),
      paymentId: serializer.fromJson<int>(json['paymentId']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'paymentId': serializer.toJson<int>(paymentId),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'amount': serializer.toJson<int>(amount),
    };
  }

  FeePaymentAllocation copyWith(
          {int? id, int? paymentId, int? invoiceId, int? amount}) =>
      FeePaymentAllocation(
        id: id ?? this.id,
        paymentId: paymentId ?? this.paymentId,
        invoiceId: invoiceId ?? this.invoiceId,
        amount: amount ?? this.amount,
      );
  FeePaymentAllocation copyWithCompanion(FeePaymentAllocationsCompanion data) {
    return FeePaymentAllocation(
      id: data.id.present ? data.id.value : this.id,
      paymentId: data.paymentId.present ? data.paymentId.value : this.paymentId,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeePaymentAllocation(')
          ..write('id: $id, ')
          ..write('paymentId: $paymentId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, paymentId, invoiceId, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeePaymentAllocation &&
          other.id == this.id &&
          other.paymentId == this.paymentId &&
          other.invoiceId == this.invoiceId &&
          other.amount == this.amount);
}

class FeePaymentAllocationsCompanion
    extends UpdateCompanion<FeePaymentAllocation> {
  final Value<int> id;
  final Value<int> paymentId;
  final Value<int> invoiceId;
  final Value<int> amount;
  const FeePaymentAllocationsCompanion({
    this.id = const Value.absent(),
    this.paymentId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.amount = const Value.absent(),
  });
  FeePaymentAllocationsCompanion.insert({
    this.id = const Value.absent(),
    required int paymentId,
    required int invoiceId,
    required int amount,
  })  : paymentId = Value(paymentId),
        invoiceId = Value(invoiceId),
        amount = Value(amount);
  static Insertable<FeePaymentAllocation> custom({
    Expression<int>? id,
    Expression<int>? paymentId,
    Expression<int>? invoiceId,
    Expression<int>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (paymentId != null) 'payment_id': paymentId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (amount != null) 'amount': amount,
    });
  }

  FeePaymentAllocationsCompanion copyWith(
      {Value<int>? id,
      Value<int>? paymentId,
      Value<int>? invoiceId,
      Value<int>? amount}) {
    return FeePaymentAllocationsCompanion(
      id: id ?? this.id,
      paymentId: paymentId ?? this.paymentId,
      invoiceId: invoiceId ?? this.invoiceId,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (paymentId.present) {
      map['payment_id'] = Variable<int>(paymentId.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeePaymentAllocationsCompanion(')
          ..write('id: $id, ')
          ..write('paymentId: $paymentId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $StaffTable extends Staff with TableInfo<$StaffTable, StaffData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StaffTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _employeeCodeMeta =
      const VerificationMeta('employeeCode');
  @override
  late final GeneratedColumn<String> employeeCode = GeneratedColumn<String>(
      'employee_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _designationMeta =
      const VerificationMeta('designation');
  @override
  late final GeneratedColumn<String> designation = GeneratedColumn<String>(
      'designation', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Teacher'));
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _baseSalaryMeta =
      const VerificationMeta('baseSalary');
  @override
  late final GeneratedColumn<int> baseSalary = GeneratedColumn<int>(
      'base_salary', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _biometricEnabledMeta =
      const VerificationMeta('biometricEnabled');
  @override
  late final GeneratedColumn<bool> biometricEnabled = GeneratedColumn<bool>(
      'biometric_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("biometric_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _joiningDateMeta =
      const VerificationMeta('joiningDate');
  @override
  late final GeneratedColumn<DateTime> joiningDate = GeneratedColumn<DateTime>(
      'joining_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        employeeCode,
        fullName,
        designation,
        phone,
        baseSalary,
        biometricEnabled,
        isActive,
        joiningDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'staff';
  @override
  VerificationContext validateIntegrity(Insertable<StaffData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('employee_code')) {
      context.handle(
          _employeeCodeMeta,
          employeeCode.isAcceptableOrUnknown(
              data['employee_code']!, _employeeCodeMeta));
    } else if (isInserting) {
      context.missing(_employeeCodeMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('designation')) {
      context.handle(
          _designationMeta,
          designation.isAcceptableOrUnknown(
              data['designation']!, _designationMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('base_salary')) {
      context.handle(
          _baseSalaryMeta,
          baseSalary.isAcceptableOrUnknown(
              data['base_salary']!, _baseSalaryMeta));
    } else if (isInserting) {
      context.missing(_baseSalaryMeta);
    }
    if (data.containsKey('biometric_enabled')) {
      context.handle(
          _biometricEnabledMeta,
          biometricEnabled.isAcceptableOrUnknown(
              data['biometric_enabled']!, _biometricEnabledMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('joining_date')) {
      context.handle(
          _joiningDateMeta,
          joiningDate.isAcceptableOrUnknown(
              data['joining_date']!, _joiningDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StaffData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StaffData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      employeeCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_code'])!,
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      designation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}designation'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      baseSalary: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}base_salary'])!,
      biometricEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}biometric_enabled'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      joiningDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}joining_date'])!,
    );
  }

  @override
  $StaffTable createAlias(String alias) {
    return $StaffTable(attachedDatabase, alias);
  }
}

class StaffData extends DataClass implements Insertable<StaffData> {
  final int id;
  final String employeeCode;
  final String fullName;
  final String designation;
  final String? phone;
  final int baseSalary;
  final bool biometricEnabled;
  final bool isActive;
  final DateTime joiningDate;
  const StaffData(
      {required this.id,
      required this.employeeCode,
      required this.fullName,
      required this.designation,
      this.phone,
      required this.baseSalary,
      required this.biometricEnabled,
      required this.isActive,
      required this.joiningDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['employee_code'] = Variable<String>(employeeCode);
    map['full_name'] = Variable<String>(fullName);
    map['designation'] = Variable<String>(designation);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['base_salary'] = Variable<int>(baseSalary);
    map['biometric_enabled'] = Variable<bool>(biometricEnabled);
    map['is_active'] = Variable<bool>(isActive);
    map['joining_date'] = Variable<DateTime>(joiningDate);
    return map;
  }

  StaffCompanion toCompanion(bool nullToAbsent) {
    return StaffCompanion(
      id: Value(id),
      employeeCode: Value(employeeCode),
      fullName: Value(fullName),
      designation: Value(designation),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      baseSalary: Value(baseSalary),
      biometricEnabled: Value(biometricEnabled),
      isActive: Value(isActive),
      joiningDate: Value(joiningDate),
    );
  }

  factory StaffData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StaffData(
      id: serializer.fromJson<int>(json['id']),
      employeeCode: serializer.fromJson<String>(json['employeeCode']),
      fullName: serializer.fromJson<String>(json['fullName']),
      designation: serializer.fromJson<String>(json['designation']),
      phone: serializer.fromJson<String?>(json['phone']),
      baseSalary: serializer.fromJson<int>(json['baseSalary']),
      biometricEnabled: serializer.fromJson<bool>(json['biometricEnabled']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      joiningDate: serializer.fromJson<DateTime>(json['joiningDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'employeeCode': serializer.toJson<String>(employeeCode),
      'fullName': serializer.toJson<String>(fullName),
      'designation': serializer.toJson<String>(designation),
      'phone': serializer.toJson<String?>(phone),
      'baseSalary': serializer.toJson<int>(baseSalary),
      'biometricEnabled': serializer.toJson<bool>(biometricEnabled),
      'isActive': serializer.toJson<bool>(isActive),
      'joiningDate': serializer.toJson<DateTime>(joiningDate),
    };
  }

  StaffData copyWith(
          {int? id,
          String? employeeCode,
          String? fullName,
          String? designation,
          Value<String?> phone = const Value.absent(),
          int? baseSalary,
          bool? biometricEnabled,
          bool? isActive,
          DateTime? joiningDate}) =>
      StaffData(
        id: id ?? this.id,
        employeeCode: employeeCode ?? this.employeeCode,
        fullName: fullName ?? this.fullName,
        designation: designation ?? this.designation,
        phone: phone.present ? phone.value : this.phone,
        baseSalary: baseSalary ?? this.baseSalary,
        biometricEnabled: biometricEnabled ?? this.biometricEnabled,
        isActive: isActive ?? this.isActive,
        joiningDate: joiningDate ?? this.joiningDate,
      );
  StaffData copyWithCompanion(StaffCompanion data) {
    return StaffData(
      id: data.id.present ? data.id.value : this.id,
      employeeCode: data.employeeCode.present
          ? data.employeeCode.value
          : this.employeeCode,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      designation:
          data.designation.present ? data.designation.value : this.designation,
      phone: data.phone.present ? data.phone.value : this.phone,
      baseSalary:
          data.baseSalary.present ? data.baseSalary.value : this.baseSalary,
      biometricEnabled: data.biometricEnabled.present
          ? data.biometricEnabled.value
          : this.biometricEnabled,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      joiningDate:
          data.joiningDate.present ? data.joiningDate.value : this.joiningDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StaffData(')
          ..write('id: $id, ')
          ..write('employeeCode: $employeeCode, ')
          ..write('fullName: $fullName, ')
          ..write('designation: $designation, ')
          ..write('phone: $phone, ')
          ..write('baseSalary: $baseSalary, ')
          ..write('biometricEnabled: $biometricEnabled, ')
          ..write('isActive: $isActive, ')
          ..write('joiningDate: $joiningDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, employeeCode, fullName, designation,
      phone, baseSalary, biometricEnabled, isActive, joiningDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StaffData &&
          other.id == this.id &&
          other.employeeCode == this.employeeCode &&
          other.fullName == this.fullName &&
          other.designation == this.designation &&
          other.phone == this.phone &&
          other.baseSalary == this.baseSalary &&
          other.biometricEnabled == this.biometricEnabled &&
          other.isActive == this.isActive &&
          other.joiningDate == this.joiningDate);
}

class StaffCompanion extends UpdateCompanion<StaffData> {
  final Value<int> id;
  final Value<String> employeeCode;
  final Value<String> fullName;
  final Value<String> designation;
  final Value<String?> phone;
  final Value<int> baseSalary;
  final Value<bool> biometricEnabled;
  final Value<bool> isActive;
  final Value<DateTime> joiningDate;
  const StaffCompanion({
    this.id = const Value.absent(),
    this.employeeCode = const Value.absent(),
    this.fullName = const Value.absent(),
    this.designation = const Value.absent(),
    this.phone = const Value.absent(),
    this.baseSalary = const Value.absent(),
    this.biometricEnabled = const Value.absent(),
    this.isActive = const Value.absent(),
    this.joiningDate = const Value.absent(),
  });
  StaffCompanion.insert({
    this.id = const Value.absent(),
    required String employeeCode,
    required String fullName,
    this.designation = const Value.absent(),
    this.phone = const Value.absent(),
    required int baseSalary,
    this.biometricEnabled = const Value.absent(),
    this.isActive = const Value.absent(),
    this.joiningDate = const Value.absent(),
  })  : employeeCode = Value(employeeCode),
        fullName = Value(fullName),
        baseSalary = Value(baseSalary);
  static Insertable<StaffData> custom({
    Expression<int>? id,
    Expression<String>? employeeCode,
    Expression<String>? fullName,
    Expression<String>? designation,
    Expression<String>? phone,
    Expression<int>? baseSalary,
    Expression<bool>? biometricEnabled,
    Expression<bool>? isActive,
    Expression<DateTime>? joiningDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (employeeCode != null) 'employee_code': employeeCode,
      if (fullName != null) 'full_name': fullName,
      if (designation != null) 'designation': designation,
      if (phone != null) 'phone': phone,
      if (baseSalary != null) 'base_salary': baseSalary,
      if (biometricEnabled != null) 'biometric_enabled': biometricEnabled,
      if (isActive != null) 'is_active': isActive,
      if (joiningDate != null) 'joining_date': joiningDate,
    });
  }

  StaffCompanion copyWith(
      {Value<int>? id,
      Value<String>? employeeCode,
      Value<String>? fullName,
      Value<String>? designation,
      Value<String?>? phone,
      Value<int>? baseSalary,
      Value<bool>? biometricEnabled,
      Value<bool>? isActive,
      Value<DateTime>? joiningDate}) {
    return StaffCompanion(
      id: id ?? this.id,
      employeeCode: employeeCode ?? this.employeeCode,
      fullName: fullName ?? this.fullName,
      designation: designation ?? this.designation,
      phone: phone ?? this.phone,
      baseSalary: baseSalary ?? this.baseSalary,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      isActive: isActive ?? this.isActive,
      joiningDate: joiningDate ?? this.joiningDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (employeeCode.present) {
      map['employee_code'] = Variable<String>(employeeCode.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (designation.present) {
      map['designation'] = Variable<String>(designation.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (baseSalary.present) {
      map['base_salary'] = Variable<int>(baseSalary.value);
    }
    if (biometricEnabled.present) {
      map['biometric_enabled'] = Variable<bool>(biometricEnabled.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (joiningDate.present) {
      map['joining_date'] = Variable<DateTime>(joiningDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StaffCompanion(')
          ..write('id: $id, ')
          ..write('employeeCode: $employeeCode, ')
          ..write('fullName: $fullName, ')
          ..write('designation: $designation, ')
          ..write('phone: $phone, ')
          ..write('baseSalary: $baseSalary, ')
          ..write('biometricEnabled: $biometricEnabled, ')
          ..write('isActive: $isActive, ')
          ..write('joiningDate: $joiningDate')
          ..write(')'))
        .toString();
  }
}

class $StaffAttendanceTable extends StaffAttendance
    with TableInfo<$StaffAttendanceTable, StaffAttendanceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StaffAttendanceTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _staffIdMeta =
      const VerificationMeta('staffId');
  @override
  late final GeneratedColumn<int> staffId = GeneratedColumn<int>(
      'staff_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES staff (id)'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('present'));
  static const VerificationMeta _biometricVerifiedMeta =
      const VerificationMeta('biometricVerified');
  @override
  late final GeneratedColumn<bool> biometricVerified = GeneratedColumn<bool>(
      'biometric_verified', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("biometric_verified" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, staffId, date, status, biometricVerified, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'staff_attendance';
  @override
  VerificationContext validateIntegrity(
      Insertable<StaffAttendanceData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('staff_id')) {
      context.handle(_staffIdMeta,
          staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta));
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('biometric_verified')) {
      context.handle(
          _biometricVerifiedMeta,
          biometricVerified.isAcceptableOrUnknown(
              data['biometric_verified']!, _biometricVerifiedMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StaffAttendanceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StaffAttendanceData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      staffId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}staff_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      biometricVerified: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}biometric_verified'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $StaffAttendanceTable createAlias(String alias) {
    return $StaffAttendanceTable(attachedDatabase, alias);
  }
}

class StaffAttendanceData extends DataClass
    implements Insertable<StaffAttendanceData> {
  final int id;
  final int staffId;
  final DateTime date;
  final String status;
  final bool biometricVerified;
  final String? note;
  const StaffAttendanceData(
      {required this.id,
      required this.staffId,
      required this.date,
      required this.status,
      required this.biometricVerified,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['staff_id'] = Variable<int>(staffId);
    map['date'] = Variable<DateTime>(date);
    map['status'] = Variable<String>(status);
    map['biometric_verified'] = Variable<bool>(biometricVerified);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  StaffAttendanceCompanion toCompanion(bool nullToAbsent) {
    return StaffAttendanceCompanion(
      id: Value(id),
      staffId: Value(staffId),
      date: Value(date),
      status: Value(status),
      biometricVerified: Value(biometricVerified),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory StaffAttendanceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StaffAttendanceData(
      id: serializer.fromJson<int>(json['id']),
      staffId: serializer.fromJson<int>(json['staffId']),
      date: serializer.fromJson<DateTime>(json['date']),
      status: serializer.fromJson<String>(json['status']),
      biometricVerified: serializer.fromJson<bool>(json['biometricVerified']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'staffId': serializer.toJson<int>(staffId),
      'date': serializer.toJson<DateTime>(date),
      'status': serializer.toJson<String>(status),
      'biometricVerified': serializer.toJson<bool>(biometricVerified),
      'note': serializer.toJson<String?>(note),
    };
  }

  StaffAttendanceData copyWith(
          {int? id,
          int? staffId,
          DateTime? date,
          String? status,
          bool? biometricVerified,
          Value<String?> note = const Value.absent()}) =>
      StaffAttendanceData(
        id: id ?? this.id,
        staffId: staffId ?? this.staffId,
        date: date ?? this.date,
        status: status ?? this.status,
        biometricVerified: biometricVerified ?? this.biometricVerified,
        note: note.present ? note.value : this.note,
      );
  StaffAttendanceData copyWithCompanion(StaffAttendanceCompanion data) {
    return StaffAttendanceData(
      id: data.id.present ? data.id.value : this.id,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      biometricVerified: data.biometricVerified.present
          ? data.biometricVerified.value
          : this.biometricVerified,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StaffAttendanceData(')
          ..write('id: $id, ')
          ..write('staffId: $staffId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('biometricVerified: $biometricVerified, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, staffId, date, status, biometricVerified, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StaffAttendanceData &&
          other.id == this.id &&
          other.staffId == this.staffId &&
          other.date == this.date &&
          other.status == this.status &&
          other.biometricVerified == this.biometricVerified &&
          other.note == this.note);
}

class StaffAttendanceCompanion extends UpdateCompanion<StaffAttendanceData> {
  final Value<int> id;
  final Value<int> staffId;
  final Value<DateTime> date;
  final Value<String> status;
  final Value<bool> biometricVerified;
  final Value<String?> note;
  const StaffAttendanceCompanion({
    this.id = const Value.absent(),
    this.staffId = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.biometricVerified = const Value.absent(),
    this.note = const Value.absent(),
  });
  StaffAttendanceCompanion.insert({
    this.id = const Value.absent(),
    required int staffId,
    required DateTime date,
    this.status = const Value.absent(),
    this.biometricVerified = const Value.absent(),
    this.note = const Value.absent(),
  })  : staffId = Value(staffId),
        date = Value(date);
  static Insertable<StaffAttendanceData> custom({
    Expression<int>? id,
    Expression<int>? staffId,
    Expression<DateTime>? date,
    Expression<String>? status,
    Expression<bool>? biometricVerified,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (staffId != null) 'staff_id': staffId,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (biometricVerified != null) 'biometric_verified': biometricVerified,
      if (note != null) 'note': note,
    });
  }

  StaffAttendanceCompanion copyWith(
      {Value<int>? id,
      Value<int>? staffId,
      Value<DateTime>? date,
      Value<String>? status,
      Value<bool>? biometricVerified,
      Value<String?>? note}) {
    return StaffAttendanceCompanion(
      id: id ?? this.id,
      staffId: staffId ?? this.staffId,
      date: date ?? this.date,
      status: status ?? this.status,
      biometricVerified: biometricVerified ?? this.biometricVerified,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<int>(staffId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (biometricVerified.present) {
      map['biometric_verified'] = Variable<bool>(biometricVerified.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StaffAttendanceCompanion(')
          ..write('id: $id, ')
          ..write('staffId: $staffId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('biometricVerified: $biometricVerified, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $SalaryAdvancesTable extends SalaryAdvances
    with TableInfo<$SalaryAdvancesTable, SalaryAdvance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalaryAdvancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _staffIdMeta =
      const VerificationMeta('staffId');
  @override
  late final GeneratedColumn<int> staffId = GeneratedColumn<int>(
      'staff_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES staff (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _deductedMeta =
      const VerificationMeta('deducted');
  @override
  late final GeneratedColumn<bool> deducted = GeneratedColumn<bool>(
      'deducted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("deducted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _advancedAtMeta =
      const VerificationMeta('advancedAt');
  @override
  late final GeneratedColumn<DateTime> advancedAt = GeneratedColumn<DateTime>(
      'advanced_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, staffId, amount, deducted, advancedAt, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'salary_advances';
  @override
  VerificationContext validateIntegrity(Insertable<SalaryAdvance> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('staff_id')) {
      context.handle(_staffIdMeta,
          staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta));
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('deducted')) {
      context.handle(_deductedMeta,
          deducted.isAcceptableOrUnknown(data['deducted']!, _deductedMeta));
    }
    if (data.containsKey('advanced_at')) {
      context.handle(
          _advancedAtMeta,
          advancedAt.isAcceptableOrUnknown(
              data['advanced_at']!, _advancedAtMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalaryAdvance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalaryAdvance(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      staffId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}staff_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      deducted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}deducted'])!,
      advancedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}advanced_at'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $SalaryAdvancesTable createAlias(String alias) {
    return $SalaryAdvancesTable(attachedDatabase, alias);
  }
}

class SalaryAdvance extends DataClass implements Insertable<SalaryAdvance> {
  final int id;
  final int staffId;
  final int amount;
  final bool deducted;
  final DateTime advancedAt;
  final String? note;
  const SalaryAdvance(
      {required this.id,
      required this.staffId,
      required this.amount,
      required this.deducted,
      required this.advancedAt,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['staff_id'] = Variable<int>(staffId);
    map['amount'] = Variable<int>(amount);
    map['deducted'] = Variable<bool>(deducted);
    map['advanced_at'] = Variable<DateTime>(advancedAt);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  SalaryAdvancesCompanion toCompanion(bool nullToAbsent) {
    return SalaryAdvancesCompanion(
      id: Value(id),
      staffId: Value(staffId),
      amount: Value(amount),
      deducted: Value(deducted),
      advancedAt: Value(advancedAt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory SalaryAdvance.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalaryAdvance(
      id: serializer.fromJson<int>(json['id']),
      staffId: serializer.fromJson<int>(json['staffId']),
      amount: serializer.fromJson<int>(json['amount']),
      deducted: serializer.fromJson<bool>(json['deducted']),
      advancedAt: serializer.fromJson<DateTime>(json['advancedAt']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'staffId': serializer.toJson<int>(staffId),
      'amount': serializer.toJson<int>(amount),
      'deducted': serializer.toJson<bool>(deducted),
      'advancedAt': serializer.toJson<DateTime>(advancedAt),
      'note': serializer.toJson<String?>(note),
    };
  }

  SalaryAdvance copyWith(
          {int? id,
          int? staffId,
          int? amount,
          bool? deducted,
          DateTime? advancedAt,
          Value<String?> note = const Value.absent()}) =>
      SalaryAdvance(
        id: id ?? this.id,
        staffId: staffId ?? this.staffId,
        amount: amount ?? this.amount,
        deducted: deducted ?? this.deducted,
        advancedAt: advancedAt ?? this.advancedAt,
        note: note.present ? note.value : this.note,
      );
  SalaryAdvance copyWithCompanion(SalaryAdvancesCompanion data) {
    return SalaryAdvance(
      id: data.id.present ? data.id.value : this.id,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      amount: data.amount.present ? data.amount.value : this.amount,
      deducted: data.deducted.present ? data.deducted.value : this.deducted,
      advancedAt:
          data.advancedAt.present ? data.advancedAt.value : this.advancedAt,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalaryAdvance(')
          ..write('id: $id, ')
          ..write('staffId: $staffId, ')
          ..write('amount: $amount, ')
          ..write('deducted: $deducted, ')
          ..write('advancedAt: $advancedAt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, staffId, amount, deducted, advancedAt, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalaryAdvance &&
          other.id == this.id &&
          other.staffId == this.staffId &&
          other.amount == this.amount &&
          other.deducted == this.deducted &&
          other.advancedAt == this.advancedAt &&
          other.note == this.note);
}

class SalaryAdvancesCompanion extends UpdateCompanion<SalaryAdvance> {
  final Value<int> id;
  final Value<int> staffId;
  final Value<int> amount;
  final Value<bool> deducted;
  final Value<DateTime> advancedAt;
  final Value<String?> note;
  const SalaryAdvancesCompanion({
    this.id = const Value.absent(),
    this.staffId = const Value.absent(),
    this.amount = const Value.absent(),
    this.deducted = const Value.absent(),
    this.advancedAt = const Value.absent(),
    this.note = const Value.absent(),
  });
  SalaryAdvancesCompanion.insert({
    this.id = const Value.absent(),
    required int staffId,
    required int amount,
    this.deducted = const Value.absent(),
    this.advancedAt = const Value.absent(),
    this.note = const Value.absent(),
  })  : staffId = Value(staffId),
        amount = Value(amount);
  static Insertable<SalaryAdvance> custom({
    Expression<int>? id,
    Expression<int>? staffId,
    Expression<int>? amount,
    Expression<bool>? deducted,
    Expression<DateTime>? advancedAt,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (staffId != null) 'staff_id': staffId,
      if (amount != null) 'amount': amount,
      if (deducted != null) 'deducted': deducted,
      if (advancedAt != null) 'advanced_at': advancedAt,
      if (note != null) 'note': note,
    });
  }

  SalaryAdvancesCompanion copyWith(
      {Value<int>? id,
      Value<int>? staffId,
      Value<int>? amount,
      Value<bool>? deducted,
      Value<DateTime>? advancedAt,
      Value<String?>? note}) {
    return SalaryAdvancesCompanion(
      id: id ?? this.id,
      staffId: staffId ?? this.staffId,
      amount: amount ?? this.amount,
      deducted: deducted ?? this.deducted,
      advancedAt: advancedAt ?? this.advancedAt,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<int>(staffId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (deducted.present) {
      map['deducted'] = Variable<bool>(deducted.value);
    }
    if (advancedAt.present) {
      map['advanced_at'] = Variable<DateTime>(advancedAt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalaryAdvancesCompanion(')
          ..write('id: $id, ')
          ..write('staffId: $staffId, ')
          ..write('amount: $amount, ')
          ..write('deducted: $deducted, ')
          ..write('advancedAt: $advancedAt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $PayrollRunsTable extends PayrollRuns
    with TableInfo<$PayrollRunsTable, PayrollRun> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PayrollRunsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _monthKeyMeta =
      const VerificationMeta('monthKey');
  @override
  late final GeneratedColumn<String> monthKey = GeneratedColumn<String>(
      'month_key', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _generatedAtMeta =
      const VerificationMeta('generatedAt');
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
      'generated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _generatedByMeta =
      const VerificationMeta('generatedBy');
  @override
  late final GeneratedColumn<int> generatedBy = GeneratedColumn<int>(
      'generated_by', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, monthKey, generatedAt, generatedBy];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payroll_runs';
  @override
  VerificationContext validateIntegrity(Insertable<PayrollRun> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('month_key')) {
      context.handle(_monthKeyMeta,
          monthKey.isAcceptableOrUnknown(data['month_key']!, _monthKeyMeta));
    } else if (isInserting) {
      context.missing(_monthKeyMeta);
    }
    if (data.containsKey('generated_at')) {
      context.handle(
          _generatedAtMeta,
          generatedAt.isAcceptableOrUnknown(
              data['generated_at']!, _generatedAtMeta));
    }
    if (data.containsKey('generated_by')) {
      context.handle(
          _generatedByMeta,
          generatedBy.isAcceptableOrUnknown(
              data['generated_by']!, _generatedByMeta));
    } else if (isInserting) {
      context.missing(_generatedByMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PayrollRun map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PayrollRun(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      monthKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}month_key'])!,
      generatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}generated_at'])!,
      generatedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}generated_by'])!,
    );
  }

  @override
  $PayrollRunsTable createAlias(String alias) {
    return $PayrollRunsTable(attachedDatabase, alias);
  }
}

class PayrollRun extends DataClass implements Insertable<PayrollRun> {
  final int id;
  final String monthKey;
  final DateTime generatedAt;
  final int generatedBy;
  const PayrollRun(
      {required this.id,
      required this.monthKey,
      required this.generatedAt,
      required this.generatedBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['month_key'] = Variable<String>(monthKey);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    map['generated_by'] = Variable<int>(generatedBy);
    return map;
  }

  PayrollRunsCompanion toCompanion(bool nullToAbsent) {
    return PayrollRunsCompanion(
      id: Value(id),
      monthKey: Value(monthKey),
      generatedAt: Value(generatedAt),
      generatedBy: Value(generatedBy),
    );
  }

  factory PayrollRun.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PayrollRun(
      id: serializer.fromJson<int>(json['id']),
      monthKey: serializer.fromJson<String>(json['monthKey']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
      generatedBy: serializer.fromJson<int>(json['generatedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'monthKey': serializer.toJson<String>(monthKey),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
      'generatedBy': serializer.toJson<int>(generatedBy),
    };
  }

  PayrollRun copyWith(
          {int? id,
          String? monthKey,
          DateTime? generatedAt,
          int? generatedBy}) =>
      PayrollRun(
        id: id ?? this.id,
        monthKey: monthKey ?? this.monthKey,
        generatedAt: generatedAt ?? this.generatedAt,
        generatedBy: generatedBy ?? this.generatedBy,
      );
  PayrollRun copyWithCompanion(PayrollRunsCompanion data) {
    return PayrollRun(
      id: data.id.present ? data.id.value : this.id,
      monthKey: data.monthKey.present ? data.monthKey.value : this.monthKey,
      generatedAt:
          data.generatedAt.present ? data.generatedAt.value : this.generatedAt,
      generatedBy:
          data.generatedBy.present ? data.generatedBy.value : this.generatedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PayrollRun(')
          ..write('id: $id, ')
          ..write('monthKey: $monthKey, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('generatedBy: $generatedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, monthKey, generatedAt, generatedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PayrollRun &&
          other.id == this.id &&
          other.monthKey == this.monthKey &&
          other.generatedAt == this.generatedAt &&
          other.generatedBy == this.generatedBy);
}

class PayrollRunsCompanion extends UpdateCompanion<PayrollRun> {
  final Value<int> id;
  final Value<String> monthKey;
  final Value<DateTime> generatedAt;
  final Value<int> generatedBy;
  const PayrollRunsCompanion({
    this.id = const Value.absent(),
    this.monthKey = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.generatedBy = const Value.absent(),
  });
  PayrollRunsCompanion.insert({
    this.id = const Value.absent(),
    required String monthKey,
    this.generatedAt = const Value.absent(),
    required int generatedBy,
  })  : monthKey = Value(monthKey),
        generatedBy = Value(generatedBy);
  static Insertable<PayrollRun> custom({
    Expression<int>? id,
    Expression<String>? monthKey,
    Expression<DateTime>? generatedAt,
    Expression<int>? generatedBy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (monthKey != null) 'month_key': monthKey,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (generatedBy != null) 'generated_by': generatedBy,
    });
  }

  PayrollRunsCompanion copyWith(
      {Value<int>? id,
      Value<String>? monthKey,
      Value<DateTime>? generatedAt,
      Value<int>? generatedBy}) {
    return PayrollRunsCompanion(
      id: id ?? this.id,
      monthKey: monthKey ?? this.monthKey,
      generatedAt: generatedAt ?? this.generatedAt,
      generatedBy: generatedBy ?? this.generatedBy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (monthKey.present) {
      map['month_key'] = Variable<String>(monthKey.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (generatedBy.present) {
      map['generated_by'] = Variable<int>(generatedBy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PayrollRunsCompanion(')
          ..write('id: $id, ')
          ..write('monthKey: $monthKey, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('generatedBy: $generatedBy')
          ..write(')'))
        .toString();
  }
}

class $PayrollLinesTable extends PayrollLines
    with TableInfo<$PayrollLinesTable, PayrollLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PayrollLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _payrollRunIdMeta =
      const VerificationMeta('payrollRunId');
  @override
  late final GeneratedColumn<int> payrollRunId = GeneratedColumn<int>(
      'payroll_run_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES payroll_runs (id)'));
  static const VerificationMeta _staffIdMeta =
      const VerificationMeta('staffId');
  @override
  late final GeneratedColumn<int> staffId = GeneratedColumn<int>(
      'staff_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES staff (id)'));
  static const VerificationMeta _grossPayMeta =
      const VerificationMeta('grossPay');
  @override
  late final GeneratedColumn<int> grossPay = GeneratedColumn<int>(
      'gross_pay', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _advanceDeductionMeta =
      const VerificationMeta('advanceDeduction');
  @override
  late final GeneratedColumn<int> advanceDeduction = GeneratedColumn<int>(
      'advance_deduction', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _absentDeductionMeta =
      const VerificationMeta('absentDeduction');
  @override
  late final GeneratedColumn<int> absentDeduction = GeneratedColumn<int>(
      'absent_deduction', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _netPayMeta = const VerificationMeta('netPay');
  @override
  late final GeneratedColumn<int> netPay = GeneratedColumn<int>(
      'net_pay', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        payrollRunId,
        staffId,
        grossPay,
        advanceDeduction,
        absentDeduction,
        netPay,
        status
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payroll_lines';
  @override
  VerificationContext validateIntegrity(Insertable<PayrollLine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('payroll_run_id')) {
      context.handle(
          _payrollRunIdMeta,
          payrollRunId.isAcceptableOrUnknown(
              data['payroll_run_id']!, _payrollRunIdMeta));
    } else if (isInserting) {
      context.missing(_payrollRunIdMeta);
    }
    if (data.containsKey('staff_id')) {
      context.handle(_staffIdMeta,
          staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta));
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('gross_pay')) {
      context.handle(_grossPayMeta,
          grossPay.isAcceptableOrUnknown(data['gross_pay']!, _grossPayMeta));
    } else if (isInserting) {
      context.missing(_grossPayMeta);
    }
    if (data.containsKey('advance_deduction')) {
      context.handle(
          _advanceDeductionMeta,
          advanceDeduction.isAcceptableOrUnknown(
              data['advance_deduction']!, _advanceDeductionMeta));
    }
    if (data.containsKey('absent_deduction')) {
      context.handle(
          _absentDeductionMeta,
          absentDeduction.isAcceptableOrUnknown(
              data['absent_deduction']!, _absentDeductionMeta));
    }
    if (data.containsKey('net_pay')) {
      context.handle(_netPayMeta,
          netPay.isAcceptableOrUnknown(data['net_pay']!, _netPayMeta));
    } else if (isInserting) {
      context.missing(_netPayMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PayrollLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PayrollLine(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      payrollRunId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payroll_run_id'])!,
      staffId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}staff_id'])!,
      grossPay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gross_pay'])!,
      advanceDeduction: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}advance_deduction'])!,
      absentDeduction: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}absent_deduction'])!,
      netPay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}net_pay'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $PayrollLinesTable createAlias(String alias) {
    return $PayrollLinesTable(attachedDatabase, alias);
  }
}

class PayrollLine extends DataClass implements Insertable<PayrollLine> {
  final int id;
  final int payrollRunId;
  final int staffId;
  final int grossPay;
  final int advanceDeduction;
  final int absentDeduction;
  final int netPay;
  final String status;
  const PayrollLine(
      {required this.id,
      required this.payrollRunId,
      required this.staffId,
      required this.grossPay,
      required this.advanceDeduction,
      required this.absentDeduction,
      required this.netPay,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['payroll_run_id'] = Variable<int>(payrollRunId);
    map['staff_id'] = Variable<int>(staffId);
    map['gross_pay'] = Variable<int>(grossPay);
    map['advance_deduction'] = Variable<int>(advanceDeduction);
    map['absent_deduction'] = Variable<int>(absentDeduction);
    map['net_pay'] = Variable<int>(netPay);
    map['status'] = Variable<String>(status);
    return map;
  }

  PayrollLinesCompanion toCompanion(bool nullToAbsent) {
    return PayrollLinesCompanion(
      id: Value(id),
      payrollRunId: Value(payrollRunId),
      staffId: Value(staffId),
      grossPay: Value(grossPay),
      advanceDeduction: Value(advanceDeduction),
      absentDeduction: Value(absentDeduction),
      netPay: Value(netPay),
      status: Value(status),
    );
  }

  factory PayrollLine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PayrollLine(
      id: serializer.fromJson<int>(json['id']),
      payrollRunId: serializer.fromJson<int>(json['payrollRunId']),
      staffId: serializer.fromJson<int>(json['staffId']),
      grossPay: serializer.fromJson<int>(json['grossPay']),
      advanceDeduction: serializer.fromJson<int>(json['advanceDeduction']),
      absentDeduction: serializer.fromJson<int>(json['absentDeduction']),
      netPay: serializer.fromJson<int>(json['netPay']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'payrollRunId': serializer.toJson<int>(payrollRunId),
      'staffId': serializer.toJson<int>(staffId),
      'grossPay': serializer.toJson<int>(grossPay),
      'advanceDeduction': serializer.toJson<int>(advanceDeduction),
      'absentDeduction': serializer.toJson<int>(absentDeduction),
      'netPay': serializer.toJson<int>(netPay),
      'status': serializer.toJson<String>(status),
    };
  }

  PayrollLine copyWith(
          {int? id,
          int? payrollRunId,
          int? staffId,
          int? grossPay,
          int? advanceDeduction,
          int? absentDeduction,
          int? netPay,
          String? status}) =>
      PayrollLine(
        id: id ?? this.id,
        payrollRunId: payrollRunId ?? this.payrollRunId,
        staffId: staffId ?? this.staffId,
        grossPay: grossPay ?? this.grossPay,
        advanceDeduction: advanceDeduction ?? this.advanceDeduction,
        absentDeduction: absentDeduction ?? this.absentDeduction,
        netPay: netPay ?? this.netPay,
        status: status ?? this.status,
      );
  PayrollLine copyWithCompanion(PayrollLinesCompanion data) {
    return PayrollLine(
      id: data.id.present ? data.id.value : this.id,
      payrollRunId: data.payrollRunId.present
          ? data.payrollRunId.value
          : this.payrollRunId,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      grossPay: data.grossPay.present ? data.grossPay.value : this.grossPay,
      advanceDeduction: data.advanceDeduction.present
          ? data.advanceDeduction.value
          : this.advanceDeduction,
      absentDeduction: data.absentDeduction.present
          ? data.absentDeduction.value
          : this.absentDeduction,
      netPay: data.netPay.present ? data.netPay.value : this.netPay,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PayrollLine(')
          ..write('id: $id, ')
          ..write('payrollRunId: $payrollRunId, ')
          ..write('staffId: $staffId, ')
          ..write('grossPay: $grossPay, ')
          ..write('advanceDeduction: $advanceDeduction, ')
          ..write('absentDeduction: $absentDeduction, ')
          ..write('netPay: $netPay, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, payrollRunId, staffId, grossPay,
      advanceDeduction, absentDeduction, netPay, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PayrollLine &&
          other.id == this.id &&
          other.payrollRunId == this.payrollRunId &&
          other.staffId == this.staffId &&
          other.grossPay == this.grossPay &&
          other.advanceDeduction == this.advanceDeduction &&
          other.absentDeduction == this.absentDeduction &&
          other.netPay == this.netPay &&
          other.status == this.status);
}

class PayrollLinesCompanion extends UpdateCompanion<PayrollLine> {
  final Value<int> id;
  final Value<int> payrollRunId;
  final Value<int> staffId;
  final Value<int> grossPay;
  final Value<int> advanceDeduction;
  final Value<int> absentDeduction;
  final Value<int> netPay;
  final Value<String> status;
  const PayrollLinesCompanion({
    this.id = const Value.absent(),
    this.payrollRunId = const Value.absent(),
    this.staffId = const Value.absent(),
    this.grossPay = const Value.absent(),
    this.advanceDeduction = const Value.absent(),
    this.absentDeduction = const Value.absent(),
    this.netPay = const Value.absent(),
    this.status = const Value.absent(),
  });
  PayrollLinesCompanion.insert({
    this.id = const Value.absent(),
    required int payrollRunId,
    required int staffId,
    required int grossPay,
    this.advanceDeduction = const Value.absent(),
    this.absentDeduction = const Value.absent(),
    required int netPay,
    this.status = const Value.absent(),
  })  : payrollRunId = Value(payrollRunId),
        staffId = Value(staffId),
        grossPay = Value(grossPay),
        netPay = Value(netPay);
  static Insertable<PayrollLine> custom({
    Expression<int>? id,
    Expression<int>? payrollRunId,
    Expression<int>? staffId,
    Expression<int>? grossPay,
    Expression<int>? advanceDeduction,
    Expression<int>? absentDeduction,
    Expression<int>? netPay,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (payrollRunId != null) 'payroll_run_id': payrollRunId,
      if (staffId != null) 'staff_id': staffId,
      if (grossPay != null) 'gross_pay': grossPay,
      if (advanceDeduction != null) 'advance_deduction': advanceDeduction,
      if (absentDeduction != null) 'absent_deduction': absentDeduction,
      if (netPay != null) 'net_pay': netPay,
      if (status != null) 'status': status,
    });
  }

  PayrollLinesCompanion copyWith(
      {Value<int>? id,
      Value<int>? payrollRunId,
      Value<int>? staffId,
      Value<int>? grossPay,
      Value<int>? advanceDeduction,
      Value<int>? absentDeduction,
      Value<int>? netPay,
      Value<String>? status}) {
    return PayrollLinesCompanion(
      id: id ?? this.id,
      payrollRunId: payrollRunId ?? this.payrollRunId,
      staffId: staffId ?? this.staffId,
      grossPay: grossPay ?? this.grossPay,
      advanceDeduction: advanceDeduction ?? this.advanceDeduction,
      absentDeduction: absentDeduction ?? this.absentDeduction,
      netPay: netPay ?? this.netPay,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (payrollRunId.present) {
      map['payroll_run_id'] = Variable<int>(payrollRunId.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<int>(staffId.value);
    }
    if (grossPay.present) {
      map['gross_pay'] = Variable<int>(grossPay.value);
    }
    if (advanceDeduction.present) {
      map['advance_deduction'] = Variable<int>(advanceDeduction.value);
    }
    if (absentDeduction.present) {
      map['absent_deduction'] = Variable<int>(absentDeduction.value);
    }
    if (netPay.present) {
      map['net_pay'] = Variable<int>(netPay.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PayrollLinesCompanion(')
          ..write('id: $id, ')
          ..write('payrollRunId: $payrollRunId, ')
          ..write('staffId: $staffId, ')
          ..write('grossPay: $grossPay, ')
          ..write('advanceDeduction: $advanceDeduction, ')
          ..write('absentDeduction: $absentDeduction, ')
          ..write('netPay: $netPay, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $ExamsTable extends Exams with TableInfo<$ExamsTable, Exam> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _classroomIdMeta =
      const VerificationMeta('classroomId');
  @override
  late final GeneratedColumn<int> classroomId = GeneratedColumn<int>(
      'classroom_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES classrooms (id)'));
  static const VerificationMeta _examDateMeta =
      const VerificationMeta('examDate');
  @override
  late final GeneratedColumn<DateTime> examDate = GeneratedColumn<DateTime>(
      'exam_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isPublishedMeta =
      const VerificationMeta('isPublished');
  @override
  late final GeneratedColumn<bool> isPublished = GeneratedColumn<bool>(
      'is_published', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_published" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, classroomId, examDate, isPublished, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exams';
  @override
  VerificationContext validateIntegrity(Insertable<Exam> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('classroom_id')) {
      context.handle(
          _classroomIdMeta,
          classroomId.isAcceptableOrUnknown(
              data['classroom_id']!, _classroomIdMeta));
    } else if (isInserting) {
      context.missing(_classroomIdMeta);
    }
    if (data.containsKey('exam_date')) {
      context.handle(_examDateMeta,
          examDate.isAcceptableOrUnknown(data['exam_date']!, _examDateMeta));
    }
    if (data.containsKey('is_published')) {
      context.handle(
          _isPublishedMeta,
          isPublished.isAcceptableOrUnknown(
              data['is_published']!, _isPublishedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exam map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exam(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      classroomId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}classroom_id'])!,
      examDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}exam_date']),
      isPublished: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_published'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ExamsTable createAlias(String alias) {
    return $ExamsTable(attachedDatabase, alias);
  }
}

class Exam extends DataClass implements Insertable<Exam> {
  final int id;
  final String title;
  final int classroomId;
  final DateTime? examDate;
  final bool isPublished;
  final DateTime createdAt;
  const Exam(
      {required this.id,
      required this.title,
      required this.classroomId,
      this.examDate,
      required this.isPublished,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['classroom_id'] = Variable<int>(classroomId);
    if (!nullToAbsent || examDate != null) {
      map['exam_date'] = Variable<DateTime>(examDate);
    }
    map['is_published'] = Variable<bool>(isPublished);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExamsCompanion toCompanion(bool nullToAbsent) {
    return ExamsCompanion(
      id: Value(id),
      title: Value(title),
      classroomId: Value(classroomId),
      examDate: examDate == null && nullToAbsent
          ? const Value.absent()
          : Value(examDate),
      isPublished: Value(isPublished),
      createdAt: Value(createdAt),
    );
  }

  factory Exam.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exam(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      classroomId: serializer.fromJson<int>(json['classroomId']),
      examDate: serializer.fromJson<DateTime?>(json['examDate']),
      isPublished: serializer.fromJson<bool>(json['isPublished']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'classroomId': serializer.toJson<int>(classroomId),
      'examDate': serializer.toJson<DateTime?>(examDate),
      'isPublished': serializer.toJson<bool>(isPublished),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Exam copyWith(
          {int? id,
          String? title,
          int? classroomId,
          Value<DateTime?> examDate = const Value.absent(),
          bool? isPublished,
          DateTime? createdAt}) =>
      Exam(
        id: id ?? this.id,
        title: title ?? this.title,
        classroomId: classroomId ?? this.classroomId,
        examDate: examDate.present ? examDate.value : this.examDate,
        isPublished: isPublished ?? this.isPublished,
        createdAt: createdAt ?? this.createdAt,
      );
  Exam copyWithCompanion(ExamsCompanion data) {
    return Exam(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      classroomId:
          data.classroomId.present ? data.classroomId.value : this.classroomId,
      examDate: data.examDate.present ? data.examDate.value : this.examDate,
      isPublished:
          data.isPublished.present ? data.isPublished.value : this.isPublished,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exam(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('classroomId: $classroomId, ')
          ..write('examDate: $examDate, ')
          ..write('isPublished: $isPublished, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, classroomId, examDate, isPublished, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exam &&
          other.id == this.id &&
          other.title == this.title &&
          other.classroomId == this.classroomId &&
          other.examDate == this.examDate &&
          other.isPublished == this.isPublished &&
          other.createdAt == this.createdAt);
}

class ExamsCompanion extends UpdateCompanion<Exam> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> classroomId;
  final Value<DateTime?> examDate;
  final Value<bool> isPublished;
  final Value<DateTime> createdAt;
  const ExamsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.classroomId = const Value.absent(),
    this.examDate = const Value.absent(),
    this.isPublished = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExamsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int classroomId,
    this.examDate = const Value.absent(),
    this.isPublished = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : title = Value(title),
        classroomId = Value(classroomId);
  static Insertable<Exam> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? classroomId,
    Expression<DateTime>? examDate,
    Expression<bool>? isPublished,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (classroomId != null) 'classroom_id': classroomId,
      if (examDate != null) 'exam_date': examDate,
      if (isPublished != null) 'is_published': isPublished,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExamsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<int>? classroomId,
      Value<DateTime?>? examDate,
      Value<bool>? isPublished,
      Value<DateTime>? createdAt}) {
    return ExamsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      classroomId: classroomId ?? this.classroomId,
      examDate: examDate ?? this.examDate,
      isPublished: isPublished ?? this.isPublished,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (classroomId.present) {
      map['classroom_id'] = Variable<int>(classroomId.value);
    }
    if (examDate.present) {
      map['exam_date'] = Variable<DateTime>(examDate.value);
    }
    if (isPublished.present) {
      map['is_published'] = Variable<bool>(isPublished.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('classroomId: $classroomId, ')
          ..write('examDate: $examDate, ')
          ..write('isPublished: $isPublished, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ExamComponentsTable extends ExamComponents
    with TableInfo<$ExamComponentsTable, ExamComponent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamComponentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _examIdMeta = const VerificationMeta('examId');
  @override
  late final GeneratedColumn<int> examId = GeneratedColumn<int>(
      'exam_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exams (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _maxMarksMeta =
      const VerificationMeta('maxMarks');
  @override
  late final GeneratedColumn<int> maxMarks = GeneratedColumn<int>(
      'max_marks', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, examId, name, weight, maxMarks];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exam_components';
  @override
  VerificationContext validateIntegrity(Insertable<ExamComponent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exam_id')) {
      context.handle(_examIdMeta,
          examId.isAcceptableOrUnknown(data['exam_id']!, _examIdMeta));
    } else if (isInserting) {
      context.missing(_examIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('max_marks')) {
      context.handle(_maxMarksMeta,
          maxMarks.isAcceptableOrUnknown(data['max_marks']!, _maxMarksMeta));
    } else if (isInserting) {
      context.missing(_maxMarksMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExamComponent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExamComponent(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      examId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exam_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      maxMarks: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_marks'])!,
    );
  }

  @override
  $ExamComponentsTable createAlias(String alias) {
    return $ExamComponentsTable(attachedDatabase, alias);
  }
}

class ExamComponent extends DataClass implements Insertable<ExamComponent> {
  final int id;
  final int examId;
  final String name;
  final double weight;
  final int maxMarks;
  const ExamComponent(
      {required this.id,
      required this.examId,
      required this.name,
      required this.weight,
      required this.maxMarks});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exam_id'] = Variable<int>(examId);
    map['name'] = Variable<String>(name);
    map['weight'] = Variable<double>(weight);
    map['max_marks'] = Variable<int>(maxMarks);
    return map;
  }

  ExamComponentsCompanion toCompanion(bool nullToAbsent) {
    return ExamComponentsCompanion(
      id: Value(id),
      examId: Value(examId),
      name: Value(name),
      weight: Value(weight),
      maxMarks: Value(maxMarks),
    );
  }

  factory ExamComponent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExamComponent(
      id: serializer.fromJson<int>(json['id']),
      examId: serializer.fromJson<int>(json['examId']),
      name: serializer.fromJson<String>(json['name']),
      weight: serializer.fromJson<double>(json['weight']),
      maxMarks: serializer.fromJson<int>(json['maxMarks']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'examId': serializer.toJson<int>(examId),
      'name': serializer.toJson<String>(name),
      'weight': serializer.toJson<double>(weight),
      'maxMarks': serializer.toJson<int>(maxMarks),
    };
  }

  ExamComponent copyWith(
          {int? id,
          int? examId,
          String? name,
          double? weight,
          int? maxMarks}) =>
      ExamComponent(
        id: id ?? this.id,
        examId: examId ?? this.examId,
        name: name ?? this.name,
        weight: weight ?? this.weight,
        maxMarks: maxMarks ?? this.maxMarks,
      );
  ExamComponent copyWithCompanion(ExamComponentsCompanion data) {
    return ExamComponent(
      id: data.id.present ? data.id.value : this.id,
      examId: data.examId.present ? data.examId.value : this.examId,
      name: data.name.present ? data.name.value : this.name,
      weight: data.weight.present ? data.weight.value : this.weight,
      maxMarks: data.maxMarks.present ? data.maxMarks.value : this.maxMarks,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExamComponent(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('name: $name, ')
          ..write('weight: $weight, ')
          ..write('maxMarks: $maxMarks')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, examId, name, weight, maxMarks);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamComponent &&
          other.id == this.id &&
          other.examId == this.examId &&
          other.name == this.name &&
          other.weight == this.weight &&
          other.maxMarks == this.maxMarks);
}

class ExamComponentsCompanion extends UpdateCompanion<ExamComponent> {
  final Value<int> id;
  final Value<int> examId;
  final Value<String> name;
  final Value<double> weight;
  final Value<int> maxMarks;
  const ExamComponentsCompanion({
    this.id = const Value.absent(),
    this.examId = const Value.absent(),
    this.name = const Value.absent(),
    this.weight = const Value.absent(),
    this.maxMarks = const Value.absent(),
  });
  ExamComponentsCompanion.insert({
    this.id = const Value.absent(),
    required int examId,
    required String name,
    this.weight = const Value.absent(),
    required int maxMarks,
  })  : examId = Value(examId),
        name = Value(name),
        maxMarks = Value(maxMarks);
  static Insertable<ExamComponent> custom({
    Expression<int>? id,
    Expression<int>? examId,
    Expression<String>? name,
    Expression<double>? weight,
    Expression<int>? maxMarks,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (examId != null) 'exam_id': examId,
      if (name != null) 'name': name,
      if (weight != null) 'weight': weight,
      if (maxMarks != null) 'max_marks': maxMarks,
    });
  }

  ExamComponentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? examId,
      Value<String>? name,
      Value<double>? weight,
      Value<int>? maxMarks}) {
    return ExamComponentsCompanion(
      id: id ?? this.id,
      examId: examId ?? this.examId,
      name: name ?? this.name,
      weight: weight ?? this.weight,
      maxMarks: maxMarks ?? this.maxMarks,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (examId.present) {
      map['exam_id'] = Variable<int>(examId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (maxMarks.present) {
      map['max_marks'] = Variable<int>(maxMarks.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamComponentsCompanion(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('name: $name, ')
          ..write('weight: $weight, ')
          ..write('maxMarks: $maxMarks')
          ..write(')'))
        .toString();
  }
}

class $ExamMarksTable extends ExamMarks
    with TableInfo<$ExamMarksTable, ExamMark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamMarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _examIdMeta = const VerificationMeta('examId');
  @override
  late final GeneratedColumn<int> examId = GeneratedColumn<int>(
      'exam_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exams (id)'));
  static const VerificationMeta _studentIdMeta =
      const VerificationMeta('studentId');
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
      'student_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES students (id)'));
  static const VerificationMeta _componentIdMeta =
      const VerificationMeta('componentId');
  @override
  late final GeneratedColumn<int> componentId = GeneratedColumn<int>(
      'component_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES exam_components (id)'));
  static const VerificationMeta _marksObtainedMeta =
      const VerificationMeta('marksObtained');
  @override
  late final GeneratedColumn<double> marksObtained = GeneratedColumn<double>(
      'marks_obtained', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, examId, studentId, componentId, marksObtained];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exam_marks';
  @override
  VerificationContext validateIntegrity(Insertable<ExamMark> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exam_id')) {
      context.handle(_examIdMeta,
          examId.isAcceptableOrUnknown(data['exam_id']!, _examIdMeta));
    } else if (isInserting) {
      context.missing(_examIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(_studentIdMeta,
          studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta));
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('component_id')) {
      context.handle(
          _componentIdMeta,
          componentId.isAcceptableOrUnknown(
              data['component_id']!, _componentIdMeta));
    } else if (isInserting) {
      context.missing(_componentIdMeta);
    }
    if (data.containsKey('marks_obtained')) {
      context.handle(
          _marksObtainedMeta,
          marksObtained.isAcceptableOrUnknown(
              data['marks_obtained']!, _marksObtainedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {examId, studentId, componentId},
      ];
  @override
  ExamMark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExamMark(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      examId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exam_id'])!,
      studentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}student_id'])!,
      componentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}component_id'])!,
      marksObtained: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}marks_obtained'])!,
    );
  }

  @override
  $ExamMarksTable createAlias(String alias) {
    return $ExamMarksTable(attachedDatabase, alias);
  }
}

class ExamMark extends DataClass implements Insertable<ExamMark> {
  final int id;
  final int examId;
  final int studentId;
  final int componentId;
  final double marksObtained;
  const ExamMark(
      {required this.id,
      required this.examId,
      required this.studentId,
      required this.componentId,
      required this.marksObtained});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exam_id'] = Variable<int>(examId);
    map['student_id'] = Variable<int>(studentId);
    map['component_id'] = Variable<int>(componentId);
    map['marks_obtained'] = Variable<double>(marksObtained);
    return map;
  }

  ExamMarksCompanion toCompanion(bool nullToAbsent) {
    return ExamMarksCompanion(
      id: Value(id),
      examId: Value(examId),
      studentId: Value(studentId),
      componentId: Value(componentId),
      marksObtained: Value(marksObtained),
    );
  }

  factory ExamMark.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExamMark(
      id: serializer.fromJson<int>(json['id']),
      examId: serializer.fromJson<int>(json['examId']),
      studentId: serializer.fromJson<int>(json['studentId']),
      componentId: serializer.fromJson<int>(json['componentId']),
      marksObtained: serializer.fromJson<double>(json['marksObtained']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'examId': serializer.toJson<int>(examId),
      'studentId': serializer.toJson<int>(studentId),
      'componentId': serializer.toJson<int>(componentId),
      'marksObtained': serializer.toJson<double>(marksObtained),
    };
  }

  ExamMark copyWith(
          {int? id,
          int? examId,
          int? studentId,
          int? componentId,
          double? marksObtained}) =>
      ExamMark(
        id: id ?? this.id,
        examId: examId ?? this.examId,
        studentId: studentId ?? this.studentId,
        componentId: componentId ?? this.componentId,
        marksObtained: marksObtained ?? this.marksObtained,
      );
  ExamMark copyWithCompanion(ExamMarksCompanion data) {
    return ExamMark(
      id: data.id.present ? data.id.value : this.id,
      examId: data.examId.present ? data.examId.value : this.examId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      componentId:
          data.componentId.present ? data.componentId.value : this.componentId,
      marksObtained: data.marksObtained.present
          ? data.marksObtained.value
          : this.marksObtained,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExamMark(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('studentId: $studentId, ')
          ..write('componentId: $componentId, ')
          ..write('marksObtained: $marksObtained')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, examId, studentId, componentId, marksObtained);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamMark &&
          other.id == this.id &&
          other.examId == this.examId &&
          other.studentId == this.studentId &&
          other.componentId == this.componentId &&
          other.marksObtained == this.marksObtained);
}

class ExamMarksCompanion extends UpdateCompanion<ExamMark> {
  final Value<int> id;
  final Value<int> examId;
  final Value<int> studentId;
  final Value<int> componentId;
  final Value<double> marksObtained;
  const ExamMarksCompanion({
    this.id = const Value.absent(),
    this.examId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.componentId = const Value.absent(),
    this.marksObtained = const Value.absent(),
  });
  ExamMarksCompanion.insert({
    this.id = const Value.absent(),
    required int examId,
    required int studentId,
    required int componentId,
    this.marksObtained = const Value.absent(),
  })  : examId = Value(examId),
        studentId = Value(studentId),
        componentId = Value(componentId);
  static Insertable<ExamMark> custom({
    Expression<int>? id,
    Expression<int>? examId,
    Expression<int>? studentId,
    Expression<int>? componentId,
    Expression<double>? marksObtained,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (examId != null) 'exam_id': examId,
      if (studentId != null) 'student_id': studentId,
      if (componentId != null) 'component_id': componentId,
      if (marksObtained != null) 'marks_obtained': marksObtained,
    });
  }

  ExamMarksCompanion copyWith(
      {Value<int>? id,
      Value<int>? examId,
      Value<int>? studentId,
      Value<int>? componentId,
      Value<double>? marksObtained}) {
    return ExamMarksCompanion(
      id: id ?? this.id,
      examId: examId ?? this.examId,
      studentId: studentId ?? this.studentId,
      componentId: componentId ?? this.componentId,
      marksObtained: marksObtained ?? this.marksObtained,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (examId.present) {
      map['exam_id'] = Variable<int>(examId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (componentId.present) {
      map['component_id'] = Variable<int>(componentId.value);
    }
    if (marksObtained.present) {
      map['marks_obtained'] = Variable<double>(marksObtained.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamMarksCompanion(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('studentId: $studentId, ')
          ..write('componentId: $componentId, ')
          ..write('marksObtained: $marksObtained')
          ..write(')'))
        .toString();
  }
}

class $GradeScalesTable extends GradeScales
    with TableInfo<$GradeScalesTable, GradeScale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GradeScalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _minPercentMeta =
      const VerificationMeta('minPercent');
  @override
  late final GeneratedColumn<double> minPercent = GeneratedColumn<double>(
      'min_percent', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _maxPercentMeta =
      const VerificationMeta('maxPercent');
  @override
  late final GeneratedColumn<double> maxPercent = GeneratedColumn<double>(
      'max_percent', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
      'grade', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  @override
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
      'remark', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, minPercent, maxPercent, grade, remark];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grade_scales';
  @override
  VerificationContext validateIntegrity(Insertable<GradeScale> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('min_percent')) {
      context.handle(
          _minPercentMeta,
          minPercent.isAcceptableOrUnknown(
              data['min_percent']!, _minPercentMeta));
    } else if (isInserting) {
      context.missing(_minPercentMeta);
    }
    if (data.containsKey('max_percent')) {
      context.handle(
          _maxPercentMeta,
          maxPercent.isAcceptableOrUnknown(
              data['max_percent']!, _maxPercentMeta));
    } else if (isInserting) {
      context.missing(_maxPercentMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
          _gradeMeta, grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta));
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('remark')) {
      context.handle(_remarkMeta,
          remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GradeScale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GradeScale(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      minPercent: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}min_percent'])!,
      maxPercent: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}max_percent'])!,
      grade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}grade'])!,
      remark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remark']),
    );
  }

  @override
  $GradeScalesTable createAlias(String alias) {
    return $GradeScalesTable(attachedDatabase, alias);
  }
}

class GradeScale extends DataClass implements Insertable<GradeScale> {
  final int id;
  final double minPercent;
  final double maxPercent;
  final String grade;
  final String? remark;
  const GradeScale(
      {required this.id,
      required this.minPercent,
      required this.maxPercent,
      required this.grade,
      this.remark});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['min_percent'] = Variable<double>(minPercent);
    map['max_percent'] = Variable<double>(maxPercent);
    map['grade'] = Variable<String>(grade);
    if (!nullToAbsent || remark != null) {
      map['remark'] = Variable<String>(remark);
    }
    return map;
  }

  GradeScalesCompanion toCompanion(bool nullToAbsent) {
    return GradeScalesCompanion(
      id: Value(id),
      minPercent: Value(minPercent),
      maxPercent: Value(maxPercent),
      grade: Value(grade),
      remark:
          remark == null && nullToAbsent ? const Value.absent() : Value(remark),
    );
  }

  factory GradeScale.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GradeScale(
      id: serializer.fromJson<int>(json['id']),
      minPercent: serializer.fromJson<double>(json['minPercent']),
      maxPercent: serializer.fromJson<double>(json['maxPercent']),
      grade: serializer.fromJson<String>(json['grade']),
      remark: serializer.fromJson<String?>(json['remark']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'minPercent': serializer.toJson<double>(minPercent),
      'maxPercent': serializer.toJson<double>(maxPercent),
      'grade': serializer.toJson<String>(grade),
      'remark': serializer.toJson<String?>(remark),
    };
  }

  GradeScale copyWith(
          {int? id,
          double? minPercent,
          double? maxPercent,
          String? grade,
          Value<String?> remark = const Value.absent()}) =>
      GradeScale(
        id: id ?? this.id,
        minPercent: minPercent ?? this.minPercent,
        maxPercent: maxPercent ?? this.maxPercent,
        grade: grade ?? this.grade,
        remark: remark.present ? remark.value : this.remark,
      );
  GradeScale copyWithCompanion(GradeScalesCompanion data) {
    return GradeScale(
      id: data.id.present ? data.id.value : this.id,
      minPercent:
          data.minPercent.present ? data.minPercent.value : this.minPercent,
      maxPercent:
          data.maxPercent.present ? data.maxPercent.value : this.maxPercent,
      grade: data.grade.present ? data.grade.value : this.grade,
      remark: data.remark.present ? data.remark.value : this.remark,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GradeScale(')
          ..write('id: $id, ')
          ..write('minPercent: $minPercent, ')
          ..write('maxPercent: $maxPercent, ')
          ..write('grade: $grade, ')
          ..write('remark: $remark')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, minPercent, maxPercent, grade, remark);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GradeScale &&
          other.id == this.id &&
          other.minPercent == this.minPercent &&
          other.maxPercent == this.maxPercent &&
          other.grade == this.grade &&
          other.remark == this.remark);
}

class GradeScalesCompanion extends UpdateCompanion<GradeScale> {
  final Value<int> id;
  final Value<double> minPercent;
  final Value<double> maxPercent;
  final Value<String> grade;
  final Value<String?> remark;
  const GradeScalesCompanion({
    this.id = const Value.absent(),
    this.minPercent = const Value.absent(),
    this.maxPercent = const Value.absent(),
    this.grade = const Value.absent(),
    this.remark = const Value.absent(),
  });
  GradeScalesCompanion.insert({
    this.id = const Value.absent(),
    required double minPercent,
    required double maxPercent,
    required String grade,
    this.remark = const Value.absent(),
  })  : minPercent = Value(minPercent),
        maxPercent = Value(maxPercent),
        grade = Value(grade);
  static Insertable<GradeScale> custom({
    Expression<int>? id,
    Expression<double>? minPercent,
    Expression<double>? maxPercent,
    Expression<String>? grade,
    Expression<String>? remark,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (minPercent != null) 'min_percent': minPercent,
      if (maxPercent != null) 'max_percent': maxPercent,
      if (grade != null) 'grade': grade,
      if (remark != null) 'remark': remark,
    });
  }

  GradeScalesCompanion copyWith(
      {Value<int>? id,
      Value<double>? minPercent,
      Value<double>? maxPercent,
      Value<String>? grade,
      Value<String?>? remark}) {
    return GradeScalesCompanion(
      id: id ?? this.id,
      minPercent: minPercent ?? this.minPercent,
      maxPercent: maxPercent ?? this.maxPercent,
      grade: grade ?? this.grade,
      remark: remark ?? this.remark,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (minPercent.present) {
      map['min_percent'] = Variable<double>(minPercent.value);
    }
    if (maxPercent.present) {
      map['max_percent'] = Variable<double>(maxPercent.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GradeScalesCompanion(')
          ..write('id: $id, ')
          ..write('minPercent: $minPercent, ')
          ..write('maxPercent: $maxPercent, ')
          ..write('grade: $grade, ')
          ..write('remark: $remark')
          ..write(')'))
        .toString();
  }
}

class $ExpenseCategoriesTable extends ExpenseCategories
    with TableInfo<$ExpenseCategoriesTable, ExpenseCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_categories';
  @override
  VerificationContext validateIntegrity(Insertable<ExpenseCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseCategory(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $ExpenseCategoriesTable createAlias(String alias) {
    return $ExpenseCategoriesTable(attachedDatabase, alias);
  }
}

class ExpenseCategory extends DataClass implements Insertable<ExpenseCategory> {
  final int id;
  final String name;
  const ExpenseCategory({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  ExpenseCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ExpenseCategoriesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory ExpenseCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseCategory(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  ExpenseCategory copyWith({int? id, String? name}) => ExpenseCategory(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  ExpenseCategory copyWithCompanion(ExpenseCategoriesCompanion data) {
    return ExpenseCategory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseCategory(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseCategory &&
          other.id == this.id &&
          other.name == this.name);
}

class ExpenseCategoriesCompanion extends UpdateCompanion<ExpenseCategory> {
  final Value<int> id;
  final Value<String> name;
  const ExpenseCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  ExpenseCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<ExpenseCategory> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  ExpenseCategoriesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return ExpenseCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES expense_categories (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _voucherNoMeta =
      const VerificationMeta('voucherNo');
  @override
  late final GeneratedColumn<String> voucherNo = GeneratedColumn<String>(
      'voucher_no', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _spentAtMeta =
      const VerificationMeta('spentAt');
  @override
  late final GeneratedColumn<DateTime> spentAt = GeneratedColumn<DateTime>(
      'spent_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _approvedByMeta =
      const VerificationMeta('approvedBy');
  @override
  late final GeneratedColumn<int> approvedBy = GeneratedColumn<int>(
      'approved_by', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, categoryId, amount, voucherNo, note, spentAt, approvedBy];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(Insertable<Expense> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('voucher_no')) {
      context.handle(_voucherNoMeta,
          voucherNo.isAcceptableOrUnknown(data['voucher_no']!, _voucherNoMeta));
    } else if (isInserting) {
      context.missing(_voucherNoMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('spent_at')) {
      context.handle(_spentAtMeta,
          spentAt.isAcceptableOrUnknown(data['spent_at']!, _spentAtMeta));
    }
    if (data.containsKey('approved_by')) {
      context.handle(
          _approvedByMeta,
          approvedBy.isAcceptableOrUnknown(
              data['approved_by']!, _approvedByMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      voucherNo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}voucher_no'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      spentAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}spent_at'])!,
      approvedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}approved_by']),
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final int categoryId;
  final int amount;
  final String voucherNo;
  final String? note;
  final DateTime spentAt;
  final int? approvedBy;
  const Expense(
      {required this.id,
      required this.categoryId,
      required this.amount,
      required this.voucherNo,
      this.note,
      required this.spentAt,
      this.approvedBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['amount'] = Variable<int>(amount);
    map['voucher_no'] = Variable<String>(voucherNo);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['spent_at'] = Variable<DateTime>(spentAt);
    if (!nullToAbsent || approvedBy != null) {
      map['approved_by'] = Variable<int>(approvedBy);
    }
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      amount: Value(amount),
      voucherNo: Value(voucherNo),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      spentAt: Value(spentAt),
      approvedBy: approvedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(approvedBy),
    );
  }

  factory Expense.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      amount: serializer.fromJson<int>(json['amount']),
      voucherNo: serializer.fromJson<String>(json['voucherNo']),
      note: serializer.fromJson<String?>(json['note']),
      spentAt: serializer.fromJson<DateTime>(json['spentAt']),
      approvedBy: serializer.fromJson<int?>(json['approvedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'amount': serializer.toJson<int>(amount),
      'voucherNo': serializer.toJson<String>(voucherNo),
      'note': serializer.toJson<String?>(note),
      'spentAt': serializer.toJson<DateTime>(spentAt),
      'approvedBy': serializer.toJson<int?>(approvedBy),
    };
  }

  Expense copyWith(
          {int? id,
          int? categoryId,
          int? amount,
          String? voucherNo,
          Value<String?> note = const Value.absent(),
          DateTime? spentAt,
          Value<int?> approvedBy = const Value.absent()}) =>
      Expense(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        amount: amount ?? this.amount,
        voucherNo: voucherNo ?? this.voucherNo,
        note: note.present ? note.value : this.note,
        spentAt: spentAt ?? this.spentAt,
        approvedBy: approvedBy.present ? approvedBy.value : this.approvedBy,
      );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      amount: data.amount.present ? data.amount.value : this.amount,
      voucherNo: data.voucherNo.present ? data.voucherNo.value : this.voucherNo,
      note: data.note.present ? data.note.value : this.note,
      spentAt: data.spentAt.present ? data.spentAt.value : this.spentAt,
      approvedBy:
          data.approvedBy.present ? data.approvedBy.value : this.approvedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('voucherNo: $voucherNo, ')
          ..write('note: $note, ')
          ..write('spentAt: $spentAt, ')
          ..write('approvedBy: $approvedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, categoryId, amount, voucherNo, note, spentAt, approvedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.amount == this.amount &&
          other.voucherNo == this.voucherNo &&
          other.note == this.note &&
          other.spentAt == this.spentAt &&
          other.approvedBy == this.approvedBy);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<int> amount;
  final Value<String> voucherNo;
  final Value<String?> note;
  final Value<DateTime> spentAt;
  final Value<int?> approvedBy;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.amount = const Value.absent(),
    this.voucherNo = const Value.absent(),
    this.note = const Value.absent(),
    this.spentAt = const Value.absent(),
    this.approvedBy = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required int amount,
    required String voucherNo,
    this.note = const Value.absent(),
    this.spentAt = const Value.absent(),
    this.approvedBy = const Value.absent(),
  })  : categoryId = Value(categoryId),
        amount = Value(amount),
        voucherNo = Value(voucherNo);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<int>? amount,
    Expression<String>? voucherNo,
    Expression<String>? note,
    Expression<DateTime>? spentAt,
    Expression<int>? approvedBy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (amount != null) 'amount': amount,
      if (voucherNo != null) 'voucher_no': voucherNo,
      if (note != null) 'note': note,
      if (spentAt != null) 'spent_at': spentAt,
      if (approvedBy != null) 'approved_by': approvedBy,
    });
  }

  ExpensesCompanion copyWith(
      {Value<int>? id,
      Value<int>? categoryId,
      Value<int>? amount,
      Value<String>? voucherNo,
      Value<String?>? note,
      Value<DateTime>? spentAt,
      Value<int?>? approvedBy}) {
    return ExpensesCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      voucherNo: voucherNo ?? this.voucherNo,
      note: note ?? this.note,
      spentAt: spentAt ?? this.spentAt,
      approvedBy: approvedBy ?? this.approvedBy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (voucherNo.present) {
      map['voucher_no'] = Variable<String>(voucherNo.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (spentAt.present) {
      map['spent_at'] = Variable<DateTime>(spentAt.value);
    }
    if (approvedBy.present) {
      map['approved_by'] = Variable<int>(approvedBy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('voucherNo: $voucherNo, ')
          ..write('note: $note, ')
          ..write('spentAt: $spentAt, ')
          ..write('approvedBy: $approvedBy')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _entityMeta = const VerificationMeta('entity');
  @override
  late final GeneratedColumn<String> entity = GeneratedColumn<String>(
      'entity', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadJsonMeta =
      const VerificationMeta('payloadJson');
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
      'payload_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _retryCountMeta =
      const VerificationMeta('retryCount');
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
      'retry_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _lastTriedAtMeta =
      const VerificationMeta('lastTriedAt');
  @override
  late final GeneratedColumn<DateTime> lastTriedAt = GeneratedColumn<DateTime>(
      'last_tried_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        entity,
        operation,
        payloadJson,
        status,
        retryCount,
        createdAt,
        lastTriedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity')) {
      context.handle(_entityMeta,
          entity.isAcceptableOrUnknown(data['entity']!, _entityMeta));
    } else if (isInserting) {
      context.missing(_entityMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
          _payloadJsonMeta,
          payloadJson.isAcceptableOrUnknown(
              data['payload_json']!, _payloadJsonMeta));
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('retry_count')) {
      context.handle(
          _retryCountMeta,
          retryCount.isAcceptableOrUnknown(
              data['retry_count']!, _retryCountMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('last_tried_at')) {
      context.handle(
          _lastTriedAtMeta,
          lastTriedAt.isAcceptableOrUnknown(
              data['last_tried_at']!, _lastTriedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      entity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      payloadJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload_json'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      retryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retry_count'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      lastTriedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_tried_at']),
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String entity;
  final String operation;
  final String payloadJson;
  final String status;
  final int retryCount;
  final DateTime createdAt;
  final DateTime? lastTriedAt;
  const SyncQueueData(
      {required this.id,
      required this.entity,
      required this.operation,
      required this.payloadJson,
      required this.status,
      required this.retryCount,
      required this.createdAt,
      this.lastTriedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity'] = Variable<String>(entity);
    map['operation'] = Variable<String>(operation);
    map['payload_json'] = Variable<String>(payloadJson);
    map['status'] = Variable<String>(status);
    map['retry_count'] = Variable<int>(retryCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastTriedAt != null) {
      map['last_tried_at'] = Variable<DateTime>(lastTriedAt);
    }
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      entity: Value(entity),
      operation: Value(operation),
      payloadJson: Value(payloadJson),
      status: Value(status),
      retryCount: Value(retryCount),
      createdAt: Value(createdAt),
      lastTriedAt: lastTriedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastTriedAt),
    );
  }

  factory SyncQueueData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      entity: serializer.fromJson<String>(json['entity']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      status: serializer.fromJson<String>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastTriedAt: serializer.fromJson<DateTime?>(json['lastTriedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entity': serializer.toJson<String>(entity),
      'operation': serializer.toJson<String>(operation),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'status': serializer.toJson<String>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastTriedAt': serializer.toJson<DateTime?>(lastTriedAt),
    };
  }

  SyncQueueData copyWith(
          {int? id,
          String? entity,
          String? operation,
          String? payloadJson,
          String? status,
          int? retryCount,
          DateTime? createdAt,
          Value<DateTime?> lastTriedAt = const Value.absent()}) =>
      SyncQueueData(
        id: id ?? this.id,
        entity: entity ?? this.entity,
        operation: operation ?? this.operation,
        payloadJson: payloadJson ?? this.payloadJson,
        status: status ?? this.status,
        retryCount: retryCount ?? this.retryCount,
        createdAt: createdAt ?? this.createdAt,
        lastTriedAt: lastTriedAt.present ? lastTriedAt.value : this.lastTriedAt,
      );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      entity: data.entity.present ? data.entity.value : this.entity,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson:
          data.payloadJson.present ? data.payloadJson.value : this.payloadJson,
      status: data.status.present ? data.status.value : this.status,
      retryCount:
          data.retryCount.present ? data.retryCount.value : this.retryCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastTriedAt:
          data.lastTriedAt.present ? data.lastTriedAt.value : this.lastTriedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('entity: $entity, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastTriedAt: $lastTriedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, entity, operation, payloadJson, status,
      retryCount, createdAt, lastTriedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.entity == this.entity &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.createdAt == this.createdAt &&
          other.lastTriedAt == this.lastTriedAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> entity;
  final Value<String> operation;
  final Value<String> payloadJson;
  final Value<String> status;
  final Value<int> retryCount;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastTriedAt;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.entity = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastTriedAt = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String entity,
    required String operation,
    required String payloadJson,
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastTriedAt = const Value.absent(),
  })  : entity = Value(entity),
        operation = Value(operation),
        payloadJson = Value(payloadJson);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? entity,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastTriedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entity != null) 'entity': entity,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (createdAt != null) 'created_at': createdAt,
      if (lastTriedAt != null) 'last_tried_at': lastTriedAt,
    });
  }

  SyncQueueCompanion copyWith(
      {Value<int>? id,
      Value<String>? entity,
      Value<String>? operation,
      Value<String>? payloadJson,
      Value<String>? status,
      Value<int>? retryCount,
      Value<DateTime>? createdAt,
      Value<DateTime?>? lastTriedAt}) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      entity: entity ?? this.entity,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      createdAt: createdAt ?? this.createdAt,
      lastTriedAt: lastTriedAt ?? this.lastTriedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entity.present) {
      map['entity'] = Variable<String>(entity.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastTriedAt.present) {
      map['last_tried_at'] = Variable<DateTime>(lastTriedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('entity: $entity, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastTriedAt: $lastTriedAt')
          ..write(')'))
        .toString();
  }
}

class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [id, name, code, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subjects';
  @override
  VerificationContext validateIntegrity(Insertable<Subject> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subject(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class Subject extends DataClass implements Insertable<Subject> {
  final int id;
  final String name;
  final String? code;
  final bool isActive;
  const Subject(
      {required this.id,
      required this.name,
      this.code,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      name: Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      isActive: Value(isActive),
    );
  }

  factory Subject.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subject(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String?>(json['code']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String?>(code),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Subject copyWith(
          {int? id,
          String? name,
          Value<String?> code = const Value.absent(),
          bool? isActive}) =>
      Subject(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code.present ? code.value : this.code,
        isActive: isActive ?? this.isActive,
      );
  Subject copyWithCompanion(SubjectsCompanion data) {
    return Subject(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, code, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == this.id &&
          other.name == this.name &&
          other.code == this.code &&
          other.isActive == this.isActive);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> code;
  final Value<bool> isActive;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  SubjectsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.code = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Subject> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? code,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (isActive != null) 'is_active': isActive,
    });
  }

  SubjectsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? code,
      Value<bool>? isActive}) {
    return SubjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $TeacherAssignmentsTable extends TeacherAssignments
    with TableInfo<$TeacherAssignmentsTable, TeacherAssignment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeacherAssignmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _staffIdMeta =
      const VerificationMeta('staffId');
  @override
  late final GeneratedColumn<int> staffId = GeneratedColumn<int>(
      'staff_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES staff (id)'));
  static const VerificationMeta _classroomIdMeta =
      const VerificationMeta('classroomId');
  @override
  late final GeneratedColumn<int> classroomId = GeneratedColumn<int>(
      'classroom_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES classrooms (id)'));
  static const VerificationMeta _subjectIdMeta =
      const VerificationMeta('subjectId');
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
      'subject_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES subjects (id)'));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, staffId, classroomId, subjectId, isActive, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teacher_assignments';
  @override
  VerificationContext validateIntegrity(Insertable<TeacherAssignment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('staff_id')) {
      context.handle(_staffIdMeta,
          staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta));
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('classroom_id')) {
      context.handle(
          _classroomIdMeta,
          classroomId.isAcceptableOrUnknown(
              data['classroom_id']!, _classroomIdMeta));
    } else if (isInserting) {
      context.missing(_classroomIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(_subjectIdMeta,
          subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta));
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {staffId, classroomId, subjectId},
      ];
  @override
  TeacherAssignment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeacherAssignment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      staffId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}staff_id'])!,
      classroomId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}classroom_id'])!,
      subjectId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}subject_id'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $TeacherAssignmentsTable createAlias(String alias) {
    return $TeacherAssignmentsTable(attachedDatabase, alias);
  }
}

class TeacherAssignment extends DataClass
    implements Insertable<TeacherAssignment> {
  final int id;
  final int staffId;
  final int classroomId;
  final int subjectId;
  final bool isActive;
  final DateTime createdAt;
  const TeacherAssignment(
      {required this.id,
      required this.staffId,
      required this.classroomId,
      required this.subjectId,
      required this.isActive,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['staff_id'] = Variable<int>(staffId);
    map['classroom_id'] = Variable<int>(classroomId);
    map['subject_id'] = Variable<int>(subjectId);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TeacherAssignmentsCompanion toCompanion(bool nullToAbsent) {
    return TeacherAssignmentsCompanion(
      id: Value(id),
      staffId: Value(staffId),
      classroomId: Value(classroomId),
      subjectId: Value(subjectId),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory TeacherAssignment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeacherAssignment(
      id: serializer.fromJson<int>(json['id']),
      staffId: serializer.fromJson<int>(json['staffId']),
      classroomId: serializer.fromJson<int>(json['classroomId']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'staffId': serializer.toJson<int>(staffId),
      'classroomId': serializer.toJson<int>(classroomId),
      'subjectId': serializer.toJson<int>(subjectId),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TeacherAssignment copyWith(
          {int? id,
          int? staffId,
          int? classroomId,
          int? subjectId,
          bool? isActive,
          DateTime? createdAt}) =>
      TeacherAssignment(
        id: id ?? this.id,
        staffId: staffId ?? this.staffId,
        classroomId: classroomId ?? this.classroomId,
        subjectId: subjectId ?? this.subjectId,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
      );
  TeacherAssignment copyWithCompanion(TeacherAssignmentsCompanion data) {
    return TeacherAssignment(
      id: data.id.present ? data.id.value : this.id,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      classroomId:
          data.classroomId.present ? data.classroomId.value : this.classroomId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeacherAssignment(')
          ..write('id: $id, ')
          ..write('staffId: $staffId, ')
          ..write('classroomId: $classroomId, ')
          ..write('subjectId: $subjectId, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, staffId, classroomId, subjectId, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeacherAssignment &&
          other.id == this.id &&
          other.staffId == this.staffId &&
          other.classroomId == this.classroomId &&
          other.subjectId == this.subjectId &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class TeacherAssignmentsCompanion extends UpdateCompanion<TeacherAssignment> {
  final Value<int> id;
  final Value<int> staffId;
  final Value<int> classroomId;
  final Value<int> subjectId;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const TeacherAssignmentsCompanion({
    this.id = const Value.absent(),
    this.staffId = const Value.absent(),
    this.classroomId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TeacherAssignmentsCompanion.insert({
    this.id = const Value.absent(),
    required int staffId,
    required int classroomId,
    required int subjectId,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : staffId = Value(staffId),
        classroomId = Value(classroomId),
        subjectId = Value(subjectId);
  static Insertable<TeacherAssignment> custom({
    Expression<int>? id,
    Expression<int>? staffId,
    Expression<int>? classroomId,
    Expression<int>? subjectId,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (staffId != null) 'staff_id': staffId,
      if (classroomId != null) 'classroom_id': classroomId,
      if (subjectId != null) 'subject_id': subjectId,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TeacherAssignmentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? staffId,
      Value<int>? classroomId,
      Value<int>? subjectId,
      Value<bool>? isActive,
      Value<DateTime>? createdAt}) {
    return TeacherAssignmentsCompanion(
      id: id ?? this.id,
      staffId: staffId ?? this.staffId,
      classroomId: classroomId ?? this.classroomId,
      subjectId: subjectId ?? this.subjectId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<int>(staffId.value);
    }
    if (classroomId.present) {
      map['classroom_id'] = Variable<int>(classroomId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeacherAssignmentsCompanion(')
          ..write('id: $id, ')
          ..write('staffId: $staffId, ')
          ..write('classroomId: $classroomId, ')
          ..write('subjectId: $subjectId, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$SchoolDatabase extends GeneratedDatabase {
  _$SchoolDatabase(QueryExecutor e) : super(e);
  $SchoolDatabaseManager get managers => $SchoolDatabaseManager(this);
  late final $RolesTable roles = $RolesTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ClassroomsTable classrooms = $ClassroomsTable(this);
  late final $StudentsTable students = $StudentsTable(this);
  late final $EnrollmentsTable enrollments = $EnrollmentsTable(this);
  late final $FeeHeadsTable feeHeads = $FeeHeadsTable(this);
  late final $FeeStructuresTable feeStructures = $FeeStructuresTable(this);
  late final $FeeInvoicesTable feeInvoices = $FeeInvoicesTable(this);
  late final $FeeInvoiceLinesTable feeInvoiceLines =
      $FeeInvoiceLinesTable(this);
  late final $FeePaymentsTable feePayments = $FeePaymentsTable(this);
  late final $FeePaymentAllocationsTable feePaymentAllocations =
      $FeePaymentAllocationsTable(this);
  late final $StaffTable staff = $StaffTable(this);
  late final $StaffAttendanceTable staffAttendance =
      $StaffAttendanceTable(this);
  late final $SalaryAdvancesTable salaryAdvances = $SalaryAdvancesTable(this);
  late final $PayrollRunsTable payrollRuns = $PayrollRunsTable(this);
  late final $PayrollLinesTable payrollLines = $PayrollLinesTable(this);
  late final $ExamsTable exams = $ExamsTable(this);
  late final $ExamComponentsTable examComponents = $ExamComponentsTable(this);
  late final $ExamMarksTable examMarks = $ExamMarksTable(this);
  late final $GradeScalesTable gradeScales = $GradeScalesTable(this);
  late final $ExpenseCategoriesTable expenseCategories =
      $ExpenseCategoriesTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $TeacherAssignmentsTable teacherAssignments =
      $TeacherAssignmentsTable(this);
  late final StudentsDao studentsDao = StudentsDao(this as SchoolDatabase);
  late final FeesDao feesDao = FeesDao(this as SchoolDatabase);
  late final StaffDao staffDao = StaffDao(this as SchoolDatabase);
  late final ExamsDao examsDao = ExamsDao(this as SchoolDatabase);
  late final ExpensesDao expensesDao = ExpensesDao(this as SchoolDatabase);
  late final SyncDao syncDao = SyncDao(this as SchoolDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as SchoolDatabase);
  late final DashboardDao dashboardDao = DashboardDao(this as SchoolDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        roles,
        users,
        classrooms,
        students,
        enrollments,
        feeHeads,
        feeStructures,
        feeInvoices,
        feeInvoiceLines,
        feePayments,
        feePaymentAllocations,
        staff,
        staffAttendance,
        salaryAdvances,
        payrollRuns,
        payrollLines,
        exams,
        examComponents,
        examMarks,
        gradeScales,
        expenseCategories,
        expenses,
        syncQueue,
        subjects,
        teacherAssignments
      ];
}

typedef $$RolesTableCreateCompanionBuilder = RolesCompanion Function({
  Value<int> id,
  required String code,
  required String name,
});
typedef $$RolesTableUpdateCompanionBuilder = RolesCompanion Function({
  Value<int> id,
  Value<String> code,
  Value<String> name,
});

final class $$RolesTableReferences
    extends BaseReferences<_$SchoolDatabase, $RolesTable, Role> {
  $$RolesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UsersTable, List<User>> _usersRefsTable(
          _$SchoolDatabase db) =>
      MultiTypedResultKey.fromTable(db.users,
          aliasName: $_aliasNameGenerator(db.roles.id, db.users.roleId));

  $$UsersTableProcessedTableManager get usersRefs {
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.roleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_usersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RolesTableFilterComposer
    extends Composer<_$SchoolDatabase, $RolesTable> {
  $$RolesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  Expression<bool> usersRefs(
      Expression<bool> Function($$UsersTableFilterComposer f) f) {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.roleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RolesTableOrderingComposer
    extends Composer<_$SchoolDatabase, $RolesTable> {
  $$RolesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$RolesTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $RolesTable> {
  $$RolesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> usersRefs<T extends Object>(
      Expression<T> Function($$UsersTableAnnotationComposer a) f) {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.roleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RolesTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $RolesTable,
    Role,
    $$RolesTableFilterComposer,
    $$RolesTableOrderingComposer,
    $$RolesTableAnnotationComposer,
    $$RolesTableCreateCompanionBuilder,
    $$RolesTableUpdateCompanionBuilder,
    (Role, $$RolesTableReferences),
    Role,
    PrefetchHooks Function({bool usersRefs})> {
  $$RolesTableTableManager(_$SchoolDatabase db, $RolesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RolesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RolesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RolesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) =>
              RolesCompanion(
            id: id,
            code: code,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String code,
            required String name,
          }) =>
              RolesCompanion.insert(
            id: id,
            code: code,
            name: name,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$RolesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({usersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (usersRefs) db.users],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (usersRefs)
                    await $_getPrefetchedData<Role, $RolesTable, User>(
                        currentTable: table,
                        referencedTable:
                            $$RolesTableReferences._usersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RolesTableReferences(db, table, p0).usersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.roleId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RolesTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $RolesTable,
    Role,
    $$RolesTableFilterComposer,
    $$RolesTableOrderingComposer,
    $$RolesTableAnnotationComposer,
    $$RolesTableCreateCompanionBuilder,
    $$RolesTableUpdateCompanionBuilder,
    (Role, $$RolesTableReferences),
    Role,
    PrefetchHooks Function({bool usersRefs})>;
typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String username,
  required String passwordHash,
  required int roleId,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> username,
  Value<String> passwordHash,
  Value<int> roleId,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});

final class $$UsersTableReferences
    extends BaseReferences<_$SchoolDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RolesTable _roleIdTable(_$SchoolDatabase db) =>
      db.roles.createAlias($_aliasNameGenerator(db.users.roleId, db.roles.id));

  $$RolesTableProcessedTableManager get roleId {
    final $_column = $_itemColumn<int>('role_id')!;

    final manager = $$RolesTableTableManager($_db, $_db.roles)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$FeePaymentsTable, List<FeePayment>>
      _feePaymentsRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.feePayments,
              aliasName:
                  $_aliasNameGenerator(db.users.id, db.feePayments.receivedBy));

  $$FeePaymentsTableProcessedTableManager get feePaymentsRefs {
    final manager = $$FeePaymentsTableTableManager($_db, $_db.feePayments)
        .filter((f) => f.receivedBy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_feePaymentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PayrollRunsTable, List<PayrollRun>>
      _payrollRunsRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.payrollRuns,
              aliasName: $_aliasNameGenerator(
                  db.users.id, db.payrollRuns.generatedBy));

  $$PayrollRunsTableProcessedTableManager get payrollRunsRefs {
    final manager = $$PayrollRunsTableTableManager($_db, $_db.payrollRuns)
        .filter((f) => f.generatedBy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_payrollRunsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExpensesTable, List<Expense>> _expensesRefsTable(
          _$SchoolDatabase db) =>
      MultiTypedResultKey.fromTable(db.expenses,
          aliasName: $_aliasNameGenerator(db.users.id, db.expenses.approvedBy));

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager($_db, $_db.expenses)
        .filter((f) => f.approvedBy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer
    extends Composer<_$SchoolDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$RolesTableFilterComposer get roleId {
    final $$RolesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roleId,
        referencedTable: $db.roles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RolesTableFilterComposer(
              $db: $db,
              $table: $db.roles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> feePaymentsRefs(
      Expression<bool> Function($$FeePaymentsTableFilterComposer f) f) {
    final $$FeePaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feePayments,
        getReferencedColumn: (t) => t.receivedBy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeePaymentsTableFilterComposer(
              $db: $db,
              $table: $db.feePayments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> payrollRunsRefs(
      Expression<bool> Function($$PayrollRunsTableFilterComposer f) f) {
    final $$PayrollRunsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payrollRuns,
        getReferencedColumn: (t) => t.generatedBy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PayrollRunsTableFilterComposer(
              $db: $db,
              $table: $db.payrollRuns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> expensesRefs(
      Expression<bool> Function($$ExpensesTableFilterComposer f) f) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.expenses,
        getReferencedColumn: (t) => t.approvedBy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpensesTableFilterComposer(
              $db: $db,
              $table: $db.expenses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$SchoolDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$RolesTableOrderingComposer get roleId {
    final $$RolesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roleId,
        referencedTable: $db.roles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RolesTableOrderingComposer(
              $db: $db,
              $table: $db.roles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UsersTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$RolesTableAnnotationComposer get roleId {
    final $$RolesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.roleId,
        referencedTable: $db.roles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RolesTableAnnotationComposer(
              $db: $db,
              $table: $db.roles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> feePaymentsRefs<T extends Object>(
      Expression<T> Function($$FeePaymentsTableAnnotationComposer a) f) {
    final $$FeePaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feePayments,
        getReferencedColumn: (t) => t.receivedBy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeePaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.feePayments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> payrollRunsRefs<T extends Object>(
      Expression<T> Function($$PayrollRunsTableAnnotationComposer a) f) {
    final $$PayrollRunsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payrollRuns,
        getReferencedColumn: (t) => t.generatedBy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PayrollRunsTableAnnotationComposer(
              $db: $db,
              $table: $db.payrollRuns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> expensesRefs<T extends Object>(
      Expression<T> Function($$ExpensesTableAnnotationComposer a) f) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.expenses,
        getReferencedColumn: (t) => t.approvedBy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpensesTableAnnotationComposer(
              $db: $db,
              $table: $db.expenses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function(
        {bool roleId,
        bool feePaymentsRefs,
        bool payrollRunsRefs,
        bool expensesRefs})> {
  $$UsersTableTableManager(_$SchoolDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> passwordHash = const Value.absent(),
            Value<int> roleId = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            username: username,
            passwordHash: passwordHash,
            roleId: roleId,
            isActive: isActive,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String username,
            required String passwordHash,
            required int roleId,
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            username: username,
            passwordHash: passwordHash,
            roleId: roleId,
            isActive: isActive,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {roleId = false,
              feePaymentsRefs = false,
              payrollRunsRefs = false,
              expensesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (feePaymentsRefs) db.feePayments,
                if (payrollRunsRefs) db.payrollRuns,
                if (expensesRefs) db.expenses
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (roleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.roleId,
                    referencedTable: $$UsersTableReferences._roleIdTable(db),
                    referencedColumn:
                        $$UsersTableReferences._roleIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (feePaymentsRefs)
                    await $_getPrefetchedData<User, $UsersTable, FeePayment>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._feePaymentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .feePaymentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.receivedBy == item.id),
                        typedResults: items),
                  if (payrollRunsRefs)
                    await $_getPrefetchedData<User, $UsersTable, PayrollRun>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._payrollRunsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .payrollRunsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.generatedBy == item.id),
                        typedResults: items),
                  if (expensesRefs)
                    await $_getPrefetchedData<User, $UsersTable, Expense>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._expensesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).expensesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.approvedBy == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function(
        {bool roleId,
        bool feePaymentsRefs,
        bool payrollRunsRefs,
        bool expensesRefs})>;
typedef $$ClassroomsTableCreateCompanionBuilder = ClassroomsCompanion Function({
  Value<int> id,
  required String name,
  Value<String> section,
  required int academicYear,
});
typedef $$ClassroomsTableUpdateCompanionBuilder = ClassroomsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> section,
  Value<int> academicYear,
});

final class $$ClassroomsTableReferences
    extends BaseReferences<_$SchoolDatabase, $ClassroomsTable, Classroom> {
  $$ClassroomsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$StudentsTable, List<Student>> _studentsRefsTable(
          _$SchoolDatabase db) =>
      MultiTypedResultKey.fromTable(db.students,
          aliasName:
              $_aliasNameGenerator(db.classrooms.id, db.students.classroomId));

  $$StudentsTableProcessedTableManager get studentsRefs {
    final manager = $$StudentsTableTableManager($_db, $_db.students)
        .filter((f) => f.classroomId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_studentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$EnrollmentsTable, List<Enrollment>>
      _enrollmentsRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.enrollments,
              aliasName: $_aliasNameGenerator(
                  db.classrooms.id, db.enrollments.classroomId));

  $$EnrollmentsTableProcessedTableManager get enrollmentsRefs {
    final manager = $$EnrollmentsTableTableManager($_db, $_db.enrollments)
        .filter((f) => f.classroomId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_enrollmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FeeStructuresTable, List<FeeStructure>>
      _feeStructuresRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.feeStructures,
              aliasName: $_aliasNameGenerator(
                  db.classrooms.id, db.feeStructures.classroomId));

  $$FeeStructuresTableProcessedTableManager get feeStructuresRefs {
    final manager = $$FeeStructuresTableTableManager($_db, $_db.feeStructures)
        .filter((f) => f.classroomId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_feeStructuresRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExamsTable, List<Exam>> _examsRefsTable(
          _$SchoolDatabase db) =>
      MultiTypedResultKey.fromTable(db.exams,
          aliasName:
              $_aliasNameGenerator(db.classrooms.id, db.exams.classroomId));

  $$ExamsTableProcessedTableManager get examsRefs {
    final manager = $$ExamsTableTableManager($_db, $_db.exams)
        .filter((f) => f.classroomId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_examsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TeacherAssignmentsTable, List<TeacherAssignment>>
      _teacherAssignmentsRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.teacherAssignments,
              aliasName: $_aliasNameGenerator(
                  db.classrooms.id, db.teacherAssignments.classroomId));

  $$TeacherAssignmentsTableProcessedTableManager get teacherAssignmentsRefs {
    final manager = $$TeacherAssignmentsTableTableManager(
            $_db, $_db.teacherAssignments)
        .filter((f) => f.classroomId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_teacherAssignmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ClassroomsTableFilterComposer
    extends Composer<_$SchoolDatabase, $ClassroomsTable> {
  $$ClassroomsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get section => $composableBuilder(
      column: $table.section, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get academicYear => $composableBuilder(
      column: $table.academicYear, builder: (column) => ColumnFilters(column));

  Expression<bool> studentsRefs(
      Expression<bool> Function($$StudentsTableFilterComposer f) f) {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.classroomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableFilterComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> enrollmentsRefs(
      Expression<bool> Function($$EnrollmentsTableFilterComposer f) f) {
    final $$EnrollmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.enrollments,
        getReferencedColumn: (t) => t.classroomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EnrollmentsTableFilterComposer(
              $db: $db,
              $table: $db.enrollments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> feeStructuresRefs(
      Expression<bool> Function($$FeeStructuresTableFilterComposer f) f) {
    final $$FeeStructuresTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feeStructures,
        getReferencedColumn: (t) => t.classroomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeStructuresTableFilterComposer(
              $db: $db,
              $table: $db.feeStructures,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> examsRefs(
      Expression<bool> Function($$ExamsTableFilterComposer f) f) {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.classroomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableFilterComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> teacherAssignmentsRefs(
      Expression<bool> Function($$TeacherAssignmentsTableFilterComposer f) f) {
    final $$TeacherAssignmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.teacherAssignments,
        getReferencedColumn: (t) => t.classroomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeacherAssignmentsTableFilterComposer(
              $db: $db,
              $table: $db.teacherAssignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClassroomsTableOrderingComposer
    extends Composer<_$SchoolDatabase, $ClassroomsTable> {
  $$ClassroomsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get section => $composableBuilder(
      column: $table.section, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get academicYear => $composableBuilder(
      column: $table.academicYear,
      builder: (column) => ColumnOrderings(column));
}

class $$ClassroomsTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $ClassroomsTable> {
  $$ClassroomsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get section =>
      $composableBuilder(column: $table.section, builder: (column) => column);

  GeneratedColumn<int> get academicYear => $composableBuilder(
      column: $table.academicYear, builder: (column) => column);

  Expression<T> studentsRefs<T extends Object>(
      Expression<T> Function($$StudentsTableAnnotationComposer a) f) {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.classroomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableAnnotationComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> enrollmentsRefs<T extends Object>(
      Expression<T> Function($$EnrollmentsTableAnnotationComposer a) f) {
    final $$EnrollmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.enrollments,
        getReferencedColumn: (t) => t.classroomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EnrollmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.enrollments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> feeStructuresRefs<T extends Object>(
      Expression<T> Function($$FeeStructuresTableAnnotationComposer a) f) {
    final $$FeeStructuresTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feeStructures,
        getReferencedColumn: (t) => t.classroomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeStructuresTableAnnotationComposer(
              $db: $db,
              $table: $db.feeStructures,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> examsRefs<T extends Object>(
      Expression<T> Function($$ExamsTableAnnotationComposer a) f) {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.classroomId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableAnnotationComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> teacherAssignmentsRefs<T extends Object>(
      Expression<T> Function($$TeacherAssignmentsTableAnnotationComposer a) f) {
    final $$TeacherAssignmentsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.teacherAssignments,
            getReferencedColumn: (t) => t.classroomId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TeacherAssignmentsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.teacherAssignments,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ClassroomsTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $ClassroomsTable,
    Classroom,
    $$ClassroomsTableFilterComposer,
    $$ClassroomsTableOrderingComposer,
    $$ClassroomsTableAnnotationComposer,
    $$ClassroomsTableCreateCompanionBuilder,
    $$ClassroomsTableUpdateCompanionBuilder,
    (Classroom, $$ClassroomsTableReferences),
    Classroom,
    PrefetchHooks Function(
        {bool studentsRefs,
        bool enrollmentsRefs,
        bool feeStructuresRefs,
        bool examsRefs,
        bool teacherAssignmentsRefs})> {
  $$ClassroomsTableTableManager(_$SchoolDatabase db, $ClassroomsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClassroomsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClassroomsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClassroomsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> section = const Value.absent(),
            Value<int> academicYear = const Value.absent(),
          }) =>
              ClassroomsCompanion(
            id: id,
            name: name,
            section: section,
            academicYear: academicYear,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String> section = const Value.absent(),
            required int academicYear,
          }) =>
              ClassroomsCompanion.insert(
            id: id,
            name: name,
            section: section,
            academicYear: academicYear,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ClassroomsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {studentsRefs = false,
              enrollmentsRefs = false,
              feeStructuresRefs = false,
              examsRefs = false,
              teacherAssignmentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (studentsRefs) db.students,
                if (enrollmentsRefs) db.enrollments,
                if (feeStructuresRefs) db.feeStructures,
                if (examsRefs) db.exams,
                if (teacherAssignmentsRefs) db.teacherAssignments
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (studentsRefs)
                    await $_getPrefetchedData<Classroom, $ClassroomsTable,
                            Student>(
                        currentTable: table,
                        referencedTable:
                            $$ClassroomsTableReferences._studentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClassroomsTableReferences(db, table, p0)
                                .studentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.classroomId == item.id),
                        typedResults: items),
                  if (enrollmentsRefs)
                    await $_getPrefetchedData<Classroom, $ClassroomsTable,
                            Enrollment>(
                        currentTable: table,
                        referencedTable: $$ClassroomsTableReferences
                            ._enrollmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClassroomsTableReferences(db, table, p0)
                                .enrollmentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.classroomId == item.id),
                        typedResults: items),
                  if (feeStructuresRefs)
                    await $_getPrefetchedData<Classroom, $ClassroomsTable,
                            FeeStructure>(
                        currentTable: table,
                        referencedTable: $$ClassroomsTableReferences
                            ._feeStructuresRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClassroomsTableReferences(db, table, p0)
                                .feeStructuresRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.classroomId == item.id),
                        typedResults: items),
                  if (examsRefs)
                    await $_getPrefetchedData<Classroom, $ClassroomsTable,
                            Exam>(
                        currentTable: table,
                        referencedTable:
                            $$ClassroomsTableReferences._examsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClassroomsTableReferences(db, table, p0)
                                .examsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.classroomId == item.id),
                        typedResults: items),
                  if (teacherAssignmentsRefs)
                    await $_getPrefetchedData<Classroom, $ClassroomsTable,
                            TeacherAssignment>(
                        currentTable: table,
                        referencedTable: $$ClassroomsTableReferences
                            ._teacherAssignmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClassroomsTableReferences(db, table, p0)
                                .teacherAssignmentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.classroomId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ClassroomsTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $ClassroomsTable,
    Classroom,
    $$ClassroomsTableFilterComposer,
    $$ClassroomsTableOrderingComposer,
    $$ClassroomsTableAnnotationComposer,
    $$ClassroomsTableCreateCompanionBuilder,
    $$ClassroomsTableUpdateCompanionBuilder,
    (Classroom, $$ClassroomsTableReferences),
    Classroom,
    PrefetchHooks Function(
        {bool studentsRefs,
        bool enrollmentsRefs,
        bool feeStructuresRefs,
        bool examsRefs,
        bool teacherAssignmentsRefs})>;
typedef $$StudentsTableCreateCompanionBuilder = StudentsCompanion Function({
  Value<int> id,
  required String admissionNo,
  required String fullName,
  required String fatherName,
  Value<DateTime?> dob,
  Value<String?> phone,
  Value<String?> address,
  Value<String?> photoPath,
  required String qrToken,
  Value<int?> classroomId,
  Value<int> monthlyFee,
  Value<String?> previousSchool,
  Value<String?> gender,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});
typedef $$StudentsTableUpdateCompanionBuilder = StudentsCompanion Function({
  Value<int> id,
  Value<String> admissionNo,
  Value<String> fullName,
  Value<String> fatherName,
  Value<DateTime?> dob,
  Value<String?> phone,
  Value<String?> address,
  Value<String?> photoPath,
  Value<String> qrToken,
  Value<int?> classroomId,
  Value<int> monthlyFee,
  Value<String?> previousSchool,
  Value<String?> gender,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});

final class $$StudentsTableReferences
    extends BaseReferences<_$SchoolDatabase, $StudentsTable, Student> {
  $$StudentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClassroomsTable _classroomIdTable(_$SchoolDatabase db) =>
      db.classrooms.createAlias(
          $_aliasNameGenerator(db.students.classroomId, db.classrooms.id));

  $$ClassroomsTableProcessedTableManager? get classroomId {
    final $_column = $_itemColumn<int>('classroom_id');
    if ($_column == null) return null;
    final manager = $$ClassroomsTableTableManager($_db, $_db.classrooms)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classroomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$EnrollmentsTable, List<Enrollment>>
      _enrollmentsRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.enrollments,
              aliasName: $_aliasNameGenerator(
                  db.students.id, db.enrollments.studentId));

  $$EnrollmentsTableProcessedTableManager get enrollmentsRefs {
    final manager = $$EnrollmentsTableTableManager($_db, $_db.enrollments)
        .filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_enrollmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FeeInvoicesTable, List<FeeInvoice>>
      _feeInvoicesRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.feeInvoices,
              aliasName: $_aliasNameGenerator(
                  db.students.id, db.feeInvoices.studentId));

  $$FeeInvoicesTableProcessedTableManager get feeInvoicesRefs {
    final manager = $$FeeInvoicesTableTableManager($_db, $_db.feeInvoices)
        .filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_feeInvoicesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FeePaymentsTable, List<FeePayment>>
      _feePaymentsRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.feePayments,
              aliasName: $_aliasNameGenerator(
                  db.students.id, db.feePayments.studentId));

  $$FeePaymentsTableProcessedTableManager get feePaymentsRefs {
    final manager = $$FeePaymentsTableTableManager($_db, $_db.feePayments)
        .filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_feePaymentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExamMarksTable, List<ExamMark>>
      _examMarksRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.examMarks,
              aliasName:
                  $_aliasNameGenerator(db.students.id, db.examMarks.studentId));

  $$ExamMarksTableProcessedTableManager get examMarksRefs {
    final manager = $$ExamMarksTableTableManager($_db, $_db.examMarks)
        .filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_examMarksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$StudentsTableFilterComposer
    extends Composer<_$SchoolDatabase, $StudentsTable> {
  $$StudentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get admissionNo => $composableBuilder(
      column: $table.admissionNo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fatherName => $composableBuilder(
      column: $table.fatherName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dob => $composableBuilder(
      column: $table.dob, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get qrToken => $composableBuilder(
      column: $table.qrToken, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get monthlyFee => $composableBuilder(
      column: $table.monthlyFee, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get previousSchool => $composableBuilder(
      column: $table.previousSchool,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ClassroomsTableFilterComposer get classroomId {
    final $$ClassroomsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classroomId,
        referencedTable: $db.classrooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassroomsTableFilterComposer(
              $db: $db,
              $table: $db.classrooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> enrollmentsRefs(
      Expression<bool> Function($$EnrollmentsTableFilterComposer f) f) {
    final $$EnrollmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.enrollments,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EnrollmentsTableFilterComposer(
              $db: $db,
              $table: $db.enrollments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> feeInvoicesRefs(
      Expression<bool> Function($$FeeInvoicesTableFilterComposer f) f) {
    final $$FeeInvoicesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feeInvoices,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeInvoicesTableFilterComposer(
              $db: $db,
              $table: $db.feeInvoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> feePaymentsRefs(
      Expression<bool> Function($$FeePaymentsTableFilterComposer f) f) {
    final $$FeePaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feePayments,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeePaymentsTableFilterComposer(
              $db: $db,
              $table: $db.feePayments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> examMarksRefs(
      Expression<bool> Function($$ExamMarksTableFilterComposer f) f) {
    final $$ExamMarksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examMarks,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamMarksTableFilterComposer(
              $db: $db,
              $table: $db.examMarks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StudentsTableOrderingComposer
    extends Composer<_$SchoolDatabase, $StudentsTable> {
  $$StudentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get admissionNo => $composableBuilder(
      column: $table.admissionNo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fatherName => $composableBuilder(
      column: $table.fatherName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dob => $composableBuilder(
      column: $table.dob, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get qrToken => $composableBuilder(
      column: $table.qrToken, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get monthlyFee => $composableBuilder(
      column: $table.monthlyFee, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get previousSchool => $composableBuilder(
      column: $table.previousSchool,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ClassroomsTableOrderingComposer get classroomId {
    final $$ClassroomsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classroomId,
        referencedTable: $db.classrooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassroomsTableOrderingComposer(
              $db: $db,
              $table: $db.classrooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StudentsTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $StudentsTable> {
  $$StudentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get admissionNo => $composableBuilder(
      column: $table.admissionNo, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get fatherName => $composableBuilder(
      column: $table.fatherName, builder: (column) => column);

  GeneratedColumn<DateTime> get dob =>
      $composableBuilder(column: $table.dob, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get qrToken =>
      $composableBuilder(column: $table.qrToken, builder: (column) => column);

  GeneratedColumn<int> get monthlyFee => $composableBuilder(
      column: $table.monthlyFee, builder: (column) => column);

  GeneratedColumn<String> get previousSchool => $composableBuilder(
      column: $table.previousSchool, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ClassroomsTableAnnotationComposer get classroomId {
    final $$ClassroomsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classroomId,
        referencedTable: $db.classrooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassroomsTableAnnotationComposer(
              $db: $db,
              $table: $db.classrooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> enrollmentsRefs<T extends Object>(
      Expression<T> Function($$EnrollmentsTableAnnotationComposer a) f) {
    final $$EnrollmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.enrollments,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EnrollmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.enrollments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> feeInvoicesRefs<T extends Object>(
      Expression<T> Function($$FeeInvoicesTableAnnotationComposer a) f) {
    final $$FeeInvoicesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feeInvoices,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeInvoicesTableAnnotationComposer(
              $db: $db,
              $table: $db.feeInvoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> feePaymentsRefs<T extends Object>(
      Expression<T> Function($$FeePaymentsTableAnnotationComposer a) f) {
    final $$FeePaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feePayments,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeePaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.feePayments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> examMarksRefs<T extends Object>(
      Expression<T> Function($$ExamMarksTableAnnotationComposer a) f) {
    final $$ExamMarksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examMarks,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamMarksTableAnnotationComposer(
              $db: $db,
              $table: $db.examMarks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StudentsTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $StudentsTable,
    Student,
    $$StudentsTableFilterComposer,
    $$StudentsTableOrderingComposer,
    $$StudentsTableAnnotationComposer,
    $$StudentsTableCreateCompanionBuilder,
    $$StudentsTableUpdateCompanionBuilder,
    (Student, $$StudentsTableReferences),
    Student,
    PrefetchHooks Function(
        {bool classroomId,
        bool enrollmentsRefs,
        bool feeInvoicesRefs,
        bool feePaymentsRefs,
        bool examMarksRefs})> {
  $$StudentsTableTableManager(_$SchoolDatabase db, $StudentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> admissionNo = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<String> fatherName = const Value.absent(),
            Value<DateTime?> dob = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<String> qrToken = const Value.absent(),
            Value<int?> classroomId = const Value.absent(),
            Value<int> monthlyFee = const Value.absent(),
            Value<String?> previousSchool = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              StudentsCompanion(
            id: id,
            admissionNo: admissionNo,
            fullName: fullName,
            fatherName: fatherName,
            dob: dob,
            phone: phone,
            address: address,
            photoPath: photoPath,
            qrToken: qrToken,
            classroomId: classroomId,
            monthlyFee: monthlyFee,
            previousSchool: previousSchool,
            gender: gender,
            isActive: isActive,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String admissionNo,
            required String fullName,
            required String fatherName,
            Value<DateTime?> dob = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            required String qrToken,
            Value<int?> classroomId = const Value.absent(),
            Value<int> monthlyFee = const Value.absent(),
            Value<String?> previousSchool = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              StudentsCompanion.insert(
            id: id,
            admissionNo: admissionNo,
            fullName: fullName,
            fatherName: fatherName,
            dob: dob,
            phone: phone,
            address: address,
            photoPath: photoPath,
            qrToken: qrToken,
            classroomId: classroomId,
            monthlyFee: monthlyFee,
            previousSchool: previousSchool,
            gender: gender,
            isActive: isActive,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$StudentsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {classroomId = false,
              enrollmentsRefs = false,
              feeInvoicesRefs = false,
              feePaymentsRefs = false,
              examMarksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (enrollmentsRefs) db.enrollments,
                if (feeInvoicesRefs) db.feeInvoices,
                if (feePaymentsRefs) db.feePayments,
                if (examMarksRefs) db.examMarks
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (classroomId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.classroomId,
                    referencedTable:
                        $$StudentsTableReferences._classroomIdTable(db),
                    referencedColumn:
                        $$StudentsTableReferences._classroomIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (enrollmentsRefs)
                    await $_getPrefetchedData<Student, $StudentsTable,
                            Enrollment>(
                        currentTable: table,
                        referencedTable:
                            $$StudentsTableReferences._enrollmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StudentsTableReferences(db, table, p0)
                                .enrollmentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.studentId == item.id),
                        typedResults: items),
                  if (feeInvoicesRefs)
                    await $_getPrefetchedData<Student, $StudentsTable,
                            FeeInvoice>(
                        currentTable: table,
                        referencedTable:
                            $$StudentsTableReferences._feeInvoicesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StudentsTableReferences(db, table, p0)
                                .feeInvoicesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.studentId == item.id),
                        typedResults: items),
                  if (feePaymentsRefs)
                    await $_getPrefetchedData<Student, $StudentsTable,
                            FeePayment>(
                        currentTable: table,
                        referencedTable:
                            $$StudentsTableReferences._feePaymentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StudentsTableReferences(db, table, p0)
                                .feePaymentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.studentId == item.id),
                        typedResults: items),
                  if (examMarksRefs)
                    await $_getPrefetchedData<Student, $StudentsTable,
                            ExamMark>(
                        currentTable: table,
                        referencedTable:
                            $$StudentsTableReferences._examMarksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StudentsTableReferences(db, table, p0)
                                .examMarksRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.studentId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$StudentsTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $StudentsTable,
    Student,
    $$StudentsTableFilterComposer,
    $$StudentsTableOrderingComposer,
    $$StudentsTableAnnotationComposer,
    $$StudentsTableCreateCompanionBuilder,
    $$StudentsTableUpdateCompanionBuilder,
    (Student, $$StudentsTableReferences),
    Student,
    PrefetchHooks Function(
        {bool classroomId,
        bool enrollmentsRefs,
        bool feeInvoicesRefs,
        bool feePaymentsRefs,
        bool examMarksRefs})>;
typedef $$EnrollmentsTableCreateCompanionBuilder = EnrollmentsCompanion
    Function({
  Value<int> id,
  required int studentId,
  required int classroomId,
  Value<DateTime> enrolledOn,
  Value<bool> current,
});
typedef $$EnrollmentsTableUpdateCompanionBuilder = EnrollmentsCompanion
    Function({
  Value<int> id,
  Value<int> studentId,
  Value<int> classroomId,
  Value<DateTime> enrolledOn,
  Value<bool> current,
});

final class $$EnrollmentsTableReferences
    extends BaseReferences<_$SchoolDatabase, $EnrollmentsTable, Enrollment> {
  $$EnrollmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudentsTable _studentIdTable(_$SchoolDatabase db) =>
      db.students.createAlias(
          $_aliasNameGenerator(db.enrollments.studentId, db.students.id));

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager($_db, $_db.students)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ClassroomsTable _classroomIdTable(_$SchoolDatabase db) =>
      db.classrooms.createAlias(
          $_aliasNameGenerator(db.enrollments.classroomId, db.classrooms.id));

  $$ClassroomsTableProcessedTableManager get classroomId {
    final $_column = $_itemColumn<int>('classroom_id')!;

    final manager = $$ClassroomsTableTableManager($_db, $_db.classrooms)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classroomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EnrollmentsTableFilterComposer
    extends Composer<_$SchoolDatabase, $EnrollmentsTable> {
  $$EnrollmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get enrolledOn => $composableBuilder(
      column: $table.enrolledOn, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get current => $composableBuilder(
      column: $table.current, builder: (column) => ColumnFilters(column));

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableFilterComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassroomsTableFilterComposer get classroomId {
    final $$ClassroomsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classroomId,
        referencedTable: $db.classrooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassroomsTableFilterComposer(
              $db: $db,
              $table: $db.classrooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EnrollmentsTableOrderingComposer
    extends Composer<_$SchoolDatabase, $EnrollmentsTable> {
  $$EnrollmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get enrolledOn => $composableBuilder(
      column: $table.enrolledOn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get current => $composableBuilder(
      column: $table.current, builder: (column) => ColumnOrderings(column));

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableOrderingComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassroomsTableOrderingComposer get classroomId {
    final $$ClassroomsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classroomId,
        referencedTable: $db.classrooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassroomsTableOrderingComposer(
              $db: $db,
              $table: $db.classrooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EnrollmentsTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $EnrollmentsTable> {
  $$EnrollmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get enrolledOn => $composableBuilder(
      column: $table.enrolledOn, builder: (column) => column);

  GeneratedColumn<bool> get current =>
      $composableBuilder(column: $table.current, builder: (column) => column);

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableAnnotationComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassroomsTableAnnotationComposer get classroomId {
    final $$ClassroomsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classroomId,
        referencedTable: $db.classrooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassroomsTableAnnotationComposer(
              $db: $db,
              $table: $db.classrooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EnrollmentsTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $EnrollmentsTable,
    Enrollment,
    $$EnrollmentsTableFilterComposer,
    $$EnrollmentsTableOrderingComposer,
    $$EnrollmentsTableAnnotationComposer,
    $$EnrollmentsTableCreateCompanionBuilder,
    $$EnrollmentsTableUpdateCompanionBuilder,
    (Enrollment, $$EnrollmentsTableReferences),
    Enrollment,
    PrefetchHooks Function({bool studentId, bool classroomId})> {
  $$EnrollmentsTableTableManager(_$SchoolDatabase db, $EnrollmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EnrollmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EnrollmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EnrollmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> studentId = const Value.absent(),
            Value<int> classroomId = const Value.absent(),
            Value<DateTime> enrolledOn = const Value.absent(),
            Value<bool> current = const Value.absent(),
          }) =>
              EnrollmentsCompanion(
            id: id,
            studentId: studentId,
            classroomId: classroomId,
            enrolledOn: enrolledOn,
            current: current,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int studentId,
            required int classroomId,
            Value<DateTime> enrolledOn = const Value.absent(),
            Value<bool> current = const Value.absent(),
          }) =>
              EnrollmentsCompanion.insert(
            id: id,
            studentId: studentId,
            classroomId: classroomId,
            enrolledOn: enrolledOn,
            current: current,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EnrollmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({studentId = false, classroomId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (studentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.studentId,
                    referencedTable:
                        $$EnrollmentsTableReferences._studentIdTable(db),
                    referencedColumn:
                        $$EnrollmentsTableReferences._studentIdTable(db).id,
                  ) as T;
                }
                if (classroomId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.classroomId,
                    referencedTable:
                        $$EnrollmentsTableReferences._classroomIdTable(db),
                    referencedColumn:
                        $$EnrollmentsTableReferences._classroomIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$EnrollmentsTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $EnrollmentsTable,
    Enrollment,
    $$EnrollmentsTableFilterComposer,
    $$EnrollmentsTableOrderingComposer,
    $$EnrollmentsTableAnnotationComposer,
    $$EnrollmentsTableCreateCompanionBuilder,
    $$EnrollmentsTableUpdateCompanionBuilder,
    (Enrollment, $$EnrollmentsTableReferences),
    Enrollment,
    PrefetchHooks Function({bool studentId, bool classroomId})>;
typedef $$FeeHeadsTableCreateCompanionBuilder = FeeHeadsCompanion Function({
  Value<int> id,
  required String code,
  required String name,
  Value<bool> isDiscount,
});
typedef $$FeeHeadsTableUpdateCompanionBuilder = FeeHeadsCompanion Function({
  Value<int> id,
  Value<String> code,
  Value<String> name,
  Value<bool> isDiscount,
});

final class $$FeeHeadsTableReferences
    extends BaseReferences<_$SchoolDatabase, $FeeHeadsTable, FeeHead> {
  $$FeeHeadsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FeeStructuresTable, List<FeeStructure>>
      _feeStructuresRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.feeStructures,
              aliasName: $_aliasNameGenerator(
                  db.feeHeads.id, db.feeStructures.feeHeadId));

  $$FeeStructuresTableProcessedTableManager get feeStructuresRefs {
    final manager = $$FeeStructuresTableTableManager($_db, $_db.feeStructures)
        .filter((f) => f.feeHeadId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_feeStructuresRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FeeInvoiceLinesTable, List<FeeInvoiceLine>>
      _feeInvoiceLinesRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.feeInvoiceLines,
              aliasName: $_aliasNameGenerator(
                  db.feeHeads.id, db.feeInvoiceLines.feeHeadId));

  $$FeeInvoiceLinesTableProcessedTableManager get feeInvoiceLinesRefs {
    final manager =
        $$FeeInvoiceLinesTableTableManager($_db, $_db.feeInvoiceLines)
            .filter((f) => f.feeHeadId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_feeInvoiceLinesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FeeHeadsTableFilterComposer
    extends Composer<_$SchoolDatabase, $FeeHeadsTable> {
  $$FeeHeadsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDiscount => $composableBuilder(
      column: $table.isDiscount, builder: (column) => ColumnFilters(column));

  Expression<bool> feeStructuresRefs(
      Expression<bool> Function($$FeeStructuresTableFilterComposer f) f) {
    final $$FeeStructuresTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feeStructures,
        getReferencedColumn: (t) => t.feeHeadId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeStructuresTableFilterComposer(
              $db: $db,
              $table: $db.feeStructures,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> feeInvoiceLinesRefs(
      Expression<bool> Function($$FeeInvoiceLinesTableFilterComposer f) f) {
    final $$FeeInvoiceLinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feeInvoiceLines,
        getReferencedColumn: (t) => t.feeHeadId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeInvoiceLinesTableFilterComposer(
              $db: $db,
              $table: $db.feeInvoiceLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FeeHeadsTableOrderingComposer
    extends Composer<_$SchoolDatabase, $FeeHeadsTable> {
  $$FeeHeadsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDiscount => $composableBuilder(
      column: $table.isDiscount, builder: (column) => ColumnOrderings(column));
}

class $$FeeHeadsTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $FeeHeadsTable> {
  $$FeeHeadsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isDiscount => $composableBuilder(
      column: $table.isDiscount, builder: (column) => column);

  Expression<T> feeStructuresRefs<T extends Object>(
      Expression<T> Function($$FeeStructuresTableAnnotationComposer a) f) {
    final $$FeeStructuresTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feeStructures,
        getReferencedColumn: (t) => t.feeHeadId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeStructuresTableAnnotationComposer(
              $db: $db,
              $table: $db.feeStructures,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> feeInvoiceLinesRefs<T extends Object>(
      Expression<T> Function($$FeeInvoiceLinesTableAnnotationComposer a) f) {
    final $$FeeInvoiceLinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feeInvoiceLines,
        getReferencedColumn: (t) => t.feeHeadId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeInvoiceLinesTableAnnotationComposer(
              $db: $db,
              $table: $db.feeInvoiceLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FeeHeadsTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $FeeHeadsTable,
    FeeHead,
    $$FeeHeadsTableFilterComposer,
    $$FeeHeadsTableOrderingComposer,
    $$FeeHeadsTableAnnotationComposer,
    $$FeeHeadsTableCreateCompanionBuilder,
    $$FeeHeadsTableUpdateCompanionBuilder,
    (FeeHead, $$FeeHeadsTableReferences),
    FeeHead,
    PrefetchHooks Function(
        {bool feeStructuresRefs, bool feeInvoiceLinesRefs})> {
  $$FeeHeadsTableTableManager(_$SchoolDatabase db, $FeeHeadsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeeHeadsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeeHeadsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeeHeadsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool> isDiscount = const Value.absent(),
          }) =>
              FeeHeadsCompanion(
            id: id,
            code: code,
            name: name,
            isDiscount: isDiscount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String code,
            required String name,
            Value<bool> isDiscount = const Value.absent(),
          }) =>
              FeeHeadsCompanion.insert(
            id: id,
            code: code,
            name: name,
            isDiscount: isDiscount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$FeeHeadsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {feeStructuresRefs = false, feeInvoiceLinesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (feeStructuresRefs) db.feeStructures,
                if (feeInvoiceLinesRefs) db.feeInvoiceLines
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (feeStructuresRefs)
                    await $_getPrefetchedData<FeeHead, $FeeHeadsTable,
                            FeeStructure>(
                        currentTable: table,
                        referencedTable: $$FeeHeadsTableReferences
                            ._feeStructuresRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FeeHeadsTableReferences(db, table, p0)
                                .feeStructuresRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.feeHeadId == item.id),
                        typedResults: items),
                  if (feeInvoiceLinesRefs)
                    await $_getPrefetchedData<FeeHead, $FeeHeadsTable,
                            FeeInvoiceLine>(
                        currentTable: table,
                        referencedTable: $$FeeHeadsTableReferences
                            ._feeInvoiceLinesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FeeHeadsTableReferences(db, table, p0)
                                .feeInvoiceLinesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.feeHeadId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FeeHeadsTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $FeeHeadsTable,
    FeeHead,
    $$FeeHeadsTableFilterComposer,
    $$FeeHeadsTableOrderingComposer,
    $$FeeHeadsTableAnnotationComposer,
    $$FeeHeadsTableCreateCompanionBuilder,
    $$FeeHeadsTableUpdateCompanionBuilder,
    (FeeHead, $$FeeHeadsTableReferences),
    FeeHead,
    PrefetchHooks Function({bool feeStructuresRefs, bool feeInvoiceLinesRefs})>;
typedef $$FeeStructuresTableCreateCompanionBuilder = FeeStructuresCompanion
    Function({
  Value<int> id,
  required int classroomId,
  required int feeHeadId,
  required int amount,
  Value<String> frequency,
  required DateTime effectiveFrom,
  Value<DateTime?> effectiveTo,
});
typedef $$FeeStructuresTableUpdateCompanionBuilder = FeeStructuresCompanion
    Function({
  Value<int> id,
  Value<int> classroomId,
  Value<int> feeHeadId,
  Value<int> amount,
  Value<String> frequency,
  Value<DateTime> effectiveFrom,
  Value<DateTime?> effectiveTo,
});

final class $$FeeStructuresTableReferences extends BaseReferences<
    _$SchoolDatabase, $FeeStructuresTable, FeeStructure> {
  $$FeeStructuresTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ClassroomsTable _classroomIdTable(_$SchoolDatabase db) =>
      db.classrooms.createAlias(
          $_aliasNameGenerator(db.feeStructures.classroomId, db.classrooms.id));

  $$ClassroomsTableProcessedTableManager get classroomId {
    final $_column = $_itemColumn<int>('classroom_id')!;

    final manager = $$ClassroomsTableTableManager($_db, $_db.classrooms)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classroomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $FeeHeadsTable _feeHeadIdTable(_$SchoolDatabase db) =>
      db.feeHeads.createAlias(
          $_aliasNameGenerator(db.feeStructures.feeHeadId, db.feeHeads.id));

  $$FeeHeadsTableProcessedTableManager get feeHeadId {
    final $_column = $_itemColumn<int>('fee_head_id')!;

    final manager = $$FeeHeadsTableTableManager($_db, $_db.feeHeads)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_feeHeadIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FeeStructuresTableFilterComposer
    extends Composer<_$SchoolDatabase, $FeeStructuresTable> {
  $$FeeStructuresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get effectiveFrom => $composableBuilder(
      column: $table.effectiveFrom, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get effectiveTo => $composableBuilder(
      column: $table.effectiveTo, builder: (column) => ColumnFilters(column));

  $$ClassroomsTableFilterComposer get classroomId {
    final $$ClassroomsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classroomId,
        referencedTable: $db.classrooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassroomsTableFilterComposer(
              $db: $db,
              $table: $db.classrooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FeeHeadsTableFilterComposer get feeHeadId {
    final $$FeeHeadsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.feeHeadId,
        referencedTable: $db.feeHeads,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeHeadsTableFilterComposer(
              $db: $db,
              $table: $db.feeHeads,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeeStructuresTableOrderingComposer
    extends Composer<_$SchoolDatabase, $FeeStructuresTable> {
  $$FeeStructuresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get frequency => $composableBuilder(
      column: $table.frequency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get effectiveFrom => $composableBuilder(
      column: $table.effectiveFrom,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get effectiveTo => $composableBuilder(
      column: $table.effectiveTo, builder: (column) => ColumnOrderings(column));

  $$ClassroomsTableOrderingComposer get classroomId {
    final $$ClassroomsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classroomId,
        referencedTable: $db.classrooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassroomsTableOrderingComposer(
              $db: $db,
              $table: $db.classrooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FeeHeadsTableOrderingComposer get feeHeadId {
    final $$FeeHeadsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.feeHeadId,
        referencedTable: $db.feeHeads,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeHeadsTableOrderingComposer(
              $db: $db,
              $table: $db.feeHeads,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeeStructuresTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $FeeStructuresTable> {
  $$FeeStructuresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<DateTime> get effectiveFrom => $composableBuilder(
      column: $table.effectiveFrom, builder: (column) => column);

  GeneratedColumn<DateTime> get effectiveTo => $composableBuilder(
      column: $table.effectiveTo, builder: (column) => column);

  $$ClassroomsTableAnnotationComposer get classroomId {
    final $$ClassroomsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classroomId,
        referencedTable: $db.classrooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassroomsTableAnnotationComposer(
              $db: $db,
              $table: $db.classrooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FeeHeadsTableAnnotationComposer get feeHeadId {
    final $$FeeHeadsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.feeHeadId,
        referencedTable: $db.feeHeads,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeHeadsTableAnnotationComposer(
              $db: $db,
              $table: $db.feeHeads,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeeStructuresTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $FeeStructuresTable,
    FeeStructure,
    $$FeeStructuresTableFilterComposer,
    $$FeeStructuresTableOrderingComposer,
    $$FeeStructuresTableAnnotationComposer,
    $$FeeStructuresTableCreateCompanionBuilder,
    $$FeeStructuresTableUpdateCompanionBuilder,
    (FeeStructure, $$FeeStructuresTableReferences),
    FeeStructure,
    PrefetchHooks Function({bool classroomId, bool feeHeadId})> {
  $$FeeStructuresTableTableManager(
      _$SchoolDatabase db, $FeeStructuresTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeeStructuresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeeStructuresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeeStructuresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> classroomId = const Value.absent(),
            Value<int> feeHeadId = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<String> frequency = const Value.absent(),
            Value<DateTime> effectiveFrom = const Value.absent(),
            Value<DateTime?> effectiveTo = const Value.absent(),
          }) =>
              FeeStructuresCompanion(
            id: id,
            classroomId: classroomId,
            feeHeadId: feeHeadId,
            amount: amount,
            frequency: frequency,
            effectiveFrom: effectiveFrom,
            effectiveTo: effectiveTo,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int classroomId,
            required int feeHeadId,
            required int amount,
            Value<String> frequency = const Value.absent(),
            required DateTime effectiveFrom,
            Value<DateTime?> effectiveTo = const Value.absent(),
          }) =>
              FeeStructuresCompanion.insert(
            id: id,
            classroomId: classroomId,
            feeHeadId: feeHeadId,
            amount: amount,
            frequency: frequency,
            effectiveFrom: effectiveFrom,
            effectiveTo: effectiveTo,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FeeStructuresTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({classroomId = false, feeHeadId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (classroomId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.classroomId,
                    referencedTable:
                        $$FeeStructuresTableReferences._classroomIdTable(db),
                    referencedColumn:
                        $$FeeStructuresTableReferences._classroomIdTable(db).id,
                  ) as T;
                }
                if (feeHeadId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.feeHeadId,
                    referencedTable:
                        $$FeeStructuresTableReferences._feeHeadIdTable(db),
                    referencedColumn:
                        $$FeeStructuresTableReferences._feeHeadIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FeeStructuresTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $FeeStructuresTable,
    FeeStructure,
    $$FeeStructuresTableFilterComposer,
    $$FeeStructuresTableOrderingComposer,
    $$FeeStructuresTableAnnotationComposer,
    $$FeeStructuresTableCreateCompanionBuilder,
    $$FeeStructuresTableUpdateCompanionBuilder,
    (FeeStructure, $$FeeStructuresTableReferences),
    FeeStructure,
    PrefetchHooks Function({bool classroomId, bool feeHeadId})>;
typedef $$FeeInvoicesTableCreateCompanionBuilder = FeeInvoicesCompanion
    Function({
  Value<int> id,
  required int studentId,
  required String monthKey,
  required int totalAmount,
  Value<int> discountAmount,
  required int netAmount,
  Value<int> paidAmount,
  required int dueAmount,
  Value<String> status,
  Value<DateTime?> dueDate,
  Value<DateTime> createdAt,
});
typedef $$FeeInvoicesTableUpdateCompanionBuilder = FeeInvoicesCompanion
    Function({
  Value<int> id,
  Value<int> studentId,
  Value<String> monthKey,
  Value<int> totalAmount,
  Value<int> discountAmount,
  Value<int> netAmount,
  Value<int> paidAmount,
  Value<int> dueAmount,
  Value<String> status,
  Value<DateTime?> dueDate,
  Value<DateTime> createdAt,
});

final class $$FeeInvoicesTableReferences
    extends BaseReferences<_$SchoolDatabase, $FeeInvoicesTable, FeeInvoice> {
  $$FeeInvoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudentsTable _studentIdTable(_$SchoolDatabase db) =>
      db.students.createAlias(
          $_aliasNameGenerator(db.feeInvoices.studentId, db.students.id));

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager($_db, $_db.students)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$FeeInvoiceLinesTable, List<FeeInvoiceLine>>
      _feeInvoiceLinesRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.feeInvoiceLines,
              aliasName: $_aliasNameGenerator(
                  db.feeInvoices.id, db.feeInvoiceLines.invoiceId));

  $$FeeInvoiceLinesTableProcessedTableManager get feeInvoiceLinesRefs {
    final manager =
        $$FeeInvoiceLinesTableTableManager($_db, $_db.feeInvoiceLines)
            .filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_feeInvoiceLinesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FeePaymentAllocationsTable,
      List<FeePaymentAllocation>> _feePaymentAllocationsRefsTable(
          _$SchoolDatabase db) =>
      MultiTypedResultKey.fromTable(db.feePaymentAllocations,
          aliasName: $_aliasNameGenerator(
              db.feeInvoices.id, db.feePaymentAllocations.invoiceId));

  $$FeePaymentAllocationsTableProcessedTableManager
      get feePaymentAllocationsRefs {
    final manager = $$FeePaymentAllocationsTableTableManager(
            $_db, $_db.feePaymentAllocations)
        .filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_feePaymentAllocationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FeeInvoicesTableFilterComposer
    extends Composer<_$SchoolDatabase, $FeeInvoicesTable> {
  $$FeeInvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get monthKey => $composableBuilder(
      column: $table.monthKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get discountAmount => $composableBuilder(
      column: $table.discountAmount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get netAmount => $composableBuilder(
      column: $table.netAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paidAmount => $composableBuilder(
      column: $table.paidAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dueAmount => $composableBuilder(
      column: $table.dueAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableFilterComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> feeInvoiceLinesRefs(
      Expression<bool> Function($$FeeInvoiceLinesTableFilterComposer f) f) {
    final $$FeeInvoiceLinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feeInvoiceLines,
        getReferencedColumn: (t) => t.invoiceId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeInvoiceLinesTableFilterComposer(
              $db: $db,
              $table: $db.feeInvoiceLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> feePaymentAllocationsRefs(
      Expression<bool> Function($$FeePaymentAllocationsTableFilterComposer f)
          f) {
    final $$FeePaymentAllocationsTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.feePaymentAllocations,
            getReferencedColumn: (t) => t.invoiceId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$FeePaymentAllocationsTableFilterComposer(
                  $db: $db,
                  $table: $db.feePaymentAllocations,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$FeeInvoicesTableOrderingComposer
    extends Composer<_$SchoolDatabase, $FeeInvoicesTable> {
  $$FeeInvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get monthKey => $composableBuilder(
      column: $table.monthKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get discountAmount => $composableBuilder(
      column: $table.discountAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get netAmount => $composableBuilder(
      column: $table.netAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paidAmount => $composableBuilder(
      column: $table.paidAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dueAmount => $composableBuilder(
      column: $table.dueAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableOrderingComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeeInvoicesTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $FeeInvoicesTable> {
  $$FeeInvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get monthKey =>
      $composableBuilder(column: $table.monthKey, builder: (column) => column);

  GeneratedColumn<int> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => column);

  GeneratedColumn<int> get discountAmount => $composableBuilder(
      column: $table.discountAmount, builder: (column) => column);

  GeneratedColumn<int> get netAmount =>
      $composableBuilder(column: $table.netAmount, builder: (column) => column);

  GeneratedColumn<int> get paidAmount => $composableBuilder(
      column: $table.paidAmount, builder: (column) => column);

  GeneratedColumn<int> get dueAmount =>
      $composableBuilder(column: $table.dueAmount, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableAnnotationComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> feeInvoiceLinesRefs<T extends Object>(
      Expression<T> Function($$FeeInvoiceLinesTableAnnotationComposer a) f) {
    final $$FeeInvoiceLinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.feeInvoiceLines,
        getReferencedColumn: (t) => t.invoiceId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeInvoiceLinesTableAnnotationComposer(
              $db: $db,
              $table: $db.feeInvoiceLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> feePaymentAllocationsRefs<T extends Object>(
      Expression<T> Function($$FeePaymentAllocationsTableAnnotationComposer a)
          f) {
    final $$FeePaymentAllocationsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.feePaymentAllocations,
            getReferencedColumn: (t) => t.invoiceId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$FeePaymentAllocationsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.feePaymentAllocations,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$FeeInvoicesTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $FeeInvoicesTable,
    FeeInvoice,
    $$FeeInvoicesTableFilterComposer,
    $$FeeInvoicesTableOrderingComposer,
    $$FeeInvoicesTableAnnotationComposer,
    $$FeeInvoicesTableCreateCompanionBuilder,
    $$FeeInvoicesTableUpdateCompanionBuilder,
    (FeeInvoice, $$FeeInvoicesTableReferences),
    FeeInvoice,
    PrefetchHooks Function(
        {bool studentId,
        bool feeInvoiceLinesRefs,
        bool feePaymentAllocationsRefs})> {
  $$FeeInvoicesTableTableManager(_$SchoolDatabase db, $FeeInvoicesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeeInvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeeInvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeeInvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> studentId = const Value.absent(),
            Value<String> monthKey = const Value.absent(),
            Value<int> totalAmount = const Value.absent(),
            Value<int> discountAmount = const Value.absent(),
            Value<int> netAmount = const Value.absent(),
            Value<int> paidAmount = const Value.absent(),
            Value<int> dueAmount = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              FeeInvoicesCompanion(
            id: id,
            studentId: studentId,
            monthKey: monthKey,
            totalAmount: totalAmount,
            discountAmount: discountAmount,
            netAmount: netAmount,
            paidAmount: paidAmount,
            dueAmount: dueAmount,
            status: status,
            dueDate: dueDate,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int studentId,
            required String monthKey,
            required int totalAmount,
            Value<int> discountAmount = const Value.absent(),
            required int netAmount,
            Value<int> paidAmount = const Value.absent(),
            required int dueAmount,
            Value<String> status = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              FeeInvoicesCompanion.insert(
            id: id,
            studentId: studentId,
            monthKey: monthKey,
            totalAmount: totalAmount,
            discountAmount: discountAmount,
            netAmount: netAmount,
            paidAmount: paidAmount,
            dueAmount: dueAmount,
            status: status,
            dueDate: dueDate,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FeeInvoicesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {studentId = false,
              feeInvoiceLinesRefs = false,
              feePaymentAllocationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (feeInvoiceLinesRefs) db.feeInvoiceLines,
                if (feePaymentAllocationsRefs) db.feePaymentAllocations
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (studentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.studentId,
                    referencedTable:
                        $$FeeInvoicesTableReferences._studentIdTable(db),
                    referencedColumn:
                        $$FeeInvoicesTableReferences._studentIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (feeInvoiceLinesRefs)
                    await $_getPrefetchedData<FeeInvoice, $FeeInvoicesTable,
                            FeeInvoiceLine>(
                        currentTable: table,
                        referencedTable: $$FeeInvoicesTableReferences
                            ._feeInvoiceLinesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FeeInvoicesTableReferences(db, table, p0)
                                .feeInvoiceLinesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.invoiceId == item.id),
                        typedResults: items),
                  if (feePaymentAllocationsRefs)
                    await $_getPrefetchedData<FeeInvoice, $FeeInvoicesTable,
                            FeePaymentAllocation>(
                        currentTable: table,
                        referencedTable: $$FeeInvoicesTableReferences
                            ._feePaymentAllocationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FeeInvoicesTableReferences(db, table, p0)
                                .feePaymentAllocationsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.invoiceId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FeeInvoicesTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $FeeInvoicesTable,
    FeeInvoice,
    $$FeeInvoicesTableFilterComposer,
    $$FeeInvoicesTableOrderingComposer,
    $$FeeInvoicesTableAnnotationComposer,
    $$FeeInvoicesTableCreateCompanionBuilder,
    $$FeeInvoicesTableUpdateCompanionBuilder,
    (FeeInvoice, $$FeeInvoicesTableReferences),
    FeeInvoice,
    PrefetchHooks Function(
        {bool studentId,
        bool feeInvoiceLinesRefs,
        bool feePaymentAllocationsRefs})>;
typedef $$FeeInvoiceLinesTableCreateCompanionBuilder = FeeInvoiceLinesCompanion
    Function({
  Value<int> id,
  required int invoiceId,
  required int feeHeadId,
  required int amount,
});
typedef $$FeeInvoiceLinesTableUpdateCompanionBuilder = FeeInvoiceLinesCompanion
    Function({
  Value<int> id,
  Value<int> invoiceId,
  Value<int> feeHeadId,
  Value<int> amount,
});

final class $$FeeInvoiceLinesTableReferences extends BaseReferences<
    _$SchoolDatabase, $FeeInvoiceLinesTable, FeeInvoiceLine> {
  $$FeeInvoiceLinesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $FeeInvoicesTable _invoiceIdTable(_$SchoolDatabase db) =>
      db.feeInvoices.createAlias($_aliasNameGenerator(
          db.feeInvoiceLines.invoiceId, db.feeInvoices.id));

  $$FeeInvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id')!;

    final manager = $$FeeInvoicesTableTableManager($_db, $_db.feeInvoices)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $FeeHeadsTable _feeHeadIdTable(_$SchoolDatabase db) =>
      db.feeHeads.createAlias(
          $_aliasNameGenerator(db.feeInvoiceLines.feeHeadId, db.feeHeads.id));

  $$FeeHeadsTableProcessedTableManager get feeHeadId {
    final $_column = $_itemColumn<int>('fee_head_id')!;

    final manager = $$FeeHeadsTableTableManager($_db, $_db.feeHeads)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_feeHeadIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FeeInvoiceLinesTableFilterComposer
    extends Composer<_$SchoolDatabase, $FeeInvoiceLinesTable> {
  $$FeeInvoiceLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  $$FeeInvoicesTableFilterComposer get invoiceId {
    final $$FeeInvoicesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invoiceId,
        referencedTable: $db.feeInvoices,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeInvoicesTableFilterComposer(
              $db: $db,
              $table: $db.feeInvoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FeeHeadsTableFilterComposer get feeHeadId {
    final $$FeeHeadsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.feeHeadId,
        referencedTable: $db.feeHeads,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeHeadsTableFilterComposer(
              $db: $db,
              $table: $db.feeHeads,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeeInvoiceLinesTableOrderingComposer
    extends Composer<_$SchoolDatabase, $FeeInvoiceLinesTable> {
  $$FeeInvoiceLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  $$FeeInvoicesTableOrderingComposer get invoiceId {
    final $$FeeInvoicesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invoiceId,
        referencedTable: $db.feeInvoices,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeInvoicesTableOrderingComposer(
              $db: $db,
              $table: $db.feeInvoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FeeHeadsTableOrderingComposer get feeHeadId {
    final $$FeeHeadsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.feeHeadId,
        referencedTable: $db.feeHeads,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeHeadsTableOrderingComposer(
              $db: $db,
              $table: $db.feeHeads,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeeInvoiceLinesTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $FeeInvoiceLinesTable> {
  $$FeeInvoiceLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  $$FeeInvoicesTableAnnotationComposer get invoiceId {
    final $$FeeInvoicesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invoiceId,
        referencedTable: $db.feeInvoices,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeInvoicesTableAnnotationComposer(
              $db: $db,
              $table: $db.feeInvoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FeeHeadsTableAnnotationComposer get feeHeadId {
    final $$FeeHeadsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.feeHeadId,
        referencedTable: $db.feeHeads,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeHeadsTableAnnotationComposer(
              $db: $db,
              $table: $db.feeHeads,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeeInvoiceLinesTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $FeeInvoiceLinesTable,
    FeeInvoiceLine,
    $$FeeInvoiceLinesTableFilterComposer,
    $$FeeInvoiceLinesTableOrderingComposer,
    $$FeeInvoiceLinesTableAnnotationComposer,
    $$FeeInvoiceLinesTableCreateCompanionBuilder,
    $$FeeInvoiceLinesTableUpdateCompanionBuilder,
    (FeeInvoiceLine, $$FeeInvoiceLinesTableReferences),
    FeeInvoiceLine,
    PrefetchHooks Function({bool invoiceId, bool feeHeadId})> {
  $$FeeInvoiceLinesTableTableManager(
      _$SchoolDatabase db, $FeeInvoiceLinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeeInvoiceLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeeInvoiceLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeeInvoiceLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> invoiceId = const Value.absent(),
            Value<int> feeHeadId = const Value.absent(),
            Value<int> amount = const Value.absent(),
          }) =>
              FeeInvoiceLinesCompanion(
            id: id,
            invoiceId: invoiceId,
            feeHeadId: feeHeadId,
            amount: amount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int invoiceId,
            required int feeHeadId,
            required int amount,
          }) =>
              FeeInvoiceLinesCompanion.insert(
            id: id,
            invoiceId: invoiceId,
            feeHeadId: feeHeadId,
            amount: amount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FeeInvoiceLinesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({invoiceId = false, feeHeadId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (invoiceId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.invoiceId,
                    referencedTable:
                        $$FeeInvoiceLinesTableReferences._invoiceIdTable(db),
                    referencedColumn:
                        $$FeeInvoiceLinesTableReferences._invoiceIdTable(db).id,
                  ) as T;
                }
                if (feeHeadId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.feeHeadId,
                    referencedTable:
                        $$FeeInvoiceLinesTableReferences._feeHeadIdTable(db),
                    referencedColumn:
                        $$FeeInvoiceLinesTableReferences._feeHeadIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FeeInvoiceLinesTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $FeeInvoiceLinesTable,
    FeeInvoiceLine,
    $$FeeInvoiceLinesTableFilterComposer,
    $$FeeInvoiceLinesTableOrderingComposer,
    $$FeeInvoiceLinesTableAnnotationComposer,
    $$FeeInvoiceLinesTableCreateCompanionBuilder,
    $$FeeInvoiceLinesTableUpdateCompanionBuilder,
    (FeeInvoiceLine, $$FeeInvoiceLinesTableReferences),
    FeeInvoiceLine,
    PrefetchHooks Function({bool invoiceId, bool feeHeadId})>;
typedef $$FeePaymentsTableCreateCompanionBuilder = FeePaymentsCompanion
    Function({
  Value<int> id,
  required int studentId,
  required int amount,
  Value<String> method,
  Value<String?> referenceNo,
  Value<DateTime> paidAt,
  required int receivedBy,
});
typedef $$FeePaymentsTableUpdateCompanionBuilder = FeePaymentsCompanion
    Function({
  Value<int> id,
  Value<int> studentId,
  Value<int> amount,
  Value<String> method,
  Value<String?> referenceNo,
  Value<DateTime> paidAt,
  Value<int> receivedBy,
});

final class $$FeePaymentsTableReferences
    extends BaseReferences<_$SchoolDatabase, $FeePaymentsTable, FeePayment> {
  $$FeePaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StudentsTable _studentIdTable(_$SchoolDatabase db) =>
      db.students.createAlias(
          $_aliasNameGenerator(db.feePayments.studentId, db.students.id));

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager($_db, $_db.students)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _receivedByTable(_$SchoolDatabase db) =>
      db.users.createAlias(
          $_aliasNameGenerator(db.feePayments.receivedBy, db.users.id));

  $$UsersTableProcessedTableManager get receivedBy {
    final $_column = $_itemColumn<int>('received_by')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_receivedByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$FeePaymentAllocationsTable,
      List<FeePaymentAllocation>> _feePaymentAllocationsRefsTable(
          _$SchoolDatabase db) =>
      MultiTypedResultKey.fromTable(db.feePaymentAllocations,
          aliasName: $_aliasNameGenerator(
              db.feePayments.id, db.feePaymentAllocations.paymentId));

  $$FeePaymentAllocationsTableProcessedTableManager
      get feePaymentAllocationsRefs {
    final manager = $$FeePaymentAllocationsTableTableManager(
            $_db, $_db.feePaymentAllocations)
        .filter((f) => f.paymentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_feePaymentAllocationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FeePaymentsTableFilterComposer
    extends Composer<_$SchoolDatabase, $FeePaymentsTable> {
  $$FeePaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get referenceNo => $composableBuilder(
      column: $table.referenceNo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
      column: $table.paidAt, builder: (column) => ColumnFilters(column));

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableFilterComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get receivedBy {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.receivedBy,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> feePaymentAllocationsRefs(
      Expression<bool> Function($$FeePaymentAllocationsTableFilterComposer f)
          f) {
    final $$FeePaymentAllocationsTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.feePaymentAllocations,
            getReferencedColumn: (t) => t.paymentId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$FeePaymentAllocationsTableFilterComposer(
                  $db: $db,
                  $table: $db.feePaymentAllocations,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$FeePaymentsTableOrderingComposer
    extends Composer<_$SchoolDatabase, $FeePaymentsTable> {
  $$FeePaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get method => $composableBuilder(
      column: $table.method, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get referenceNo => $composableBuilder(
      column: $table.referenceNo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
      column: $table.paidAt, builder: (column) => ColumnOrderings(column));

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableOrderingComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get receivedBy {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.receivedBy,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeePaymentsTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $FeePaymentsTable> {
  $$FeePaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get referenceNo => $composableBuilder(
      column: $table.referenceNo, builder: (column) => column);

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableAnnotationComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableAnnotationComposer get receivedBy {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.receivedBy,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> feePaymentAllocationsRefs<T extends Object>(
      Expression<T> Function($$FeePaymentAllocationsTableAnnotationComposer a)
          f) {
    final $$FeePaymentAllocationsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.feePaymentAllocations,
            getReferencedColumn: (t) => t.paymentId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$FeePaymentAllocationsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.feePaymentAllocations,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$FeePaymentsTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $FeePaymentsTable,
    FeePayment,
    $$FeePaymentsTableFilterComposer,
    $$FeePaymentsTableOrderingComposer,
    $$FeePaymentsTableAnnotationComposer,
    $$FeePaymentsTableCreateCompanionBuilder,
    $$FeePaymentsTableUpdateCompanionBuilder,
    (FeePayment, $$FeePaymentsTableReferences),
    FeePayment,
    PrefetchHooks Function(
        {bool studentId, bool receivedBy, bool feePaymentAllocationsRefs})> {
  $$FeePaymentsTableTableManager(_$SchoolDatabase db, $FeePaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeePaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeePaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeePaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> studentId = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<String> method = const Value.absent(),
            Value<String?> referenceNo = const Value.absent(),
            Value<DateTime> paidAt = const Value.absent(),
            Value<int> receivedBy = const Value.absent(),
          }) =>
              FeePaymentsCompanion(
            id: id,
            studentId: studentId,
            amount: amount,
            method: method,
            referenceNo: referenceNo,
            paidAt: paidAt,
            receivedBy: receivedBy,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int studentId,
            required int amount,
            Value<String> method = const Value.absent(),
            Value<String?> referenceNo = const Value.absent(),
            Value<DateTime> paidAt = const Value.absent(),
            required int receivedBy,
          }) =>
              FeePaymentsCompanion.insert(
            id: id,
            studentId: studentId,
            amount: amount,
            method: method,
            referenceNo: referenceNo,
            paidAt: paidAt,
            receivedBy: receivedBy,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FeePaymentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {studentId = false,
              receivedBy = false,
              feePaymentAllocationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (feePaymentAllocationsRefs) db.feePaymentAllocations
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (studentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.studentId,
                    referencedTable:
                        $$FeePaymentsTableReferences._studentIdTable(db),
                    referencedColumn:
                        $$FeePaymentsTableReferences._studentIdTable(db).id,
                  ) as T;
                }
                if (receivedBy) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.receivedBy,
                    referencedTable:
                        $$FeePaymentsTableReferences._receivedByTable(db),
                    referencedColumn:
                        $$FeePaymentsTableReferences._receivedByTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (feePaymentAllocationsRefs)
                    await $_getPrefetchedData<FeePayment, $FeePaymentsTable,
                            FeePaymentAllocation>(
                        currentTable: table,
                        referencedTable: $$FeePaymentsTableReferences
                            ._feePaymentAllocationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FeePaymentsTableReferences(db, table, p0)
                                .feePaymentAllocationsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.paymentId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FeePaymentsTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $FeePaymentsTable,
    FeePayment,
    $$FeePaymentsTableFilterComposer,
    $$FeePaymentsTableOrderingComposer,
    $$FeePaymentsTableAnnotationComposer,
    $$FeePaymentsTableCreateCompanionBuilder,
    $$FeePaymentsTableUpdateCompanionBuilder,
    (FeePayment, $$FeePaymentsTableReferences),
    FeePayment,
    PrefetchHooks Function(
        {bool studentId, bool receivedBy, bool feePaymentAllocationsRefs})>;
typedef $$FeePaymentAllocationsTableCreateCompanionBuilder
    = FeePaymentAllocationsCompanion Function({
  Value<int> id,
  required int paymentId,
  required int invoiceId,
  required int amount,
});
typedef $$FeePaymentAllocationsTableUpdateCompanionBuilder
    = FeePaymentAllocationsCompanion Function({
  Value<int> id,
  Value<int> paymentId,
  Value<int> invoiceId,
  Value<int> amount,
});

final class $$FeePaymentAllocationsTableReferences extends BaseReferences<
    _$SchoolDatabase, $FeePaymentAllocationsTable, FeePaymentAllocation> {
  $$FeePaymentAllocationsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $FeePaymentsTable _paymentIdTable(_$SchoolDatabase db) =>
      db.feePayments.createAlias($_aliasNameGenerator(
          db.feePaymentAllocations.paymentId, db.feePayments.id));

  $$FeePaymentsTableProcessedTableManager get paymentId {
    final $_column = $_itemColumn<int>('payment_id')!;

    final manager = $$FeePaymentsTableTableManager($_db, $_db.feePayments)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paymentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $FeeInvoicesTable _invoiceIdTable(_$SchoolDatabase db) =>
      db.feeInvoices.createAlias($_aliasNameGenerator(
          db.feePaymentAllocations.invoiceId, db.feeInvoices.id));

  $$FeeInvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id')!;

    final manager = $$FeeInvoicesTableTableManager($_db, $_db.feeInvoices)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FeePaymentAllocationsTableFilterComposer
    extends Composer<_$SchoolDatabase, $FeePaymentAllocationsTable> {
  $$FeePaymentAllocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  $$FeePaymentsTableFilterComposer get paymentId {
    final $$FeePaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paymentId,
        referencedTable: $db.feePayments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeePaymentsTableFilterComposer(
              $db: $db,
              $table: $db.feePayments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FeeInvoicesTableFilterComposer get invoiceId {
    final $$FeeInvoicesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invoiceId,
        referencedTable: $db.feeInvoices,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeInvoicesTableFilterComposer(
              $db: $db,
              $table: $db.feeInvoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeePaymentAllocationsTableOrderingComposer
    extends Composer<_$SchoolDatabase, $FeePaymentAllocationsTable> {
  $$FeePaymentAllocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  $$FeePaymentsTableOrderingComposer get paymentId {
    final $$FeePaymentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paymentId,
        referencedTable: $db.feePayments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeePaymentsTableOrderingComposer(
              $db: $db,
              $table: $db.feePayments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FeeInvoicesTableOrderingComposer get invoiceId {
    final $$FeeInvoicesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invoiceId,
        referencedTable: $db.feeInvoices,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeInvoicesTableOrderingComposer(
              $db: $db,
              $table: $db.feeInvoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeePaymentAllocationsTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $FeePaymentAllocationsTable> {
  $$FeePaymentAllocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  $$FeePaymentsTableAnnotationComposer get paymentId {
    final $$FeePaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paymentId,
        referencedTable: $db.feePayments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeePaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.feePayments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FeeInvoicesTableAnnotationComposer get invoiceId {
    final $$FeeInvoicesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invoiceId,
        referencedTable: $db.feeInvoices,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FeeInvoicesTableAnnotationComposer(
              $db: $db,
              $table: $db.feeInvoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FeePaymentAllocationsTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $FeePaymentAllocationsTable,
    FeePaymentAllocation,
    $$FeePaymentAllocationsTableFilterComposer,
    $$FeePaymentAllocationsTableOrderingComposer,
    $$FeePaymentAllocationsTableAnnotationComposer,
    $$FeePaymentAllocationsTableCreateCompanionBuilder,
    $$FeePaymentAllocationsTableUpdateCompanionBuilder,
    (FeePaymentAllocation, $$FeePaymentAllocationsTableReferences),
    FeePaymentAllocation,
    PrefetchHooks Function({bool paymentId, bool invoiceId})> {
  $$FeePaymentAllocationsTableTableManager(
      _$SchoolDatabase db, $FeePaymentAllocationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeePaymentAllocationsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$FeePaymentAllocationsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeePaymentAllocationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> paymentId = const Value.absent(),
            Value<int> invoiceId = const Value.absent(),
            Value<int> amount = const Value.absent(),
          }) =>
              FeePaymentAllocationsCompanion(
            id: id,
            paymentId: paymentId,
            invoiceId: invoiceId,
            amount: amount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int paymentId,
            required int invoiceId,
            required int amount,
          }) =>
              FeePaymentAllocationsCompanion.insert(
            id: id,
            paymentId: paymentId,
            invoiceId: invoiceId,
            amount: amount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FeePaymentAllocationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({paymentId = false, invoiceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (paymentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.paymentId,
                    referencedTable: $$FeePaymentAllocationsTableReferences
                        ._paymentIdTable(db),
                    referencedColumn: $$FeePaymentAllocationsTableReferences
                        ._paymentIdTable(db)
                        .id,
                  ) as T;
                }
                if (invoiceId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.invoiceId,
                    referencedTable: $$FeePaymentAllocationsTableReferences
                        ._invoiceIdTable(db),
                    referencedColumn: $$FeePaymentAllocationsTableReferences
                        ._invoiceIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FeePaymentAllocationsTableProcessedTableManager
    = ProcessedTableManager<
        _$SchoolDatabase,
        $FeePaymentAllocationsTable,
        FeePaymentAllocation,
        $$FeePaymentAllocationsTableFilterComposer,
        $$FeePaymentAllocationsTableOrderingComposer,
        $$FeePaymentAllocationsTableAnnotationComposer,
        $$FeePaymentAllocationsTableCreateCompanionBuilder,
        $$FeePaymentAllocationsTableUpdateCompanionBuilder,
        (FeePaymentAllocation, $$FeePaymentAllocationsTableReferences),
        FeePaymentAllocation,
        PrefetchHooks Function({bool paymentId, bool invoiceId})>;
typedef $$StaffTableCreateCompanionBuilder = StaffCompanion Function({
  Value<int> id,
  required String employeeCode,
  required String fullName,
  Value<String> designation,
  Value<String?> phone,
  required int baseSalary,
  Value<bool> biometricEnabled,
  Value<bool> isActive,
  Value<DateTime> joiningDate,
});
typedef $$StaffTableUpdateCompanionBuilder = StaffCompanion Function({
  Value<int> id,
  Value<String> employeeCode,
  Value<String> fullName,
  Value<String> designation,
  Value<String?> phone,
  Value<int> baseSalary,
  Value<bool> biometricEnabled,
  Value<bool> isActive,
  Value<DateTime> joiningDate,
});

final class $$StaffTableReferences
    extends BaseReferences<_$SchoolDatabase, $StaffTable, StaffData> {
  $$StaffTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$StaffAttendanceTable, List<StaffAttendanceData>>
      _staffAttendanceRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.staffAttendance,
              aliasName: $_aliasNameGenerator(
                  db.staff.id, db.staffAttendance.staffId));

  $$StaffAttendanceTableProcessedTableManager get staffAttendanceRefs {
    final manager =
        $$StaffAttendanceTableTableManager($_db, $_db.staffAttendance)
            .filter((f) => f.staffId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_staffAttendanceRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SalaryAdvancesTable, List<SalaryAdvance>>
      _salaryAdvancesRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.salaryAdvances,
              aliasName:
                  $_aliasNameGenerator(db.staff.id, db.salaryAdvances.staffId));

  $$SalaryAdvancesTableProcessedTableManager get salaryAdvancesRefs {
    final manager = $$SalaryAdvancesTableTableManager($_db, $_db.salaryAdvances)
        .filter((f) => f.staffId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_salaryAdvancesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PayrollLinesTable, List<PayrollLine>>
      _payrollLinesRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.payrollLines,
              aliasName:
                  $_aliasNameGenerator(db.staff.id, db.payrollLines.staffId));

  $$PayrollLinesTableProcessedTableManager get payrollLinesRefs {
    final manager = $$PayrollLinesTableTableManager($_db, $_db.payrollLines)
        .filter((f) => f.staffId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_payrollLinesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TeacherAssignmentsTable, List<TeacherAssignment>>
      _teacherAssignmentsRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.teacherAssignments,
              aliasName: $_aliasNameGenerator(
                  db.staff.id, db.teacherAssignments.staffId));

  $$TeacherAssignmentsTableProcessedTableManager get teacherAssignmentsRefs {
    final manager =
        $$TeacherAssignmentsTableTableManager($_db, $_db.teacherAssignments)
            .filter((f) => f.staffId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_teacherAssignmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$StaffTableFilterComposer
    extends Composer<_$SchoolDatabase, $StaffTable> {
  $$StaffTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get employeeCode => $composableBuilder(
      column: $table.employeeCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get designation => $composableBuilder(
      column: $table.designation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get baseSalary => $composableBuilder(
      column: $table.baseSalary, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get biometricEnabled => $composableBuilder(
      column: $table.biometricEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get joiningDate => $composableBuilder(
      column: $table.joiningDate, builder: (column) => ColumnFilters(column));

  Expression<bool> staffAttendanceRefs(
      Expression<bool> Function($$StaffAttendanceTableFilterComposer f) f) {
    final $$StaffAttendanceTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.staffAttendance,
        getReferencedColumn: (t) => t.staffId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StaffAttendanceTableFilterComposer(
              $db: $db,
              $table: $db.staffAttendance,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> salaryAdvancesRefs(
      Expression<bool> Function($$SalaryAdvancesTableFilterComposer f) f) {
    final $$SalaryAdvancesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.salaryAdvances,
        getReferencedColumn: (t) => t.staffId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SalaryAdvancesTableFilterComposer(
              $db: $db,
              $table: $db.salaryAdvances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> payrollLinesRefs(
      Expression<bool> Function($$PayrollLinesTableFilterComposer f) f) {
    final $$PayrollLinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payrollLines,
        getReferencedColumn: (t) => t.staffId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PayrollLinesTableFilterComposer(
              $db: $db,
              $table: $db.payrollLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> teacherAssignmentsRefs(
      Expression<bool> Function($$TeacherAssignmentsTableFilterComposer f) f) {
    final $$TeacherAssignmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.teacherAssignments,
        getReferencedColumn: (t) => t.staffId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeacherAssignmentsTableFilterComposer(
              $db: $db,
              $table: $db.teacherAssignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StaffTableOrderingComposer
    extends Composer<_$SchoolDatabase, $StaffTable> {
  $$StaffTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get employeeCode => $composableBuilder(
      column: $table.employeeCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get designation => $composableBuilder(
      column: $table.designation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get baseSalary => $composableBuilder(
      column: $table.baseSalary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get biometricEnabled => $composableBuilder(
      column: $table.biometricEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get joiningDate => $composableBuilder(
      column: $table.joiningDate, builder: (column) => ColumnOrderings(column));
}

class $$StaffTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $StaffTable> {
  $$StaffTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get employeeCode => $composableBuilder(
      column: $table.employeeCode, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get designation => $composableBuilder(
      column: $table.designation, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<int> get baseSalary => $composableBuilder(
      column: $table.baseSalary, builder: (column) => column);

  GeneratedColumn<bool> get biometricEnabled => $composableBuilder(
      column: $table.biometricEnabled, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get joiningDate => $composableBuilder(
      column: $table.joiningDate, builder: (column) => column);

  Expression<T> staffAttendanceRefs<T extends Object>(
      Expression<T> Function($$StaffAttendanceTableAnnotationComposer a) f) {
    final $$StaffAttendanceTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.staffAttendance,
        getReferencedColumn: (t) => t.staffId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StaffAttendanceTableAnnotationComposer(
              $db: $db,
              $table: $db.staffAttendance,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> salaryAdvancesRefs<T extends Object>(
      Expression<T> Function($$SalaryAdvancesTableAnnotationComposer a) f) {
    final $$SalaryAdvancesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.salaryAdvances,
        getReferencedColumn: (t) => t.staffId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SalaryAdvancesTableAnnotationComposer(
              $db: $db,
              $table: $db.salaryAdvances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> payrollLinesRefs<T extends Object>(
      Expression<T> Function($$PayrollLinesTableAnnotationComposer a) f) {
    final $$PayrollLinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payrollLines,
        getReferencedColumn: (t) => t.staffId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PayrollLinesTableAnnotationComposer(
              $db: $db,
              $table: $db.payrollLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> teacherAssignmentsRefs<T extends Object>(
      Expression<T> Function($$TeacherAssignmentsTableAnnotationComposer a) f) {
    final $$TeacherAssignmentsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.teacherAssignments,
            getReferencedColumn: (t) => t.staffId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TeacherAssignmentsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.teacherAssignments,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$StaffTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $StaffTable,
    StaffData,
    $$StaffTableFilterComposer,
    $$StaffTableOrderingComposer,
    $$StaffTableAnnotationComposer,
    $$StaffTableCreateCompanionBuilder,
    $$StaffTableUpdateCompanionBuilder,
    (StaffData, $$StaffTableReferences),
    StaffData,
    PrefetchHooks Function(
        {bool staffAttendanceRefs,
        bool salaryAdvancesRefs,
        bool payrollLinesRefs,
        bool teacherAssignmentsRefs})> {
  $$StaffTableTableManager(_$SchoolDatabase db, $StaffTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StaffTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StaffTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StaffTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> employeeCode = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<String> designation = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<int> baseSalary = const Value.absent(),
            Value<bool> biometricEnabled = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> joiningDate = const Value.absent(),
          }) =>
              StaffCompanion(
            id: id,
            employeeCode: employeeCode,
            fullName: fullName,
            designation: designation,
            phone: phone,
            baseSalary: baseSalary,
            biometricEnabled: biometricEnabled,
            isActive: isActive,
            joiningDate: joiningDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String employeeCode,
            required String fullName,
            Value<String> designation = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            required int baseSalary,
            Value<bool> biometricEnabled = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> joiningDate = const Value.absent(),
          }) =>
              StaffCompanion.insert(
            id: id,
            employeeCode: employeeCode,
            fullName: fullName,
            designation: designation,
            phone: phone,
            baseSalary: baseSalary,
            biometricEnabled: biometricEnabled,
            isActive: isActive,
            joiningDate: joiningDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$StaffTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {staffAttendanceRefs = false,
              salaryAdvancesRefs = false,
              payrollLinesRefs = false,
              teacherAssignmentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (staffAttendanceRefs) db.staffAttendance,
                if (salaryAdvancesRefs) db.salaryAdvances,
                if (payrollLinesRefs) db.payrollLines,
                if (teacherAssignmentsRefs) db.teacherAssignments
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (staffAttendanceRefs)
                    await $_getPrefetchedData<StaffData, $StaffTable,
                            StaffAttendanceData>(
                        currentTable: table,
                        referencedTable: $$StaffTableReferences
                            ._staffAttendanceRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StaffTableReferences(db, table, p0)
                                .staffAttendanceRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.staffId == item.id),
                        typedResults: items),
                  if (salaryAdvancesRefs)
                    await $_getPrefetchedData<StaffData, $StaffTable,
                            SalaryAdvance>(
                        currentTable: table,
                        referencedTable:
                            $$StaffTableReferences._salaryAdvancesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StaffTableReferences(db, table, p0)
                                .salaryAdvancesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.staffId == item.id),
                        typedResults: items),
                  if (payrollLinesRefs)
                    await $_getPrefetchedData<StaffData, $StaffTable,
                            PayrollLine>(
                        currentTable: table,
                        referencedTable:
                            $$StaffTableReferences._payrollLinesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StaffTableReferences(db, table, p0)
                                .payrollLinesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.staffId == item.id),
                        typedResults: items),
                  if (teacherAssignmentsRefs)
                    await $_getPrefetchedData<StaffData, $StaffTable,
                            TeacherAssignment>(
                        currentTable: table,
                        referencedTable: $$StaffTableReferences
                            ._teacherAssignmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StaffTableReferences(db, table, p0)
                                .teacherAssignmentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.staffId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$StaffTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $StaffTable,
    StaffData,
    $$StaffTableFilterComposer,
    $$StaffTableOrderingComposer,
    $$StaffTableAnnotationComposer,
    $$StaffTableCreateCompanionBuilder,
    $$StaffTableUpdateCompanionBuilder,
    (StaffData, $$StaffTableReferences),
    StaffData,
    PrefetchHooks Function(
        {bool staffAttendanceRefs,
        bool salaryAdvancesRefs,
        bool payrollLinesRefs,
        bool teacherAssignmentsRefs})>;
typedef $$StaffAttendanceTableCreateCompanionBuilder = StaffAttendanceCompanion
    Function({
  Value<int> id,
  required int staffId,
  required DateTime date,
  Value<String> status,
  Value<bool> biometricVerified,
  Value<String?> note,
});
typedef $$StaffAttendanceTableUpdateCompanionBuilder = StaffAttendanceCompanion
    Function({
  Value<int> id,
  Value<int> staffId,
  Value<DateTime> date,
  Value<String> status,
  Value<bool> biometricVerified,
  Value<String?> note,
});

final class $$StaffAttendanceTableReferences extends BaseReferences<
    _$SchoolDatabase, $StaffAttendanceTable, StaffAttendanceData> {
  $$StaffAttendanceTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $StaffTable _staffIdTable(_$SchoolDatabase db) => db.staff.createAlias(
      $_aliasNameGenerator(db.staffAttendance.staffId, db.staff.id));

  $$StaffTableProcessedTableManager get staffId {
    final $_column = $_itemColumn<int>('staff_id')!;

    final manager = $$StaffTableTableManager($_db, $_db.staff)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_staffIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$StaffAttendanceTableFilterComposer
    extends Composer<_$SchoolDatabase, $StaffAttendanceTable> {
  $$StaffAttendanceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get biometricVerified => $composableBuilder(
      column: $table.biometricVerified,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  $$StaffTableFilterComposer get staffId {
    final $$StaffTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.staffId,
        referencedTable: $db.staff,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StaffTableFilterComposer(
              $db: $db,
              $table: $db.staff,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StaffAttendanceTableOrderingComposer
    extends Composer<_$SchoolDatabase, $StaffAttendanceTable> {
  $$StaffAttendanceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get biometricVerified => $composableBuilder(
      column: $table.biometricVerified,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  $$StaffTableOrderingComposer get staffId {
    final $$StaffTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.staffId,
        referencedTable: $db.staff,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StaffTableOrderingComposer(
              $db: $db,
              $table: $db.staff,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StaffAttendanceTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $StaffAttendanceTable> {
  $$StaffAttendanceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get biometricVerified => $composableBuilder(
      column: $table.biometricVerified, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$StaffTableAnnotationComposer get staffId {
    final $$StaffTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.staffId,
        referencedTable: $db.staff,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StaffTableAnnotationComposer(
              $db: $db,
              $table: $db.staff,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StaffAttendanceTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $StaffAttendanceTable,
    StaffAttendanceData,
    $$StaffAttendanceTableFilterComposer,
    $$StaffAttendanceTableOrderingComposer,
    $$StaffAttendanceTableAnnotationComposer,
    $$StaffAttendanceTableCreateCompanionBuilder,
    $$StaffAttendanceTableUpdateCompanionBuilder,
    (StaffAttendanceData, $$StaffAttendanceTableReferences),
    StaffAttendanceData,
    PrefetchHooks Function({bool staffId})> {
  $$StaffAttendanceTableTableManager(
      _$SchoolDatabase db, $StaffAttendanceTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StaffAttendanceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StaffAttendanceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StaffAttendanceTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> staffId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<bool> biometricVerified = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              StaffAttendanceCompanion(
            id: id,
            staffId: staffId,
            date: date,
            status: status,
            biometricVerified: biometricVerified,
            note: note,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int staffId,
            required DateTime date,
            Value<String> status = const Value.absent(),
            Value<bool> biometricVerified = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              StaffAttendanceCompanion.insert(
            id: id,
            staffId: staffId,
            date: date,
            status: status,
            biometricVerified: biometricVerified,
            note: note,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$StaffAttendanceTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({staffId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (staffId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.staffId,
                    referencedTable:
                        $$StaffAttendanceTableReferences._staffIdTable(db),
                    referencedColumn:
                        $$StaffAttendanceTableReferences._staffIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$StaffAttendanceTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $StaffAttendanceTable,
    StaffAttendanceData,
    $$StaffAttendanceTableFilterComposer,
    $$StaffAttendanceTableOrderingComposer,
    $$StaffAttendanceTableAnnotationComposer,
    $$StaffAttendanceTableCreateCompanionBuilder,
    $$StaffAttendanceTableUpdateCompanionBuilder,
    (StaffAttendanceData, $$StaffAttendanceTableReferences),
    StaffAttendanceData,
    PrefetchHooks Function({bool staffId})>;
typedef $$SalaryAdvancesTableCreateCompanionBuilder = SalaryAdvancesCompanion
    Function({
  Value<int> id,
  required int staffId,
  required int amount,
  Value<bool> deducted,
  Value<DateTime> advancedAt,
  Value<String?> note,
});
typedef $$SalaryAdvancesTableUpdateCompanionBuilder = SalaryAdvancesCompanion
    Function({
  Value<int> id,
  Value<int> staffId,
  Value<int> amount,
  Value<bool> deducted,
  Value<DateTime> advancedAt,
  Value<String?> note,
});

final class $$SalaryAdvancesTableReferences extends BaseReferences<
    _$SchoolDatabase, $SalaryAdvancesTable, SalaryAdvance> {
  $$SalaryAdvancesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $StaffTable _staffIdTable(_$SchoolDatabase db) => db.staff.createAlias(
      $_aliasNameGenerator(db.salaryAdvances.staffId, db.staff.id));

  $$StaffTableProcessedTableManager get staffId {
    final $_column = $_itemColumn<int>('staff_id')!;

    final manager = $$StaffTableTableManager($_db, $_db.staff)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_staffIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SalaryAdvancesTableFilterComposer
    extends Composer<_$SchoolDatabase, $SalaryAdvancesTable> {
  $$SalaryAdvancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get deducted => $composableBuilder(
      column: $table.deducted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get advancedAt => $composableBuilder(
      column: $table.advancedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  $$StaffTableFilterComposer get staffId {
    final $$StaffTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.staffId,
        referencedTable: $db.staff,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StaffTableFilterComposer(
              $db: $db,
              $table: $db.staff,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SalaryAdvancesTableOrderingComposer
    extends Composer<_$SchoolDatabase, $SalaryAdvancesTable> {
  $$SalaryAdvancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get deducted => $composableBuilder(
      column: $table.deducted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get advancedAt => $composableBuilder(
      column: $table.advancedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  $$StaffTableOrderingComposer get staffId {
    final $$StaffTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.staffId,
        referencedTable: $db.staff,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StaffTableOrderingComposer(
              $db: $db,
              $table: $db.staff,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SalaryAdvancesTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $SalaryAdvancesTable> {
  $$SalaryAdvancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<bool> get deducted =>
      $composableBuilder(column: $table.deducted, builder: (column) => column);

  GeneratedColumn<DateTime> get advancedAt => $composableBuilder(
      column: $table.advancedAt, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$StaffTableAnnotationComposer get staffId {
    final $$StaffTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.staffId,
        referencedTable: $db.staff,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StaffTableAnnotationComposer(
              $db: $db,
              $table: $db.staff,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SalaryAdvancesTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $SalaryAdvancesTable,
    SalaryAdvance,
    $$SalaryAdvancesTableFilterComposer,
    $$SalaryAdvancesTableOrderingComposer,
    $$SalaryAdvancesTableAnnotationComposer,
    $$SalaryAdvancesTableCreateCompanionBuilder,
    $$SalaryAdvancesTableUpdateCompanionBuilder,
    (SalaryAdvance, $$SalaryAdvancesTableReferences),
    SalaryAdvance,
    PrefetchHooks Function({bool staffId})> {
  $$SalaryAdvancesTableTableManager(
      _$SchoolDatabase db, $SalaryAdvancesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalaryAdvancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalaryAdvancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalaryAdvancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> staffId = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<bool> deducted = const Value.absent(),
            Value<DateTime> advancedAt = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              SalaryAdvancesCompanion(
            id: id,
            staffId: staffId,
            amount: amount,
            deducted: deducted,
            advancedAt: advancedAt,
            note: note,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int staffId,
            required int amount,
            Value<bool> deducted = const Value.absent(),
            Value<DateTime> advancedAt = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              SalaryAdvancesCompanion.insert(
            id: id,
            staffId: staffId,
            amount: amount,
            deducted: deducted,
            advancedAt: advancedAt,
            note: note,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SalaryAdvancesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({staffId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (staffId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.staffId,
                    referencedTable:
                        $$SalaryAdvancesTableReferences._staffIdTable(db),
                    referencedColumn:
                        $$SalaryAdvancesTableReferences._staffIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SalaryAdvancesTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $SalaryAdvancesTable,
    SalaryAdvance,
    $$SalaryAdvancesTableFilterComposer,
    $$SalaryAdvancesTableOrderingComposer,
    $$SalaryAdvancesTableAnnotationComposer,
    $$SalaryAdvancesTableCreateCompanionBuilder,
    $$SalaryAdvancesTableUpdateCompanionBuilder,
    (SalaryAdvance, $$SalaryAdvancesTableReferences),
    SalaryAdvance,
    PrefetchHooks Function({bool staffId})>;
typedef $$PayrollRunsTableCreateCompanionBuilder = PayrollRunsCompanion
    Function({
  Value<int> id,
  required String monthKey,
  Value<DateTime> generatedAt,
  required int generatedBy,
});
typedef $$PayrollRunsTableUpdateCompanionBuilder = PayrollRunsCompanion
    Function({
  Value<int> id,
  Value<String> monthKey,
  Value<DateTime> generatedAt,
  Value<int> generatedBy,
});

final class $$PayrollRunsTableReferences
    extends BaseReferences<_$SchoolDatabase, $PayrollRunsTable, PayrollRun> {
  $$PayrollRunsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _generatedByTable(_$SchoolDatabase db) =>
      db.users.createAlias(
          $_aliasNameGenerator(db.payrollRuns.generatedBy, db.users.id));

  $$UsersTableProcessedTableManager get generatedBy {
    final $_column = $_itemColumn<int>('generated_by')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_generatedByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PayrollLinesTable, List<PayrollLine>>
      _payrollLinesRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.payrollLines,
              aliasName: $_aliasNameGenerator(
                  db.payrollRuns.id, db.payrollLines.payrollRunId));

  $$PayrollLinesTableProcessedTableManager get payrollLinesRefs {
    final manager = $$PayrollLinesTableTableManager($_db, $_db.payrollLines)
        .filter((f) => f.payrollRunId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_payrollLinesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PayrollRunsTableFilterComposer
    extends Composer<_$SchoolDatabase, $PayrollRunsTable> {
  $$PayrollRunsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get monthKey => $composableBuilder(
      column: $table.monthKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get generatedBy {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.generatedBy,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> payrollLinesRefs(
      Expression<bool> Function($$PayrollLinesTableFilterComposer f) f) {
    final $$PayrollLinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payrollLines,
        getReferencedColumn: (t) => t.payrollRunId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PayrollLinesTableFilterComposer(
              $db: $db,
              $table: $db.payrollLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PayrollRunsTableOrderingComposer
    extends Composer<_$SchoolDatabase, $PayrollRunsTable> {
  $$PayrollRunsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get monthKey => $composableBuilder(
      column: $table.monthKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get generatedBy {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.generatedBy,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PayrollRunsTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $PayrollRunsTable> {
  $$PayrollRunsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get monthKey =>
      $composableBuilder(column: $table.monthKey, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get generatedBy {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.generatedBy,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> payrollLinesRefs<T extends Object>(
      Expression<T> Function($$PayrollLinesTableAnnotationComposer a) f) {
    final $$PayrollLinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payrollLines,
        getReferencedColumn: (t) => t.payrollRunId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PayrollLinesTableAnnotationComposer(
              $db: $db,
              $table: $db.payrollLines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PayrollRunsTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $PayrollRunsTable,
    PayrollRun,
    $$PayrollRunsTableFilterComposer,
    $$PayrollRunsTableOrderingComposer,
    $$PayrollRunsTableAnnotationComposer,
    $$PayrollRunsTableCreateCompanionBuilder,
    $$PayrollRunsTableUpdateCompanionBuilder,
    (PayrollRun, $$PayrollRunsTableReferences),
    PayrollRun,
    PrefetchHooks Function({bool generatedBy, bool payrollLinesRefs})> {
  $$PayrollRunsTableTableManager(_$SchoolDatabase db, $PayrollRunsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PayrollRunsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PayrollRunsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PayrollRunsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> monthKey = const Value.absent(),
            Value<DateTime> generatedAt = const Value.absent(),
            Value<int> generatedBy = const Value.absent(),
          }) =>
              PayrollRunsCompanion(
            id: id,
            monthKey: monthKey,
            generatedAt: generatedAt,
            generatedBy: generatedBy,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String monthKey,
            Value<DateTime> generatedAt = const Value.absent(),
            required int generatedBy,
          }) =>
              PayrollRunsCompanion.insert(
            id: id,
            monthKey: monthKey,
            generatedAt: generatedAt,
            generatedBy: generatedBy,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PayrollRunsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {generatedBy = false, payrollLinesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (payrollLinesRefs) db.payrollLines],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (generatedBy) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.generatedBy,
                    referencedTable:
                        $$PayrollRunsTableReferences._generatedByTable(db),
                    referencedColumn:
                        $$PayrollRunsTableReferences._generatedByTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (payrollLinesRefs)
                    await $_getPrefetchedData<PayrollRun, $PayrollRunsTable,
                            PayrollLine>(
                        currentTable: table,
                        referencedTable: $$PayrollRunsTableReferences
                            ._payrollLinesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PayrollRunsTableReferences(db, table, p0)
                                .payrollLinesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.payrollRunId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PayrollRunsTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $PayrollRunsTable,
    PayrollRun,
    $$PayrollRunsTableFilterComposer,
    $$PayrollRunsTableOrderingComposer,
    $$PayrollRunsTableAnnotationComposer,
    $$PayrollRunsTableCreateCompanionBuilder,
    $$PayrollRunsTableUpdateCompanionBuilder,
    (PayrollRun, $$PayrollRunsTableReferences),
    PayrollRun,
    PrefetchHooks Function({bool generatedBy, bool payrollLinesRefs})>;
typedef $$PayrollLinesTableCreateCompanionBuilder = PayrollLinesCompanion
    Function({
  Value<int> id,
  required int payrollRunId,
  required int staffId,
  required int grossPay,
  Value<int> advanceDeduction,
  Value<int> absentDeduction,
  required int netPay,
  Value<String> status,
});
typedef $$PayrollLinesTableUpdateCompanionBuilder = PayrollLinesCompanion
    Function({
  Value<int> id,
  Value<int> payrollRunId,
  Value<int> staffId,
  Value<int> grossPay,
  Value<int> advanceDeduction,
  Value<int> absentDeduction,
  Value<int> netPay,
  Value<String> status,
});

final class $$PayrollLinesTableReferences
    extends BaseReferences<_$SchoolDatabase, $PayrollLinesTable, PayrollLine> {
  $$PayrollLinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PayrollRunsTable _payrollRunIdTable(_$SchoolDatabase db) =>
      db.payrollRuns.createAlias($_aliasNameGenerator(
          db.payrollLines.payrollRunId, db.payrollRuns.id));

  $$PayrollRunsTableProcessedTableManager get payrollRunId {
    final $_column = $_itemColumn<int>('payroll_run_id')!;

    final manager = $$PayrollRunsTableTableManager($_db, $_db.payrollRuns)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_payrollRunIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $StaffTable _staffIdTable(_$SchoolDatabase db) => db.staff
      .createAlias($_aliasNameGenerator(db.payrollLines.staffId, db.staff.id));

  $$StaffTableProcessedTableManager get staffId {
    final $_column = $_itemColumn<int>('staff_id')!;

    final manager = $$StaffTableTableManager($_db, $_db.staff)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_staffIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PayrollLinesTableFilterComposer
    extends Composer<_$SchoolDatabase, $PayrollLinesTable> {
  $$PayrollLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get grossPay => $composableBuilder(
      column: $table.grossPay, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get advanceDeduction => $composableBuilder(
      column: $table.advanceDeduction,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get absentDeduction => $composableBuilder(
      column: $table.absentDeduction,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get netPay => $composableBuilder(
      column: $table.netPay, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  $$PayrollRunsTableFilterComposer get payrollRunId {
    final $$PayrollRunsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.payrollRunId,
        referencedTable: $db.payrollRuns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PayrollRunsTableFilterComposer(
              $db: $db,
              $table: $db.payrollRuns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$StaffTableFilterComposer get staffId {
    final $$StaffTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.staffId,
        referencedTable: $db.staff,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StaffTableFilterComposer(
              $db: $db,
              $table: $db.staff,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PayrollLinesTableOrderingComposer
    extends Composer<_$SchoolDatabase, $PayrollLinesTable> {
  $$PayrollLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get grossPay => $composableBuilder(
      column: $table.grossPay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get advanceDeduction => $composableBuilder(
      column: $table.advanceDeduction,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get absentDeduction => $composableBuilder(
      column: $table.absentDeduction,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get netPay => $composableBuilder(
      column: $table.netPay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  $$PayrollRunsTableOrderingComposer get payrollRunId {
    final $$PayrollRunsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.payrollRunId,
        referencedTable: $db.payrollRuns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PayrollRunsTableOrderingComposer(
              $db: $db,
              $table: $db.payrollRuns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$StaffTableOrderingComposer get staffId {
    final $$StaffTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.staffId,
        referencedTable: $db.staff,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StaffTableOrderingComposer(
              $db: $db,
              $table: $db.staff,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PayrollLinesTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $PayrollLinesTable> {
  $$PayrollLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get grossPay =>
      $composableBuilder(column: $table.grossPay, builder: (column) => column);

  GeneratedColumn<int> get advanceDeduction => $composableBuilder(
      column: $table.advanceDeduction, builder: (column) => column);

  GeneratedColumn<int> get absentDeduction => $composableBuilder(
      column: $table.absentDeduction, builder: (column) => column);

  GeneratedColumn<int> get netPay =>
      $composableBuilder(column: $table.netPay, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$PayrollRunsTableAnnotationComposer get payrollRunId {
    final $$PayrollRunsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.payrollRunId,
        referencedTable: $db.payrollRuns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PayrollRunsTableAnnotationComposer(
              $db: $db,
              $table: $db.payrollRuns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$StaffTableAnnotationComposer get staffId {
    final $$StaffTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.staffId,
        referencedTable: $db.staff,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StaffTableAnnotationComposer(
              $db: $db,
              $table: $db.staff,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PayrollLinesTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $PayrollLinesTable,
    PayrollLine,
    $$PayrollLinesTableFilterComposer,
    $$PayrollLinesTableOrderingComposer,
    $$PayrollLinesTableAnnotationComposer,
    $$PayrollLinesTableCreateCompanionBuilder,
    $$PayrollLinesTableUpdateCompanionBuilder,
    (PayrollLine, $$PayrollLinesTableReferences),
    PayrollLine,
    PrefetchHooks Function({bool payrollRunId, bool staffId})> {
  $$PayrollLinesTableTableManager(_$SchoolDatabase db, $PayrollLinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PayrollLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PayrollLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PayrollLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> payrollRunId = const Value.absent(),
            Value<int> staffId = const Value.absent(),
            Value<int> grossPay = const Value.absent(),
            Value<int> advanceDeduction = const Value.absent(),
            Value<int> absentDeduction = const Value.absent(),
            Value<int> netPay = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              PayrollLinesCompanion(
            id: id,
            payrollRunId: payrollRunId,
            staffId: staffId,
            grossPay: grossPay,
            advanceDeduction: advanceDeduction,
            absentDeduction: absentDeduction,
            netPay: netPay,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int payrollRunId,
            required int staffId,
            required int grossPay,
            Value<int> advanceDeduction = const Value.absent(),
            Value<int> absentDeduction = const Value.absent(),
            required int netPay,
            Value<String> status = const Value.absent(),
          }) =>
              PayrollLinesCompanion.insert(
            id: id,
            payrollRunId: payrollRunId,
            staffId: staffId,
            grossPay: grossPay,
            advanceDeduction: advanceDeduction,
            absentDeduction: absentDeduction,
            netPay: netPay,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PayrollLinesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({payrollRunId = false, staffId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (payrollRunId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.payrollRunId,
                    referencedTable:
                        $$PayrollLinesTableReferences._payrollRunIdTable(db),
                    referencedColumn:
                        $$PayrollLinesTableReferences._payrollRunIdTable(db).id,
                  ) as T;
                }
                if (staffId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.staffId,
                    referencedTable:
                        $$PayrollLinesTableReferences._staffIdTable(db),
                    referencedColumn:
                        $$PayrollLinesTableReferences._staffIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PayrollLinesTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $PayrollLinesTable,
    PayrollLine,
    $$PayrollLinesTableFilterComposer,
    $$PayrollLinesTableOrderingComposer,
    $$PayrollLinesTableAnnotationComposer,
    $$PayrollLinesTableCreateCompanionBuilder,
    $$PayrollLinesTableUpdateCompanionBuilder,
    (PayrollLine, $$PayrollLinesTableReferences),
    PayrollLine,
    PrefetchHooks Function({bool payrollRunId, bool staffId})>;
typedef $$ExamsTableCreateCompanionBuilder = ExamsCompanion Function({
  Value<int> id,
  required String title,
  required int classroomId,
  Value<DateTime?> examDate,
  Value<bool> isPublished,
  Value<DateTime> createdAt,
});
typedef $$ExamsTableUpdateCompanionBuilder = ExamsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<int> classroomId,
  Value<DateTime?> examDate,
  Value<bool> isPublished,
  Value<DateTime> createdAt,
});

final class $$ExamsTableReferences
    extends BaseReferences<_$SchoolDatabase, $ExamsTable, Exam> {
  $$ExamsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClassroomsTable _classroomIdTable(_$SchoolDatabase db) =>
      db.classrooms.createAlias(
          $_aliasNameGenerator(db.exams.classroomId, db.classrooms.id));

  $$ClassroomsTableProcessedTableManager get classroomId {
    final $_column = $_itemColumn<int>('classroom_id')!;

    final manager = $$ClassroomsTableTableManager($_db, $_db.classrooms)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classroomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ExamComponentsTable, List<ExamComponent>>
      _examComponentsRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.examComponents,
              aliasName:
                  $_aliasNameGenerator(db.exams.id, db.examComponents.examId));

  $$ExamComponentsTableProcessedTableManager get examComponentsRefs {
    final manager = $$ExamComponentsTableTableManager($_db, $_db.examComponents)
        .filter((f) => f.examId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_examComponentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExamMarksTable, List<ExamMark>>
      _examMarksRefsTable(_$SchoolDatabase db) => MultiTypedResultKey.fromTable(
          db.examMarks,
          aliasName: $_aliasNameGenerator(db.exams.id, db.examMarks.examId));

  $$ExamMarksTableProcessedTableManager get examMarksRefs {
    final manager = $$ExamMarksTableTableManager($_db, $_db.examMarks)
        .filter((f) => f.examId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_examMarksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExamsTableFilterComposer
    extends Composer<_$SchoolDatabase, $ExamsTable> {
  $$ExamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get examDate => $composableBuilder(
      column: $table.examDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPublished => $composableBuilder(
      column: $table.isPublished, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ClassroomsTableFilterComposer get classroomId {
    final $$ClassroomsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classroomId,
        referencedTable: $db.classrooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassroomsTableFilterComposer(
              $db: $db,
              $table: $db.classrooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> examComponentsRefs(
      Expression<bool> Function($$ExamComponentsTableFilterComposer f) f) {
    final $$ExamComponentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examComponents,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamComponentsTableFilterComposer(
              $db: $db,
              $table: $db.examComponents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> examMarksRefs(
      Expression<bool> Function($$ExamMarksTableFilterComposer f) f) {
    final $$ExamMarksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examMarks,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamMarksTableFilterComposer(
              $db: $db,
              $table: $db.examMarks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExamsTableOrderingComposer
    extends Composer<_$SchoolDatabase, $ExamsTable> {
  $$ExamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get examDate => $composableBuilder(
      column: $table.examDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPublished => $composableBuilder(
      column: $table.isPublished, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ClassroomsTableOrderingComposer get classroomId {
    final $$ClassroomsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classroomId,
        referencedTable: $db.classrooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassroomsTableOrderingComposer(
              $db: $db,
              $table: $db.classrooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExamsTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $ExamsTable> {
  $$ExamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get examDate =>
      $composableBuilder(column: $table.examDate, builder: (column) => column);

  GeneratedColumn<bool> get isPublished => $composableBuilder(
      column: $table.isPublished, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ClassroomsTableAnnotationComposer get classroomId {
    final $$ClassroomsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classroomId,
        referencedTable: $db.classrooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassroomsTableAnnotationComposer(
              $db: $db,
              $table: $db.classrooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> examComponentsRefs<T extends Object>(
      Expression<T> Function($$ExamComponentsTableAnnotationComposer a) f) {
    final $$ExamComponentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examComponents,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamComponentsTableAnnotationComposer(
              $db: $db,
              $table: $db.examComponents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> examMarksRefs<T extends Object>(
      Expression<T> Function($$ExamMarksTableAnnotationComposer a) f) {
    final $$ExamMarksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examMarks,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamMarksTableAnnotationComposer(
              $db: $db,
              $table: $db.examMarks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExamsTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $ExamsTable,
    Exam,
    $$ExamsTableFilterComposer,
    $$ExamsTableOrderingComposer,
    $$ExamsTableAnnotationComposer,
    $$ExamsTableCreateCompanionBuilder,
    $$ExamsTableUpdateCompanionBuilder,
    (Exam, $$ExamsTableReferences),
    Exam,
    PrefetchHooks Function(
        {bool classroomId, bool examComponentsRefs, bool examMarksRefs})> {
  $$ExamsTableTableManager(_$SchoolDatabase db, $ExamsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<int> classroomId = const Value.absent(),
            Value<DateTime?> examDate = const Value.absent(),
            Value<bool> isPublished = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ExamsCompanion(
            id: id,
            title: title,
            classroomId: classroomId,
            examDate: examDate,
            isPublished: isPublished,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required int classroomId,
            Value<DateTime?> examDate = const Value.absent(),
            Value<bool> isPublished = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ExamsCompanion.insert(
            id: id,
            title: title,
            classroomId: classroomId,
            examDate: examDate,
            isPublished: isPublished,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ExamsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {classroomId = false,
              examComponentsRefs = false,
              examMarksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (examComponentsRefs) db.examComponents,
                if (examMarksRefs) db.examMarks
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (classroomId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.classroomId,
                    referencedTable:
                        $$ExamsTableReferences._classroomIdTable(db),
                    referencedColumn:
                        $$ExamsTableReferences._classroomIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (examComponentsRefs)
                    await $_getPrefetchedData<Exam, $ExamsTable, ExamComponent>(
                        currentTable: table,
                        referencedTable:
                            $$ExamsTableReferences._examComponentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExamsTableReferences(db, table, p0)
                                .examComponentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.examId == item.id),
                        typedResults: items),
                  if (examMarksRefs)
                    await $_getPrefetchedData<Exam, $ExamsTable, ExamMark>(
                        currentTable: table,
                        referencedTable:
                            $$ExamsTableReferences._examMarksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExamsTableReferences(db, table, p0).examMarksRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.examId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExamsTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $ExamsTable,
    Exam,
    $$ExamsTableFilterComposer,
    $$ExamsTableOrderingComposer,
    $$ExamsTableAnnotationComposer,
    $$ExamsTableCreateCompanionBuilder,
    $$ExamsTableUpdateCompanionBuilder,
    (Exam, $$ExamsTableReferences),
    Exam,
    PrefetchHooks Function(
        {bool classroomId, bool examComponentsRefs, bool examMarksRefs})>;
typedef $$ExamComponentsTableCreateCompanionBuilder = ExamComponentsCompanion
    Function({
  Value<int> id,
  required int examId,
  required String name,
  Value<double> weight,
  required int maxMarks,
});
typedef $$ExamComponentsTableUpdateCompanionBuilder = ExamComponentsCompanion
    Function({
  Value<int> id,
  Value<int> examId,
  Value<String> name,
  Value<double> weight,
  Value<int> maxMarks,
});

final class $$ExamComponentsTableReferences extends BaseReferences<
    _$SchoolDatabase, $ExamComponentsTable, ExamComponent> {
  $$ExamComponentsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ExamsTable _examIdTable(_$SchoolDatabase db) => db.exams
      .createAlias($_aliasNameGenerator(db.examComponents.examId, db.exams.id));

  $$ExamsTableProcessedTableManager get examId {
    final $_column = $_itemColumn<int>('exam_id')!;

    final manager = $$ExamsTableTableManager($_db, $_db.exams)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_examIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ExamMarksTable, List<ExamMark>>
      _examMarksRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.examMarks,
              aliasName: $_aliasNameGenerator(
                  db.examComponents.id, db.examMarks.componentId));

  $$ExamMarksTableProcessedTableManager get examMarksRefs {
    final manager = $$ExamMarksTableTableManager($_db, $_db.examMarks)
        .filter((f) => f.componentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_examMarksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExamComponentsTableFilterComposer
    extends Composer<_$SchoolDatabase, $ExamComponentsTable> {
  $$ExamComponentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxMarks => $composableBuilder(
      column: $table.maxMarks, builder: (column) => ColumnFilters(column));

  $$ExamsTableFilterComposer get examId {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableFilterComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> examMarksRefs(
      Expression<bool> Function($$ExamMarksTableFilterComposer f) f) {
    final $$ExamMarksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examMarks,
        getReferencedColumn: (t) => t.componentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamMarksTableFilterComposer(
              $db: $db,
              $table: $db.examMarks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExamComponentsTableOrderingComposer
    extends Composer<_$SchoolDatabase, $ExamComponentsTable> {
  $$ExamComponentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxMarks => $composableBuilder(
      column: $table.maxMarks, builder: (column) => ColumnOrderings(column));

  $$ExamsTableOrderingComposer get examId {
    final $$ExamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableOrderingComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExamComponentsTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $ExamComponentsTable> {
  $$ExamComponentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<int> get maxMarks =>
      $composableBuilder(column: $table.maxMarks, builder: (column) => column);

  $$ExamsTableAnnotationComposer get examId {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableAnnotationComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> examMarksRefs<T extends Object>(
      Expression<T> Function($$ExamMarksTableAnnotationComposer a) f) {
    final $$ExamMarksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examMarks,
        getReferencedColumn: (t) => t.componentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamMarksTableAnnotationComposer(
              $db: $db,
              $table: $db.examMarks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExamComponentsTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $ExamComponentsTable,
    ExamComponent,
    $$ExamComponentsTableFilterComposer,
    $$ExamComponentsTableOrderingComposer,
    $$ExamComponentsTableAnnotationComposer,
    $$ExamComponentsTableCreateCompanionBuilder,
    $$ExamComponentsTableUpdateCompanionBuilder,
    (ExamComponent, $$ExamComponentsTableReferences),
    ExamComponent,
    PrefetchHooks Function({bool examId, bool examMarksRefs})> {
  $$ExamComponentsTableTableManager(
      _$SchoolDatabase db, $ExamComponentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamComponentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamComponentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamComponentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> examId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<int> maxMarks = const Value.absent(),
          }) =>
              ExamComponentsCompanion(
            id: id,
            examId: examId,
            name: name,
            weight: weight,
            maxMarks: maxMarks,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int examId,
            required String name,
            Value<double> weight = const Value.absent(),
            required int maxMarks,
          }) =>
              ExamComponentsCompanion.insert(
            id: id,
            examId: examId,
            name: name,
            weight: weight,
            maxMarks: maxMarks,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExamComponentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({examId = false, examMarksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (examMarksRefs) db.examMarks],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (examId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.examId,
                    referencedTable:
                        $$ExamComponentsTableReferences._examIdTable(db),
                    referencedColumn:
                        $$ExamComponentsTableReferences._examIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (examMarksRefs)
                    await $_getPrefetchedData<ExamComponent,
                            $ExamComponentsTable, ExamMark>(
                        currentTable: table,
                        referencedTable: $$ExamComponentsTableReferences
                            ._examMarksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExamComponentsTableReferences(db, table, p0)
                                .examMarksRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.componentId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExamComponentsTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $ExamComponentsTable,
    ExamComponent,
    $$ExamComponentsTableFilterComposer,
    $$ExamComponentsTableOrderingComposer,
    $$ExamComponentsTableAnnotationComposer,
    $$ExamComponentsTableCreateCompanionBuilder,
    $$ExamComponentsTableUpdateCompanionBuilder,
    (ExamComponent, $$ExamComponentsTableReferences),
    ExamComponent,
    PrefetchHooks Function({bool examId, bool examMarksRefs})>;
typedef $$ExamMarksTableCreateCompanionBuilder = ExamMarksCompanion Function({
  Value<int> id,
  required int examId,
  required int studentId,
  required int componentId,
  Value<double> marksObtained,
});
typedef $$ExamMarksTableUpdateCompanionBuilder = ExamMarksCompanion Function({
  Value<int> id,
  Value<int> examId,
  Value<int> studentId,
  Value<int> componentId,
  Value<double> marksObtained,
});

final class $$ExamMarksTableReferences
    extends BaseReferences<_$SchoolDatabase, $ExamMarksTable, ExamMark> {
  $$ExamMarksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExamsTable _examIdTable(_$SchoolDatabase db) => db.exams
      .createAlias($_aliasNameGenerator(db.examMarks.examId, db.exams.id));

  $$ExamsTableProcessedTableManager get examId {
    final $_column = $_itemColumn<int>('exam_id')!;

    final manager = $$ExamsTableTableManager($_db, $_db.exams)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_examIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $StudentsTable _studentIdTable(_$SchoolDatabase db) =>
      db.students.createAlias(
          $_aliasNameGenerator(db.examMarks.studentId, db.students.id));

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager($_db, $_db.students)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ExamComponentsTable _componentIdTable(_$SchoolDatabase db) =>
      db.examComponents.createAlias(
          $_aliasNameGenerator(db.examMarks.componentId, db.examComponents.id));

  $$ExamComponentsTableProcessedTableManager get componentId {
    final $_column = $_itemColumn<int>('component_id')!;

    final manager = $$ExamComponentsTableTableManager($_db, $_db.examComponents)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_componentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ExamMarksTableFilterComposer
    extends Composer<_$SchoolDatabase, $ExamMarksTable> {
  $$ExamMarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get marksObtained => $composableBuilder(
      column: $table.marksObtained, builder: (column) => ColumnFilters(column));

  $$ExamsTableFilterComposer get examId {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableFilterComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableFilterComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExamComponentsTableFilterComposer get componentId {
    final $$ExamComponentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.componentId,
        referencedTable: $db.examComponents,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamComponentsTableFilterComposer(
              $db: $db,
              $table: $db.examComponents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExamMarksTableOrderingComposer
    extends Composer<_$SchoolDatabase, $ExamMarksTable> {
  $$ExamMarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get marksObtained => $composableBuilder(
      column: $table.marksObtained,
      builder: (column) => ColumnOrderings(column));

  $$ExamsTableOrderingComposer get examId {
    final $$ExamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableOrderingComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableOrderingComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExamComponentsTableOrderingComposer get componentId {
    final $$ExamComponentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.componentId,
        referencedTable: $db.examComponents,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamComponentsTableOrderingComposer(
              $db: $db,
              $table: $db.examComponents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExamMarksTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $ExamMarksTable> {
  $$ExamMarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get marksObtained => $composableBuilder(
      column: $table.marksObtained, builder: (column) => column);

  $$ExamsTableAnnotationComposer get examId {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableAnnotationComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableAnnotationComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExamComponentsTableAnnotationComposer get componentId {
    final $$ExamComponentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.componentId,
        referencedTable: $db.examComponents,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamComponentsTableAnnotationComposer(
              $db: $db,
              $table: $db.examComponents,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExamMarksTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $ExamMarksTable,
    ExamMark,
    $$ExamMarksTableFilterComposer,
    $$ExamMarksTableOrderingComposer,
    $$ExamMarksTableAnnotationComposer,
    $$ExamMarksTableCreateCompanionBuilder,
    $$ExamMarksTableUpdateCompanionBuilder,
    (ExamMark, $$ExamMarksTableReferences),
    ExamMark,
    PrefetchHooks Function({bool examId, bool studentId, bool componentId})> {
  $$ExamMarksTableTableManager(_$SchoolDatabase db, $ExamMarksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamMarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamMarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamMarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> examId = const Value.absent(),
            Value<int> studentId = const Value.absent(),
            Value<int> componentId = const Value.absent(),
            Value<double> marksObtained = const Value.absent(),
          }) =>
              ExamMarksCompanion(
            id: id,
            examId: examId,
            studentId: studentId,
            componentId: componentId,
            marksObtained: marksObtained,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int examId,
            required int studentId,
            required int componentId,
            Value<double> marksObtained = const Value.absent(),
          }) =>
              ExamMarksCompanion.insert(
            id: id,
            examId: examId,
            studentId: studentId,
            componentId: componentId,
            marksObtained: marksObtained,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExamMarksTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {examId = false, studentId = false, componentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (examId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.examId,
                    referencedTable:
                        $$ExamMarksTableReferences._examIdTable(db),
                    referencedColumn:
                        $$ExamMarksTableReferences._examIdTable(db).id,
                  ) as T;
                }
                if (studentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.studentId,
                    referencedTable:
                        $$ExamMarksTableReferences._studentIdTable(db),
                    referencedColumn:
                        $$ExamMarksTableReferences._studentIdTable(db).id,
                  ) as T;
                }
                if (componentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.componentId,
                    referencedTable:
                        $$ExamMarksTableReferences._componentIdTable(db),
                    referencedColumn:
                        $$ExamMarksTableReferences._componentIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ExamMarksTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $ExamMarksTable,
    ExamMark,
    $$ExamMarksTableFilterComposer,
    $$ExamMarksTableOrderingComposer,
    $$ExamMarksTableAnnotationComposer,
    $$ExamMarksTableCreateCompanionBuilder,
    $$ExamMarksTableUpdateCompanionBuilder,
    (ExamMark, $$ExamMarksTableReferences),
    ExamMark,
    PrefetchHooks Function({bool examId, bool studentId, bool componentId})>;
typedef $$GradeScalesTableCreateCompanionBuilder = GradeScalesCompanion
    Function({
  Value<int> id,
  required double minPercent,
  required double maxPercent,
  required String grade,
  Value<String?> remark,
});
typedef $$GradeScalesTableUpdateCompanionBuilder = GradeScalesCompanion
    Function({
  Value<int> id,
  Value<double> minPercent,
  Value<double> maxPercent,
  Value<String> grade,
  Value<String?> remark,
});

class $$GradeScalesTableFilterComposer
    extends Composer<_$SchoolDatabase, $GradeScalesTable> {
  $$GradeScalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get minPercent => $composableBuilder(
      column: $table.minPercent, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get maxPercent => $composableBuilder(
      column: $table.maxPercent, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remark => $composableBuilder(
      column: $table.remark, builder: (column) => ColumnFilters(column));
}

class $$GradeScalesTableOrderingComposer
    extends Composer<_$SchoolDatabase, $GradeScalesTable> {
  $$GradeScalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get minPercent => $composableBuilder(
      column: $table.minPercent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get maxPercent => $composableBuilder(
      column: $table.maxPercent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remark => $composableBuilder(
      column: $table.remark, builder: (column) => ColumnOrderings(column));
}

class $$GradeScalesTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $GradeScalesTable> {
  $$GradeScalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get minPercent => $composableBuilder(
      column: $table.minPercent, builder: (column) => column);

  GeneratedColumn<double> get maxPercent => $composableBuilder(
      column: $table.maxPercent, builder: (column) => column);

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<String> get remark =>
      $composableBuilder(column: $table.remark, builder: (column) => column);
}

class $$GradeScalesTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $GradeScalesTable,
    GradeScale,
    $$GradeScalesTableFilterComposer,
    $$GradeScalesTableOrderingComposer,
    $$GradeScalesTableAnnotationComposer,
    $$GradeScalesTableCreateCompanionBuilder,
    $$GradeScalesTableUpdateCompanionBuilder,
    (
      GradeScale,
      BaseReferences<_$SchoolDatabase, $GradeScalesTable, GradeScale>
    ),
    GradeScale,
    PrefetchHooks Function()> {
  $$GradeScalesTableTableManager(_$SchoolDatabase db, $GradeScalesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GradeScalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GradeScalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GradeScalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<double> minPercent = const Value.absent(),
            Value<double> maxPercent = const Value.absent(),
            Value<String> grade = const Value.absent(),
            Value<String?> remark = const Value.absent(),
          }) =>
              GradeScalesCompanion(
            id: id,
            minPercent: minPercent,
            maxPercent: maxPercent,
            grade: grade,
            remark: remark,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required double minPercent,
            required double maxPercent,
            required String grade,
            Value<String?> remark = const Value.absent(),
          }) =>
              GradeScalesCompanion.insert(
            id: id,
            minPercent: minPercent,
            maxPercent: maxPercent,
            grade: grade,
            remark: remark,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GradeScalesTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $GradeScalesTable,
    GradeScale,
    $$GradeScalesTableFilterComposer,
    $$GradeScalesTableOrderingComposer,
    $$GradeScalesTableAnnotationComposer,
    $$GradeScalesTableCreateCompanionBuilder,
    $$GradeScalesTableUpdateCompanionBuilder,
    (
      GradeScale,
      BaseReferences<_$SchoolDatabase, $GradeScalesTable, GradeScale>
    ),
    GradeScale,
    PrefetchHooks Function()>;
typedef $$ExpenseCategoriesTableCreateCompanionBuilder
    = ExpenseCategoriesCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$ExpenseCategoriesTableUpdateCompanionBuilder
    = ExpenseCategoriesCompanion Function({
  Value<int> id,
  Value<String> name,
});

final class $$ExpenseCategoriesTableReferences extends BaseReferences<
    _$SchoolDatabase, $ExpenseCategoriesTable, ExpenseCategory> {
  $$ExpenseCategoriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ExpensesTable, List<Expense>> _expensesRefsTable(
          _$SchoolDatabase db) =>
      MultiTypedResultKey.fromTable(db.expenses,
          aliasName: $_aliasNameGenerator(
              db.expenseCategories.id, db.expenses.categoryId));

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager($_db, $_db.expenses)
        .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExpenseCategoriesTableFilterComposer
    extends Composer<_$SchoolDatabase, $ExpenseCategoriesTable> {
  $$ExpenseCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  Expression<bool> expensesRefs(
      Expression<bool> Function($$ExpensesTableFilterComposer f) f) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.expenses,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpensesTableFilterComposer(
              $db: $db,
              $table: $db.expenses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExpenseCategoriesTableOrderingComposer
    extends Composer<_$SchoolDatabase, $ExpenseCategoriesTable> {
  $$ExpenseCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$ExpenseCategoriesTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $ExpenseCategoriesTable> {
  $$ExpenseCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> expensesRefs<T extends Object>(
      Expression<T> Function($$ExpensesTableAnnotationComposer a) f) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.expenses,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpensesTableAnnotationComposer(
              $db: $db,
              $table: $db.expenses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExpenseCategoriesTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $ExpenseCategoriesTable,
    ExpenseCategory,
    $$ExpenseCategoriesTableFilterComposer,
    $$ExpenseCategoriesTableOrderingComposer,
    $$ExpenseCategoriesTableAnnotationComposer,
    $$ExpenseCategoriesTableCreateCompanionBuilder,
    $$ExpenseCategoriesTableUpdateCompanionBuilder,
    (ExpenseCategory, $$ExpenseCategoriesTableReferences),
    ExpenseCategory,
    PrefetchHooks Function({bool expensesRefs})> {
  $$ExpenseCategoriesTableTableManager(
      _$SchoolDatabase db, $ExpenseCategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseCategoriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) =>
              ExpenseCategoriesCompanion(
            id: id,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) =>
              ExpenseCategoriesCompanion.insert(
            id: id,
            name: name,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExpenseCategoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({expensesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (expensesRefs) db.expenses],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (expensesRefs)
                    await $_getPrefetchedData<ExpenseCategory, $ExpenseCategoriesTable,
                            Expense>(
                        currentTable: table,
                        referencedTable: $$ExpenseCategoriesTableReferences
                            ._expensesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExpenseCategoriesTableReferences(db, table, p0)
                                .expensesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExpenseCategoriesTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $ExpenseCategoriesTable,
    ExpenseCategory,
    $$ExpenseCategoriesTableFilterComposer,
    $$ExpenseCategoriesTableOrderingComposer,
    $$ExpenseCategoriesTableAnnotationComposer,
    $$ExpenseCategoriesTableCreateCompanionBuilder,
    $$ExpenseCategoriesTableUpdateCompanionBuilder,
    (ExpenseCategory, $$ExpenseCategoriesTableReferences),
    ExpenseCategory,
    PrefetchHooks Function({bool expensesRefs})>;
typedef $$ExpensesTableCreateCompanionBuilder = ExpensesCompanion Function({
  Value<int> id,
  required int categoryId,
  required int amount,
  required String voucherNo,
  Value<String?> note,
  Value<DateTime> spentAt,
  Value<int?> approvedBy,
});
typedef $$ExpensesTableUpdateCompanionBuilder = ExpensesCompanion Function({
  Value<int> id,
  Value<int> categoryId,
  Value<int> amount,
  Value<String> voucherNo,
  Value<String?> note,
  Value<DateTime> spentAt,
  Value<int?> approvedBy,
});

final class $$ExpensesTableReferences
    extends BaseReferences<_$SchoolDatabase, $ExpensesTable, Expense> {
  $$ExpensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExpenseCategoriesTable _categoryIdTable(_$SchoolDatabase db) =>
      db.expenseCategories.createAlias($_aliasNameGenerator(
          db.expenses.categoryId, db.expenseCategories.id));

  $$ExpenseCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager =
        $$ExpenseCategoriesTableTableManager($_db, $_db.expenseCategories)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _approvedByTable(_$SchoolDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.expenses.approvedBy, db.users.id));

  $$UsersTableProcessedTableManager? get approvedBy {
    final $_column = $_itemColumn<int>('approved_by');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_approvedByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ExpensesTableFilterComposer
    extends Composer<_$SchoolDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get voucherNo => $composableBuilder(
      column: $table.voucherNo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get spentAt => $composableBuilder(
      column: $table.spentAt, builder: (column) => ColumnFilters(column));

  $$ExpenseCategoriesTableFilterComposer get categoryId {
    final $$ExpenseCategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.expenseCategories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpenseCategoriesTableFilterComposer(
              $db: $db,
              $table: $db.expenseCategories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get approvedBy {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.approvedBy,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$SchoolDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get voucherNo => $composableBuilder(
      column: $table.voucherNo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get spentAt => $composableBuilder(
      column: $table.spentAt, builder: (column) => ColumnOrderings(column));

  $$ExpenseCategoriesTableOrderingComposer get categoryId {
    final $$ExpenseCategoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.expenseCategories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpenseCategoriesTableOrderingComposer(
              $db: $db,
              $table: $db.expenseCategories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get approvedBy {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.approvedBy,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get voucherNo =>
      $composableBuilder(column: $table.voucherNo, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get spentAt =>
      $composableBuilder(column: $table.spentAt, builder: (column) => column);

  $$ExpenseCategoriesTableAnnotationComposer get categoryId {
    final $$ExpenseCategoriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.categoryId,
            referencedTable: $db.expenseCategories,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ExpenseCategoriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.expenseCategories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  $$UsersTableAnnotationComposer get approvedBy {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.approvedBy,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExpensesTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (Expense, $$ExpensesTableReferences),
    Expense,
    PrefetchHooks Function({bool categoryId, bool approvedBy})> {
  $$ExpensesTableTableManager(_$SchoolDatabase db, $ExpensesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<String> voucherNo = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> spentAt = const Value.absent(),
            Value<int?> approvedBy = const Value.absent(),
          }) =>
              ExpensesCompanion(
            id: id,
            categoryId: categoryId,
            amount: amount,
            voucherNo: voucherNo,
            note: note,
            spentAt: spentAt,
            approvedBy: approvedBy,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int categoryId,
            required int amount,
            required String voucherNo,
            Value<String?> note = const Value.absent(),
            Value<DateTime> spentAt = const Value.absent(),
            Value<int?> approvedBy = const Value.absent(),
          }) =>
              ExpensesCompanion.insert(
            id: id,
            categoryId: categoryId,
            amount: amount,
            voucherNo: voucherNo,
            note: note,
            spentAt: spentAt,
            approvedBy: approvedBy,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ExpensesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({categoryId = false, approvedBy = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable:
                        $$ExpensesTableReferences._categoryIdTable(db),
                    referencedColumn:
                        $$ExpensesTableReferences._categoryIdTable(db).id,
                  ) as T;
                }
                if (approvedBy) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.approvedBy,
                    referencedTable:
                        $$ExpensesTableReferences._approvedByTable(db),
                    referencedColumn:
                        $$ExpensesTableReferences._approvedByTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ExpensesTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (Expense, $$ExpensesTableReferences),
    Expense,
    PrefetchHooks Function({bool categoryId, bool approvedBy})>;
typedef $$SyncQueueTableCreateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  required String entity,
  required String operation,
  required String payloadJson,
  Value<String> status,
  Value<int> retryCount,
  Value<DateTime> createdAt,
  Value<DateTime?> lastTriedAt,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  Value<String> entity,
  Value<String> operation,
  Value<String> payloadJson,
  Value<String> status,
  Value<int> retryCount,
  Value<DateTime> createdAt,
  Value<DateTime?> lastTriedAt,
});

class $$SyncQueueTableFilterComposer
    extends Composer<_$SchoolDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entity => $composableBuilder(
      column: $table.entity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastTriedAt => $composableBuilder(
      column: $table.lastTriedAt, builder: (column) => ColumnFilters(column));
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$SchoolDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entity => $composableBuilder(
      column: $table.entity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastTriedAt => $composableBuilder(
      column: $table.lastTriedAt, builder: (column) => ColumnOrderings(column));
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entity =>
      $composableBuilder(column: $table.entity, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastTriedAt => $composableBuilder(
      column: $table.lastTriedAt, builder: (column) => column);
}

class $$SyncQueueTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$SchoolDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()> {
  $$SyncQueueTableTableManager(_$SchoolDatabase db, $SyncQueueTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> entity = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> payloadJson = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastTriedAt = const Value.absent(),
          }) =>
              SyncQueueCompanion(
            id: id,
            entity: entity,
            operation: operation,
            payloadJson: payloadJson,
            status: status,
            retryCount: retryCount,
            createdAt: createdAt,
            lastTriedAt: lastTriedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String entity,
            required String operation,
            required String payloadJson,
            Value<String> status = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastTriedAt = const Value.absent(),
          }) =>
              SyncQueueCompanion.insert(
            id: id,
            entity: entity,
            operation: operation,
            payloadJson: payloadJson,
            status: status,
            retryCount: retryCount,
            createdAt: createdAt,
            lastTriedAt: lastTriedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncQueueTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$SchoolDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()>;
typedef $$SubjectsTableCreateCompanionBuilder = SubjectsCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> code,
  Value<bool> isActive,
});
typedef $$SubjectsTableUpdateCompanionBuilder = SubjectsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> code,
  Value<bool> isActive,
});

final class $$SubjectsTableReferences
    extends BaseReferences<_$SchoolDatabase, $SubjectsTable, Subject> {
  $$SubjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TeacherAssignmentsTable, List<TeacherAssignment>>
      _teacherAssignmentsRefsTable(_$SchoolDatabase db) =>
          MultiTypedResultKey.fromTable(db.teacherAssignments,
              aliasName: $_aliasNameGenerator(
                  db.subjects.id, db.teacherAssignments.subjectId));

  $$TeacherAssignmentsTableProcessedTableManager get teacherAssignmentsRefs {
    final manager =
        $$TeacherAssignmentsTableTableManager($_db, $_db.teacherAssignments)
            .filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_teacherAssignmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SubjectsTableFilterComposer
    extends Composer<_$SchoolDatabase, $SubjectsTable> {
  $$SubjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  Expression<bool> teacherAssignmentsRefs(
      Expression<bool> Function($$TeacherAssignmentsTableFilterComposer f) f) {
    final $$TeacherAssignmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.teacherAssignments,
        getReferencedColumn: (t) => t.subjectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeacherAssignmentsTableFilterComposer(
              $db: $db,
              $table: $db.teacherAssignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SubjectsTableOrderingComposer
    extends Composer<_$SchoolDatabase, $SubjectsTable> {
  $$SubjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$SubjectsTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $SubjectsTable> {
  $$SubjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> teacherAssignmentsRefs<T extends Object>(
      Expression<T> Function($$TeacherAssignmentsTableAnnotationComposer a) f) {
    final $$TeacherAssignmentsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.teacherAssignments,
            getReferencedColumn: (t) => t.subjectId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TeacherAssignmentsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.teacherAssignments,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$SubjectsTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $SubjectsTable,
    Subject,
    $$SubjectsTableFilterComposer,
    $$SubjectsTableOrderingComposer,
    $$SubjectsTableAnnotationComposer,
    $$SubjectsTableCreateCompanionBuilder,
    $$SubjectsTableUpdateCompanionBuilder,
    (Subject, $$SubjectsTableReferences),
    Subject,
    PrefetchHooks Function({bool teacherAssignmentsRefs})> {
  $$SubjectsTableTableManager(_$SchoolDatabase db, $SubjectsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              SubjectsCompanion(
            id: id,
            name: name,
            code: code,
            isActive: isActive,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> code = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              SubjectsCompanion.insert(
            id: id,
            name: name,
            code: code,
            isActive: isActive,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$SubjectsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({teacherAssignmentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (teacherAssignmentsRefs) db.teacherAssignments
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (teacherAssignmentsRefs)
                    await $_getPrefetchedData<Subject, $SubjectsTable,
                            TeacherAssignment>(
                        currentTable: table,
                        referencedTable: $$SubjectsTableReferences
                            ._teacherAssignmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SubjectsTableReferences(db, table, p0)
                                .teacherAssignmentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.subjectId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SubjectsTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $SubjectsTable,
    Subject,
    $$SubjectsTableFilterComposer,
    $$SubjectsTableOrderingComposer,
    $$SubjectsTableAnnotationComposer,
    $$SubjectsTableCreateCompanionBuilder,
    $$SubjectsTableUpdateCompanionBuilder,
    (Subject, $$SubjectsTableReferences),
    Subject,
    PrefetchHooks Function({bool teacherAssignmentsRefs})>;
typedef $$TeacherAssignmentsTableCreateCompanionBuilder
    = TeacherAssignmentsCompanion Function({
  Value<int> id,
  required int staffId,
  required int classroomId,
  required int subjectId,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});
typedef $$TeacherAssignmentsTableUpdateCompanionBuilder
    = TeacherAssignmentsCompanion Function({
  Value<int> id,
  Value<int> staffId,
  Value<int> classroomId,
  Value<int> subjectId,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});

final class $$TeacherAssignmentsTableReferences extends BaseReferences<
    _$SchoolDatabase, $TeacherAssignmentsTable, TeacherAssignment> {
  $$TeacherAssignmentsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $StaffTable _staffIdTable(_$SchoolDatabase db) => db.staff.createAlias(
      $_aliasNameGenerator(db.teacherAssignments.staffId, db.staff.id));

  $$StaffTableProcessedTableManager get staffId {
    final $_column = $_itemColumn<int>('staff_id')!;

    final manager = $$StaffTableTableManager($_db, $_db.staff)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_staffIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ClassroomsTable _classroomIdTable(_$SchoolDatabase db) =>
      db.classrooms.createAlias($_aliasNameGenerator(
          db.teacherAssignments.classroomId, db.classrooms.id));

  $$ClassroomsTableProcessedTableManager get classroomId {
    final $_column = $_itemColumn<int>('classroom_id')!;

    final manager = $$ClassroomsTableTableManager($_db, $_db.classrooms)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classroomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SubjectsTable _subjectIdTable(_$SchoolDatabase db) =>
      db.subjects.createAlias($_aliasNameGenerator(
          db.teacherAssignments.subjectId, db.subjects.id));

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<int>('subject_id')!;

    final manager = $$SubjectsTableTableManager($_db, $_db.subjects)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TeacherAssignmentsTableFilterComposer
    extends Composer<_$SchoolDatabase, $TeacherAssignmentsTable> {
  $$TeacherAssignmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$StaffTableFilterComposer get staffId {
    final $$StaffTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.staffId,
        referencedTable: $db.staff,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StaffTableFilterComposer(
              $db: $db,
              $table: $db.staff,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassroomsTableFilterComposer get classroomId {
    final $$ClassroomsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classroomId,
        referencedTable: $db.classrooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassroomsTableFilterComposer(
              $db: $db,
              $table: $db.classrooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableFilterComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TeacherAssignmentsTableOrderingComposer
    extends Composer<_$SchoolDatabase, $TeacherAssignmentsTable> {
  $$TeacherAssignmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$StaffTableOrderingComposer get staffId {
    final $$StaffTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.staffId,
        referencedTable: $db.staff,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StaffTableOrderingComposer(
              $db: $db,
              $table: $db.staff,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassroomsTableOrderingComposer get classroomId {
    final $$ClassroomsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classroomId,
        referencedTable: $db.classrooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassroomsTableOrderingComposer(
              $db: $db,
              $table: $db.classrooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableOrderingComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TeacherAssignmentsTableAnnotationComposer
    extends Composer<_$SchoolDatabase, $TeacherAssignmentsTable> {
  $$TeacherAssignmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$StaffTableAnnotationComposer get staffId {
    final $$StaffTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.staffId,
        referencedTable: $db.staff,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StaffTableAnnotationComposer(
              $db: $db,
              $table: $db.staff,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassroomsTableAnnotationComposer get classroomId {
    final $$ClassroomsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classroomId,
        referencedTable: $db.classrooms,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassroomsTableAnnotationComposer(
              $db: $db,
              $table: $db.classrooms,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TeacherAssignmentsTableTableManager extends RootTableManager<
    _$SchoolDatabase,
    $TeacherAssignmentsTable,
    TeacherAssignment,
    $$TeacherAssignmentsTableFilterComposer,
    $$TeacherAssignmentsTableOrderingComposer,
    $$TeacherAssignmentsTableAnnotationComposer,
    $$TeacherAssignmentsTableCreateCompanionBuilder,
    $$TeacherAssignmentsTableUpdateCompanionBuilder,
    (TeacherAssignment, $$TeacherAssignmentsTableReferences),
    TeacherAssignment,
    PrefetchHooks Function({bool staffId, bool classroomId, bool subjectId})> {
  $$TeacherAssignmentsTableTableManager(
      _$SchoolDatabase db, $TeacherAssignmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeacherAssignmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeacherAssignmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeacherAssignmentsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> staffId = const Value.absent(),
            Value<int> classroomId = const Value.absent(),
            Value<int> subjectId = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TeacherAssignmentsCompanion(
            id: id,
            staffId: staffId,
            classroomId: classroomId,
            subjectId: subjectId,
            isActive: isActive,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int staffId,
            required int classroomId,
            required int subjectId,
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TeacherAssignmentsCompanion.insert(
            id: id,
            staffId: staffId,
            classroomId: classroomId,
            subjectId: subjectId,
            isActive: isActive,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TeacherAssignmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {staffId = false, classroomId = false, subjectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (staffId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.staffId,
                    referencedTable:
                        $$TeacherAssignmentsTableReferences._staffIdTable(db),
                    referencedColumn: $$TeacherAssignmentsTableReferences
                        ._staffIdTable(db)
                        .id,
                  ) as T;
                }
                if (classroomId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.classroomId,
                    referencedTable: $$TeacherAssignmentsTableReferences
                        ._classroomIdTable(db),
                    referencedColumn: $$TeacherAssignmentsTableReferences
                        ._classroomIdTable(db)
                        .id,
                  ) as T;
                }
                if (subjectId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.subjectId,
                    referencedTable:
                        $$TeacherAssignmentsTableReferences._subjectIdTable(db),
                    referencedColumn: $$TeacherAssignmentsTableReferences
                        ._subjectIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TeacherAssignmentsTableProcessedTableManager = ProcessedTableManager<
    _$SchoolDatabase,
    $TeacherAssignmentsTable,
    TeacherAssignment,
    $$TeacherAssignmentsTableFilterComposer,
    $$TeacherAssignmentsTableOrderingComposer,
    $$TeacherAssignmentsTableAnnotationComposer,
    $$TeacherAssignmentsTableCreateCompanionBuilder,
    $$TeacherAssignmentsTableUpdateCompanionBuilder,
    (TeacherAssignment, $$TeacherAssignmentsTableReferences),
    TeacherAssignment,
    PrefetchHooks Function({bool staffId, bool classroomId, bool subjectId})>;

class $SchoolDatabaseManager {
  final _$SchoolDatabase _db;
  $SchoolDatabaseManager(this._db);
  $$RolesTableTableManager get roles =>
      $$RolesTableTableManager(_db, _db.roles);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ClassroomsTableTableManager get classrooms =>
      $$ClassroomsTableTableManager(_db, _db.classrooms);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db, _db.students);
  $$EnrollmentsTableTableManager get enrollments =>
      $$EnrollmentsTableTableManager(_db, _db.enrollments);
  $$FeeHeadsTableTableManager get feeHeads =>
      $$FeeHeadsTableTableManager(_db, _db.feeHeads);
  $$FeeStructuresTableTableManager get feeStructures =>
      $$FeeStructuresTableTableManager(_db, _db.feeStructures);
  $$FeeInvoicesTableTableManager get feeInvoices =>
      $$FeeInvoicesTableTableManager(_db, _db.feeInvoices);
  $$FeeInvoiceLinesTableTableManager get feeInvoiceLines =>
      $$FeeInvoiceLinesTableTableManager(_db, _db.feeInvoiceLines);
  $$FeePaymentsTableTableManager get feePayments =>
      $$FeePaymentsTableTableManager(_db, _db.feePayments);
  $$FeePaymentAllocationsTableTableManager get feePaymentAllocations =>
      $$FeePaymentAllocationsTableTableManager(_db, _db.feePaymentAllocations);
  $$StaffTableTableManager get staff =>
      $$StaffTableTableManager(_db, _db.staff);
  $$StaffAttendanceTableTableManager get staffAttendance =>
      $$StaffAttendanceTableTableManager(_db, _db.staffAttendance);
  $$SalaryAdvancesTableTableManager get salaryAdvances =>
      $$SalaryAdvancesTableTableManager(_db, _db.salaryAdvances);
  $$PayrollRunsTableTableManager get payrollRuns =>
      $$PayrollRunsTableTableManager(_db, _db.payrollRuns);
  $$PayrollLinesTableTableManager get payrollLines =>
      $$PayrollLinesTableTableManager(_db, _db.payrollLines);
  $$ExamsTableTableManager get exams =>
      $$ExamsTableTableManager(_db, _db.exams);
  $$ExamComponentsTableTableManager get examComponents =>
      $$ExamComponentsTableTableManager(_db, _db.examComponents);
  $$ExamMarksTableTableManager get examMarks =>
      $$ExamMarksTableTableManager(_db, _db.examMarks);
  $$GradeScalesTableTableManager get gradeScales =>
      $$GradeScalesTableTableManager(_db, _db.gradeScales);
  $$ExpenseCategoriesTableTableManager get expenseCategories =>
      $$ExpenseCategoriesTableTableManager(_db, _db.expenseCategories);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$SubjectsTableTableManager get subjects =>
      $$SubjectsTableTableManager(_db, _db.subjects);
  $$TeacherAssignmentsTableTableManager get teacherAssignments =>
      $$TeacherAssignmentsTableTableManager(_db, _db.teacherAssignments);
}

mixin _$StudentsDaoMixin on DatabaseAccessor<SchoolDatabase> {
  $ClassroomsTable get classrooms => attachedDatabase.classrooms;
  $StudentsTable get students => attachedDatabase.students;
  $EnrollmentsTable get enrollments => attachedDatabase.enrollments;
}
mixin _$FeesDaoMixin on DatabaseAccessor<SchoolDatabase> {
  $FeeHeadsTable get feeHeads => attachedDatabase.feeHeads;
  $ClassroomsTable get classrooms => attachedDatabase.classrooms;
  $FeeStructuresTable get feeStructures => attachedDatabase.feeStructures;
  $StudentsTable get students => attachedDatabase.students;
  $FeeInvoicesTable get feeInvoices => attachedDatabase.feeInvoices;
  $FeeInvoiceLinesTable get feeInvoiceLines => attachedDatabase.feeInvoiceLines;
  $RolesTable get roles => attachedDatabase.roles;
  $UsersTable get users => attachedDatabase.users;
  $FeePaymentsTable get feePayments => attachedDatabase.feePayments;
  $FeePaymentAllocationsTable get feePaymentAllocations =>
      attachedDatabase.feePaymentAllocations;
}
mixin _$StaffDaoMixin on DatabaseAccessor<SchoolDatabase> {
  $StaffTable get staff => attachedDatabase.staff;
  $StaffAttendanceTable get staffAttendance => attachedDatabase.staffAttendance;
  $SalaryAdvancesTable get salaryAdvances => attachedDatabase.salaryAdvances;
  $RolesTable get roles => attachedDatabase.roles;
  $UsersTable get users => attachedDatabase.users;
  $PayrollRunsTable get payrollRuns => attachedDatabase.payrollRuns;
  $PayrollLinesTable get payrollLines => attachedDatabase.payrollLines;
}
mixin _$ExamsDaoMixin on DatabaseAccessor<SchoolDatabase> {
  $ClassroomsTable get classrooms => attachedDatabase.classrooms;
  $ExamsTable get exams => attachedDatabase.exams;
  $ExamComponentsTable get examComponents => attachedDatabase.examComponents;
  $StudentsTable get students => attachedDatabase.students;
  $ExamMarksTable get examMarks => attachedDatabase.examMarks;
  $GradeScalesTable get gradeScales => attachedDatabase.gradeScales;
}
mixin _$ExpensesDaoMixin on DatabaseAccessor<SchoolDatabase> {
  $ExpenseCategoriesTable get expenseCategories =>
      attachedDatabase.expenseCategories;
  $RolesTable get roles => attachedDatabase.roles;
  $UsersTable get users => attachedDatabase.users;
  $ExpensesTable get expenses => attachedDatabase.expenses;
}
mixin _$SyncDaoMixin on DatabaseAccessor<SchoolDatabase> {
  $SyncQueueTable get syncQueue => attachedDatabase.syncQueue;
}
mixin _$SettingsDaoMixin on DatabaseAccessor<SchoolDatabase> {
  $ClassroomsTable get classrooms => attachedDatabase.classrooms;
  $SubjectsTable get subjects => attachedDatabase.subjects;
  $StaffTable get staff => attachedDatabase.staff;
  $TeacherAssignmentsTable get teacherAssignments =>
      attachedDatabase.teacherAssignments;
}
mixin _$DashboardDaoMixin on DatabaseAccessor<SchoolDatabase> {
  $ClassroomsTable get classrooms => attachedDatabase.classrooms;
  $StudentsTable get students => attachedDatabase.students;
  $StaffTable get staff => attachedDatabase.staff;
  $FeeInvoicesTable get feeInvoices => attachedDatabase.feeInvoices;
  $RolesTable get roles => attachedDatabase.roles;
  $UsersTable get users => attachedDatabase.users;
  $FeePaymentsTable get feePayments => attachedDatabase.feePayments;
  $ExpenseCategoriesTable get expenseCategories =>
      attachedDatabase.expenseCategories;
  $ExpensesTable get expenses => attachedDatabase.expenses;
  $StaffAttendanceTable get staffAttendance => attachedDatabase.staffAttendance;
}
