import 'package:assesment_flutter/database/entity/village_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class VillageDao {
  @Query('SELECT * FROM village')
  Future<List<VillageEntity>> getAllVillages();

  @Query('SELECT * FROM village WHERE blockId = :blockId')
  Future<List<VillageEntity>> getVillageById(String blockId);


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertVillage(VillageEntity block);

  @Query('DELETE FROM village')
  Future<void> deleteAllVillages();

  @Query('DELETE FROM village WHERE id = :id')
  Future<void> deleteVillagesById(int id);


  @Query('SELECT * FROM village WHERE id = :id')
  Future<VillageEntity?> getVillagesByVillageId(int id);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateVillage(VillageEntity village);

}