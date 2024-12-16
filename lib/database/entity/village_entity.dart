import 'package:floor/floor.dart';

@Entity(tableName: 'village')
class VillageEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

   String villageName ;
   String image ;
   String date ;
   String remark ;
   String blockId ;

  VillageEntity({
    this.id,
      required this.villageName,
    required this.image,
    required this.date,
    required this.remark,
    required this.blockId,
});
}