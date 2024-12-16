import 'package:floor/floor.dart';

import '../entity/block_entity.dart';

@dao
abstract class BlockDao {
  @Query('SELECT * FROM blocks')
  Future<List<BlockEntity>> getAllBlocks();

  @Query('SELECT * FROM blocks WHERE blockId = :blockId')
  Future<BlockEntity?> getBlockById(String blockId);

  @Query('SELECT * FROM blocks WHERE type = :type')
  Future<List<BlockEntity>> getBlockByType(String type);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBlock(BlockEntity block);

  @Query('DELETE FROM blocks')
  Future<void> deleteAllBlocks();

  @Query('DELETE FROM blocks WHERE id = :id')
  Future<void> deleteBlocksById(int id);

  @Query('DELETE FROM blocks WHERE type = :type')
  Future<void> deleteBlocksByType(String type);

}
