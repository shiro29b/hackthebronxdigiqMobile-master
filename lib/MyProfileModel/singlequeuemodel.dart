class SingleQueue {
  late String sAttachments;
  late String sEtag;
  late String sRid;
  late String sSelf;
  late int iTs;
  late String admin;
  late String city;
  late int count;
  late String id;
  late bool isActive;
  late String name;
  late String tag;
  late int timePerUserM;
  late int totalTime;
  late List<String> users;

  SingleQueue(
      {
        required this.sAttachments,
        required this.sEtag,
        required this.sRid,
        required this.sSelf,
        required this.iTs,
        required this.admin,
        required this.city,
        required this.count,
        required this.id,
        required this.isActive,
        required this.name,
        required this.tag,
        required this.timePerUserM,
        required this.totalTime,
        required this.users});

  SingleQueue.fromJson(Map<String, dynamic> json) {
    sAttachments = json['_attachments'];
    sEtag = json['_etag'];
    sRid = json['_rid'];
    sSelf = json['_self'];
    iTs = json['_ts'];
    admin = json['admin'];
    city = json['city'];
    count = json['count'];
    id = json['id'];
    isActive = json['is_active'];
    name = json['name'];
    tag = json['tag'];
    timePerUserM = json['time_per_user_m'];
    totalTime = json['total_time'];
    users = json['users'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_attachments'] = this.sAttachments;
    data['_etag'] = this.sEtag;
    data['_rid'] = this.sRid;
    data['_self'] = this.sSelf;
    data['_ts'] = this.iTs;
    data['admin'] = this.admin;
    data['city'] = this.city;
    data['count'] = this.count;
    data['id'] = this.id;
    data['is_active'] = this.isActive;
    data['name'] = this.name;
    data['tag'] = this.tag;
    data['time_per_user_m'] = this.timePerUserM;
    data['total_time'] = this.totalTime;
    data['users'] = this.users;
    return data;
  }
}
