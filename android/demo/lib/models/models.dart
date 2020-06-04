

class History {

    int _id;
    String _amount;
    String _roi;
    String _time;

    History(this._amount,this._roi, this._time);

    History.withId(this._id,this._amount, this._roi, this._time);

    int get id => _id;

    String get amount => _amount;

    String get roi => _roi;

    String get time => _time;

    set amount (String newAmount) {
      this._amount = newAmount;
    }

    set roi (String newRoi) {
      this._roi = newRoi;
    }

    set time (String newTime) {
      this._time = newTime;
    }

    Map<String , dynamic> toMap() {

      var map = Map<String , dynamic>();
      if(id!= null) {
         map['id'] = _id;
      }
      map['amount']= _amount ;
      map['roi']= _roi;
      map['time']= _time;

      return map;
    }

    History.fromMapObject(Map<String, dynamic> map) {
        this._amount = map['amount'];
        this._roi= map['roi'];
        this._id = map['id'];
        this._time = map['time'];

    }
 }


 abstract class Shape {
    int x;
    int y;
    void draw();
    Shape(){
      print("Shape class constructor");
    }
 }

 class Rectangle extends Shape {
    void draw() {
      print("Drawing rectangle!");
    }
    Rectangle(){
      print("Rectangle class constructor!");
    }
 }