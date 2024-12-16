// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $MyDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $MyDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $MyDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<MyDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorMyDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $MyDatabaseBuilderContract databaseBuilder(String name) =>
      _$MyDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $MyDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$MyDatabaseBuilder(null);
}

class _$MyDatabaseBuilder implements $MyDatabaseBuilderContract {
  _$MyDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $MyDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $MyDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<MyDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$MyDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MyDatabase extends MyDatabase {
  _$MyDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BlockDao? _blockDaoInstance;

  DraftBlockDao? _draftDaoInstance;

  CompletedBlockDao? _completedDaoInstance;

  VillageDao? _villageDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `blocks` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `blockName` TEXT NOT NULL, `blockId` TEXT NOT NULL, `villageList` TEXT NOT NULL, `type` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `draft` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `blockName` TEXT NOT NULL, `blockId` TEXT NOT NULL, `villageList` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `completed` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `blockName` TEXT NOT NULL, `blockId` TEXT NOT NULL, `villageList` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `village` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `villageName` TEXT NOT NULL, `image` TEXT NOT NULL, `date` TEXT NOT NULL, `remark` TEXT NOT NULL, `blockId` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BlockDao get blockDao {
    return _blockDaoInstance ??= _$BlockDao(database, changeListener);
  }

  @override
  DraftBlockDao get draftDao {
    return _draftDaoInstance ??= _$DraftBlockDao(database, changeListener);
  }

  @override
  CompletedBlockDao get completedDao {
    return _completedDaoInstance ??=
        _$CompletedBlockDao(database, changeListener);
  }

  @override
  VillageDao get villageDao {
    return _villageDaoInstance ??= _$VillageDao(database, changeListener);
  }
}

class _$BlockDao extends BlockDao {
  _$BlockDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _blockEntityInsertionAdapter = InsertionAdapter(
            database,
            'blocks',
            (BlockEntity item) => <String, Object?>{
                  'id': item.id,
                  'blockName': item.blockName,
                  'blockId': item.blockId,
                  'villageList': item.villageList,
                  'type': item.type
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BlockEntity> _blockEntityInsertionAdapter;

  @override
  Future<List<BlockEntity>> getAllBlocks() async {
    return _queryAdapter.queryList('SELECT * FROM blocks',
        mapper: (Map<String, Object?> row) => BlockEntity(
            id: row['id'] as int?,
            blockName: row['blockName'] as String,
            blockId: row['blockId'] as String,
            villageList: row['villageList'] as String,
            type: row['type'] as String));
  }

  @override
  Future<BlockEntity?> getBlockById(String blockId) async {
    return _queryAdapter.query('SELECT * FROM blocks WHERE blockId = ?1',
        mapper: (Map<String, Object?> row) => BlockEntity(
            id: row['id'] as int?,
            blockName: row['blockName'] as String,
            blockId: row['blockId'] as String,
            villageList: row['villageList'] as String,
            type: row['type'] as String),
        arguments: [blockId]);
  }

  @override
  Future<List<BlockEntity>> getBlockByType(String type) async {
    return _queryAdapter.queryList('SELECT * FROM blocks WHERE type = ?1',
        mapper: (Map<String, Object?> row) => BlockEntity(
            id: row['id'] as int?,
            blockName: row['blockName'] as String,
            blockId: row['blockId'] as String,
            villageList: row['villageList'] as String,
            type: row['type'] as String),
        arguments: [type]);
  }

  @override
  Future<void> deleteAllBlocks() async {
    await _queryAdapter.queryNoReturn('DELETE FROM blocks');
  }

  @override
  Future<void> deleteBlocksById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM blocks WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteBlocksByType(String type) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM blocks WHERE type = ?1', arguments: [type]);
  }

  @override
  Future<void> insertBlock(BlockEntity block) async {
    await _blockEntityInsertionAdapter.insert(
        block, OnConflictStrategy.replace);
  }
}

class _$DraftBlockDao extends DraftBlockDao {
  _$DraftBlockDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _draftblockentityInsertionAdapter = InsertionAdapter(
            database,
            'draft',
            (Draftblockentity item) => <String, Object?>{
                  'id': item.id,
                  'blockName': item.blockName,
                  'blockId': item.blockId,
                  'villageList': item.villageList
                }),
        _draftblockentityUpdateAdapter = UpdateAdapter(
            database,
            'draft',
            ['id'],
            (Draftblockentity item) => <String, Object?>{
                  'id': item.id,
                  'blockName': item.blockName,
                  'blockId': item.blockId,
                  'villageList': item.villageList
                }),
        _draftblockentityDeletionAdapter = DeletionAdapter(
            database,
            'draft',
            ['id'],
            (Draftblockentity item) => <String, Object?>{
                  'id': item.id,
                  'blockName': item.blockName,
                  'blockId': item.blockId,
                  'villageList': item.villageList
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Draftblockentity> _draftblockentityInsertionAdapter;

  final UpdateAdapter<Draftblockentity> _draftblockentityUpdateAdapter;

  final DeletionAdapter<Draftblockentity> _draftblockentityDeletionAdapter;

  @override
  Future<List<Draftblockentity>> getAllDraftBlocks() async {
    return _queryAdapter.queryList('SELECT * FROM draft',
        mapper: (Map<String, Object?> row) => Draftblockentity(
            id: row['id'] as int?,
            blockName: row['blockName'] as String,
            blockId: row['blockId'] as String,
            villageList: row['villageList'] as String));
  }

  @override
  Future<Draftblockentity?> getDraftBlockById(int Id) async {
    return _queryAdapter.query('SELECT * FROM draft WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Draftblockentity(
            id: row['id'] as int?,
            blockName: row['blockName'] as String,
            blockId: row['blockId'] as String,
            villageList: row['villageList'] as String),
        arguments: [Id]);
  }

  @override
  Future<void> deleteDraftsById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM draft WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAllDraft() async {
    await _queryAdapter.queryNoReturn('DELETE FROM draft');
  }

  @override
  Future<void> insertDraftBlock(Draftblockentity draftBlock) async {
    await _draftblockentityInsertionAdapter.insert(
        draftBlock, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertMultipleDraftBlocks(
      List<Draftblockentity> draftBlocks) async {
    await _draftblockentityInsertionAdapter.insertList(
        draftBlocks, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateDraftBlock(Draftblockentity draftBlock) async {
    await _draftblockentityUpdateAdapter.update(
        draftBlock, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteDraftBlock(Draftblockentity draftBlock) async {
    await _draftblockentityDeletionAdapter.delete(draftBlock);
  }
}

class _$CompletedBlockDao extends CompletedBlockDao {
  _$CompletedBlockDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _completedblockentityInsertionAdapter = InsertionAdapter(
            database,
            'completed',
            (Completedblockentity item) => <String, Object?>{
                  'id': item.id,
                  'blockName': item.blockName,
                  'blockId': item.blockId,
                  'villageList': item.villageList
                }),
        _completedblockentityUpdateAdapter = UpdateAdapter(
            database,
            'completed',
            ['id'],
            (Completedblockentity item) => <String, Object?>{
                  'id': item.id,
                  'blockName': item.blockName,
                  'blockId': item.blockId,
                  'villageList': item.villageList
                }),
        _completedblockentityDeletionAdapter = DeletionAdapter(
            database,
            'completed',
            ['id'],
            (Completedblockentity item) => <String, Object?>{
                  'id': item.id,
                  'blockName': item.blockName,
                  'blockId': item.blockId,
                  'villageList': item.villageList
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Completedblockentity>
      _completedblockentityInsertionAdapter;

  final UpdateAdapter<Completedblockentity> _completedblockentityUpdateAdapter;

  final DeletionAdapter<Completedblockentity>
      _completedblockentityDeletionAdapter;

  @override
  Future<List<Completedblockentity>> getAllCompletedBlocks() async {
    return _queryAdapter.queryList('SELECT * FROM completed',
        mapper: (Map<String, Object?> row) => Completedblockentity(
            id: row['id'] as int?,
            blockName: row['blockName'] as String,
            blockId: row['blockId'] as String,
            villageList: row['villageList'] as String));
  }

  @override
  Future<Completedblockentity?> getCompletedBlockById(int Id) async {
    return _queryAdapter.query('SELECT * FROM completed WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Completedblockentity(
            id: row['id'] as int?,
            blockName: row['blockName'] as String,
            blockId: row['blockId'] as String,
            villageList: row['villageList'] as String),
        arguments: [Id]);
  }

  @override
  Future<void> deleteCompletedsById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM completed WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAllCompleteData() async {
    await _queryAdapter.queryNoReturn('DELETE FROM completed');
  }

  @override
  Future<void> insertCompletedBlock(Completedblockentity completedBlock) async {
    await _completedblockentityInsertionAdapter.insert(
        completedBlock, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertMultipleCompletedBlocks(
      List<Completedblockentity> completedBlocks) async {
    await _completedblockentityInsertionAdapter.insertList(
        completedBlocks, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCompletedBlock(Completedblockentity completedBlock) async {
    await _completedblockentityUpdateAdapter.update(
        completedBlock, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCompletedBlock(Completedblockentity completedBlock) async {
    await _completedblockentityDeletionAdapter.delete(completedBlock);
  }
}

class _$VillageDao extends VillageDao {
  _$VillageDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _villageEntityInsertionAdapter = InsertionAdapter(
            database,
            'village',
            (VillageEntity item) => <String, Object?>{
                  'id': item.id,
                  'villageName': item.villageName,
                  'image': item.image,
                  'date': item.date,
                  'remark': item.remark,
                  'blockId': item.blockId
                }),
        _villageEntityUpdateAdapter = UpdateAdapter(
            database,
            'village',
            ['id'],
            (VillageEntity item) => <String, Object?>{
                  'id': item.id,
                  'villageName': item.villageName,
                  'image': item.image,
                  'date': item.date,
                  'remark': item.remark,
                  'blockId': item.blockId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<VillageEntity> _villageEntityInsertionAdapter;

  final UpdateAdapter<VillageEntity> _villageEntityUpdateAdapter;

  @override
  Future<List<VillageEntity>> getAllVillages() async {
    return _queryAdapter.queryList('SELECT * FROM village',
        mapper: (Map<String, Object?> row) => VillageEntity(
            id: row['id'] as int?,
            villageName: row['villageName'] as String,
            image: row['image'] as String,
            date: row['date'] as String,
            remark: row['remark'] as String,
            blockId: row['blockId'] as String));
  }

  @override
  Future<List<VillageEntity>> getVillageById(String blockId) async {
    return _queryAdapter.queryList('SELECT * FROM village WHERE blockId = ?1',
        mapper: (Map<String, Object?> row) => VillageEntity(
            id: row['id'] as int?,
            villageName: row['villageName'] as String,
            image: row['image'] as String,
            date: row['date'] as String,
            remark: row['remark'] as String,
            blockId: row['blockId'] as String),
        arguments: [blockId]);
  }

  @override
  Future<void> deleteAllVillages() async {
    await _queryAdapter.queryNoReturn('DELETE FROM village');
  }

  @override
  Future<void> deleteVillagesById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM village WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<VillageEntity?> getVillagesByVillageId(int id) async {
    return _queryAdapter.query('SELECT * FROM village WHERE id = ?1',
        mapper: (Map<String, Object?> row) => VillageEntity(
            id: row['id'] as int?,
            villageName: row['villageName'] as String,
            image: row['image'] as String,
            date: row['date'] as String,
            remark: row['remark'] as String,
            blockId: row['blockId'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertVillage(VillageEntity block) async {
    await _villageEntityInsertionAdapter.insert(
        block, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateVillage(VillageEntity village) async {
    await _villageEntityUpdateAdapter.update(
        village, OnConflictStrategy.replace);
  }
}
