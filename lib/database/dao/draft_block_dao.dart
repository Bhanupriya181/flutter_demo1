import 'package:floor/floor.dart';
import '../entity/draftBlockEntity.dart';

@dao
abstract class DraftBlockDao {
  // Insert a new Draft block
  @insert
  Future<void> insertDraftBlock(Draftblockentity draftBlock);

  // Insert multiple Draft blocks
  @insert
  Future<void> insertMultipleDraftBlocks(List<Draftblockentity> draftBlocks);

  // Update an existing Draft block
  @update
  Future<void> updateDraftBlock(Draftblockentity draftBlock);

  // Delete a Draft block
  @delete
  Future<void> deleteDraftBlock(Draftblockentity draftBlock);

  // Get all Draft blocks
  @Query('SELECT * FROM draft')
  Future<List<Draftblockentity>> getAllDraftBlocks();

  // Get a specific Draft block by blockId
  @Query('SELECT * FROM draft WHERE id = :Id')
  Future<Draftblockentity?> getDraftBlockById(int Id);

  @Query('DELETE FROM draft WHERE id = :id')
  Future<void> deleteDraftsById(int id);

  @Query('DELETE FROM draft')
  Future<void> deleteAllDraft();
}
