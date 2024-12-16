import 'package:floor/floor.dart';
import '../entity/completedBlockEntity.dart';

@dao
abstract class CompletedBlockDao {
  // Insert a new Completed block
  @insert
  Future<void> insertCompletedBlock(Completedblockentity completedBlock);

  // Insert multiple Completed blocks
  @insert
  Future<void> insertMultipleCompletedBlocks(List<Completedblockentity> completedBlocks);

  // Update an existing Completed block
  @update
  Future<void> updateCompletedBlock(Completedblockentity completedBlock);

  // Delete a Completed block
  @delete
  Future<void> deleteCompletedBlock(Completedblockentity completedBlock);

  // Get all Completed blocks
  @Query('SELECT * FROM completed')
  Future<List<Completedblockentity>> getAllCompletedBlocks();

  // Get a specific Completed block by blockId
  @Query('SELECT * FROM completed WHERE id = :Id')
  Future<Completedblockentity?> getCompletedBlockById(int Id);

  @Query('DELETE FROM completed WHERE id = :id')
  Future<void> deleteCompletedsById(int id);

  @Query('DELETE FROM completed')
  Future<void> deleteAllCompleteData();
}
