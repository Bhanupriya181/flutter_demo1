
import 'package:floor/floor.dart';

// BlockEntity represents the block data, including the villageList encoded as JSON
@Entity(tableName: 'draft')
class Draftblockentity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String blockName;
  final String blockId;
  final String villageList;

  Draftblockentity({
    this.id,
    required this.blockName,
    required this.blockId,
    required this.villageList,
  });

}
