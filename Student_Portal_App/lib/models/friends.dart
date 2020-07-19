

class Friend  {
  String uid;

  Friend({
    this.uid,
  });

  Map toMap(Friend friend) {
    var data = Map<String, dynamic>();
    data['friend_id'] = friend.uid;
    return data;
  }

  Friend.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['friend_id'];
  }
}