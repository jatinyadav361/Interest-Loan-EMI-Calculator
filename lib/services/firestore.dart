
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_interest_calculator/models/userData.dart';

class FireStoreService {

  final CollectionReference simpleInterestCollection  = Firestore.instance.collection('simpleInterestHistory');

  final CollectionReference monthlyInterestCollection = Firestore.instance.collection('monthlyInterest');

  final CollectionReference compoundInterestCollection = Firestore.instance.collection('compoundInteest');

  final CollectionReference emiCollection = Firestore.instance.collection('monthlyEMI');

  //stream of simple interest history list
  Stream<List<UserData>> get simpleInterestHistory {
    return simpleInterestCollection.snapshots().map( _getUserDataSimpleInterestHistoryFromQuerySnapshot);
  }


  //get user data list from query snapshot
  List<UserData> _getUserDataSimpleInterestHistoryFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return UserData(
        uid: doc.documentID,
        principal: doc.data['principal'],
        roiYearly: doc.data['roi'],
        time: doc.data['time'],
        simpleInterest: doc.data['interest']
      );
    }).toList();
  }

  //delete history
  Future deleteHistory (String uid) async {
    return await simpleInterestCollection.document(uid).delete();
  }

  Future deleteHistoryMonthly (String uid) async {
    return await monthlyInterestCollection.document(uid).delete();
  }

  Future deleteCompoundHistory (String uid) async {
    return await compoundInterestCollection.document(uid).delete();
  }

  Future deleteEMIHistory (String uid) async {
    return await emiCollection.document(uid).delete();
  }

  //update user data or save history
  Future updateUserDataSimpleInterest(String uid,String principal,String roi , String time,String interest) async {
    return await simpleInterestCollection.document(uid).setData({
      'principal': principal,
      'roi' : roi,
      'time' : time,
      'interest' : interest,
    });
  }


  //add monthly interest history
  Future updateMonthlyInterestHistory(String uid,String principal,String roi,String time,String totalMonthlyInterest) async {
    return await monthlyInterestCollection.document(uid).setData({
      'principal' : principal,
      'roiMonthly': roi,
      'time' : time,
      'monthlyInterestTotal': totalMonthlyInterest,
    });
  }

  //stream of monthly interest history list
  Stream<List<UserData>> get monthlyInterestHistory {
    return monthlyInterestCollection.snapshots().map(_monthlyInterestHistoryFromQuerySnapshot);
  }

  //get monthlyInterestHistory list from query snapshot
  List<UserData> _monthlyInterestHistoryFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return UserData(
        monthlyInterest:  doc.data['monthlyInterestTotal'],
        time: doc.data['time'],
        roiMonthly: doc.data['roiMonthly'],
        principal: doc.data['principal'],
      );
    }).toList();
  }



  //add compound interest history
  Future updateCompoundInterestHistory(String uid,String principal,String roi,String time,String interestCompounded,String compoundInterest) async {
    return await compoundInterestCollection.document(uid).setData({
      'principal':principal,
      'roiAnnually': roi,
      'time': time,
      'interestCompounded': interestCompounded,
      'compoundInterest' : compoundInterest,
    });
  }

  //list of user data of compound interest history
  Stream<List<UserData>> get compoundInterestHistory {
    return compoundInterestCollection.snapshots().map(_getCompoundInterestHistoryFromQuerySnapshot);
  }

  //get compoundInterestHistory from query snapshot
  List<UserData> _getCompoundInterestHistoryFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(
        principal: doc.data['principal'],
        roiYearly: doc.data['roiAnnually'],
        time: doc.data['time'],
        interestCompounded: doc.data['interestCompounded'],
        compoundInterest: doc.data['compoundInterest'],
      );
    }).toList();
  }



  //add emi history
  Future updateEMIHistory(String uid,String loanAmount, String roi, String time,String monthlyEMI) async {
    return await emiCollection.document(uid).setData({
      'loanAmount': loanAmount,
      'roiAnnually' : roi,
      'time' : time,
      'monthlyEMI' : monthlyEMI,
    });
  }

  //stream of user data of emi history or list of emi history
  Stream<List<UserData>>  get historyEMI {
    return emiCollection.snapshots().map(_getEMIHistoryFromQuerySnapshot);
  }

  //get user data emi history from query snapshot
  List<UserData> _getEMIHistoryFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(
        principal: doc.data['loanAmount'],
        roiYearly: doc.data['roiAnnually'],
        time: doc.data['time'],
        monthlyEMI: doc.data['monthlyEMI'],
      );
    }).toList();
  }


}