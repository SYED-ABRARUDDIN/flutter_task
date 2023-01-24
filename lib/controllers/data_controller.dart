import 'package:flutter/material.dart';
import 'package:newstask/models/data_model.dart';

class DataProvider with ChangeNotifier{
 List<DataListModel> dataList=[];
  setDataList(List<DataListModel> list) async {
     dataList=list;
    notifyListeners();
  }

  // addEmp(Employee emp) async{
  //   var box = await Hive.openBox<Employee>('employee');
  //   box.add(emp);
  //   notifyListeners();
  // }

//  getEmpList() async {
//     notifyListeners();
//   }

}