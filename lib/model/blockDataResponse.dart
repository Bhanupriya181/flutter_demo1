import 'dart:convert';
/// blockList : [{"name":"Block1","id":"1232","villageList":[{"vName":"RatanPur","image":"","date":"","remarks":""},{"vName":"kashPur","image":"","date":"","remarks":""}]},{"name":"Block2","id":"32434","villageList":[{"vName":"chpur","image":"","date":"","remarks":""}]},{"name":"Block3","id":"8665","villageList":[{"vName":"vsnagar","image":"","date":"","remarks":""},{"vName":"patai","image":"","date":"","remarks":""},{"vName":"damana","image":"","date":"","remarks":""}]}]

BlockDataResponse blockDataResponseFromJson(String str) => BlockDataResponse.fromJson(json.decode(str));
String blockDataResponseToJson(BlockDataResponse data) => json.encode(data.toJson());
class BlockDataResponse {
  BlockDataResponse({
      List<BlockList>? blockList,}){
    _blockList = blockList;
}

  BlockDataResponse.fromJson(dynamic json) {
    if (json['blockList'] != null) {
      _blockList = [];
      json['blockList'].forEach((v) {
        _blockList?.add(BlockList.fromJson(v));
      });
    }
  }
  List<BlockList>? _blockList;
BlockDataResponse copyWith({  List<BlockList>? blockList,
}) => BlockDataResponse(  blockList: blockList ?? _blockList,
);
  List<BlockList>? get blockList => _blockList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_blockList != null) {
      map['blockList'] = _blockList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Block1"
/// id : "1232"
/// villageList : [{"vName":"RatanPur","image":"","date":"","remarks":""},{"vName":"kashPur","image":"","date":"","remarks":""}]

BlockList blockListFromJson(String str) => BlockList.fromJson(json.decode(str));
String blockListToJson(BlockList data) => json.encode(data.toJson());
class BlockList {
  BlockList({
      String? name, 
      String? id, 
      List<VillageList>? villageList,}){
    _name = name;
    _id = id;
    _villageList = villageList;
}

  BlockList.fromJson(dynamic json) {
    _name = json['name'];
    _id = json['id'];
    if (json['villageList'] != null) {
      _villageList = [];
      json['villageList'].forEach((v) {
        _villageList?.add(VillageList.fromJson(v));
      });
    }
  }
  String? _name;
  String? _id;
  List<VillageList>? _villageList;
BlockList copyWith({  String? name,
  String? id,
  List<VillageList>? villageList,
}) => BlockList(  name: name ?? _name,
  id: id ?? _id,
  villageList: villageList ?? _villageList,
);
  String? get name => _name;
  String? get id => _id;
  List<VillageList>? get villageList => _villageList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    if (_villageList != null) {
      map['villageList'] = _villageList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// vName : "RatanPur"
/// image : ""
/// date : ""
/// remarks : ""

VillageList villageListFromJson(String str) => VillageList.fromJson(json.decode(str));
String villageListToJson(VillageList data) => json.encode(data.toJson());
class VillageList {
  VillageList({
      String? vName, 
      String? image, 
      String? date, 
      String? remarks,}){
    _vName = vName;
    _image = image;
    _date = date;
    _remarks = remarks;
}

  VillageList.fromJson(dynamic json) {
    _vName = json['vName'];
    _image = json['image'];
    _date = json['date'];
    _remarks = json['remarks'];
  }
  String? _vName;
  String? _image;
  String? _date;
  String? _remarks;
VillageList copyWith({  String? vName,
  String? image,
  String? date,
  String? remarks,
}) => VillageList(  vName: vName ?? _vName,
  image: image ?? _image,
  date: date ?? _date,
  remarks: remarks ?? _remarks,
);
  String? get vName => _vName;
  String? get image => _image;
  String? get date => _date;
  String? get remarks => _remarks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vName'] = _vName;
    map['image'] = _image;
    map['date'] = _date;
    map['remarks'] = _remarks;
    return map;
  }

}