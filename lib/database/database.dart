import 'package:assesment_flutter/database/dao/block_dao.dart';
import 'package:assesment_flutter/database/dao/completed_block_dao.dart';
import 'package:assesment_flutter/database/dao/draft_block_dao.dart';
import 'package:assesment_flutter/database/dao/village_dao.dart';
import 'package:assesment_flutter/database/entity/block_entity.dart';
import 'package:assesment_flutter/database/entity/completedBlockEntity.dart';
import 'package:assesment_flutter/database/entity/draftBlockEntity.dart';
import 'package:assesment_flutter/database/entity/village_entity.dart';
import 'package:floor/floor.dart';
import 'dart:async';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [BlockEntity,Draftblockentity,Completedblockentity,VillageEntity])
abstract class MyDatabase extends FloorDatabase {
  BlockDao get blockDao ;
  DraftBlockDao get draftDao ;
  CompletedBlockDao get completedDao ;
  VillageDao get villageDao ;
}