

class EMIHistory {

  int _id;
  String _amount;
  String _roi;
  String _time;

  EMIHistory(this._amount,this._time,this._roi);

  EMIHistory.withId(this._id,this._amount,this._time,this._roi);

  String get amount => _amount;

  String get roi => _roi;

  String get time => _time;

  int get id => _id;

  set amount (String newAmount) {
    this._amount = newAmount;
  }

  set roi (String newRoi) {
    this._roi = newRoi ;
  }

  set time (String newTime) {
    this._time = newTime;
  }


  Map<String , dynamic> toMap() {

    var map = Map<String, dynamic>();

    if(id != null) {
      map['id'] = _id;
    }
    map['amount'] = _amount;
    map['roi'] = _roi;
    map['time'] = _time;

    return map;
  }

  EMIHistory.fromMapObject(Map<String,dynamic> map) {
    this._id = map['id'];
    this._amount =  map['amount'];
    this._roi = map['roi'] ;
    this._time = map['time'];
  }

}

