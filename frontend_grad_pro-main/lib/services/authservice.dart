// ignore_for_file: unnecessary_new

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import 'package:Fluttertoast/Fluttertoast.dart';
class AuthService {
  Dio dio = new Dio();

  login(name, password) async {
    try {
      return await dio.post('http://10.0.2.2:3000/authenticate',
          data: {
            "name": name,
            "password": password,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  loginw(phonenumber, password) async {
    try {
      return await dio.post('http://10.0.2.2:3000/authenticatew',
          data: {
            "phonenumber": phonenumber,
            "password": password,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  addUser(name, password, phonenumber) async {
    return await dio.post('http://10.0.2.2:3000/adduser',
        data: {"name": name, "password": password, "phonenumber": phonenumber},
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  addWorker(name, password, phonenumber, List<String> category, region) async {
    return await dio.post('http://10.0.2.2:3000/addworker',
        data: {
          "name": name,
          "password": password,
          "phonenumber": phonenumber,
          "category": category,
          "region": region
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  addOrder(name, List<String> address, category, service, worker, time) async {
    return await dio.post('http://10.0.2.2:3000/addorder',
        data: {
          "name": name,
          "category": category,
          "service": service,
          "worker": worker,
          "time": time,
          "address": address
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  savelocation(latitude, longitude, name, region, address) async {
    try {
      return await dio.put('http://10.0.2.2:3000/savelocation',
          data: {
            "name": name,
            "latitude": latitude,
            "longitude": longitude,
            "region": region,
            "address": address,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getlocation(name) async {
    try {
      return await dio.get('http://10.0.2.2:3000/getlocation/$name');
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      //     msg: e.response!.data['msg'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
  }

  getcategory() async {
    try {
      return await dio.get('http://10.0.2.2:3000/getcategory');
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  cancelrequest(_id) async {
    try {
      return await dio.put('http://10.0.2.2:3000/cancelrequest/$_id',
          data: {
            "_id": _id,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getorder(name) async {
    try {
      return await dio.get('http://10.0.2.2:3000/getspacificorder/$name');
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      // msg: e.response!.data['msg'],
      // toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.BOTTOM,
      // backgroundColor: Colors.red,
      // textColor: Colors.white,
      // fontSize: 16.0);
    }
  }

  getworkernameandphonenumber(_id) async {
    try {
      return await dio
          .get('http://10.0.2.2:3000/getworkernameandphonenumber/$_id');
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      // msg: e.response!.data['msg'],
      // toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.BOTTOM,
      // backgroundColor: Colors.red,
      // textColor: Colors.white,
      // fontSize: 16.0);
    }
  }

  getworkername(phonenumber) async {
    try {
      return await dio.get('http://10.0.2.2:3000/getworkername/$phonenumber');
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      // msg: e.response!.data['msg'],
      // toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.BOTTOM,
      // backgroundColor: Colors.red,
      // textColor: Colors.white,
      // fontSize: 16.0);
    }
  }

  setratefororder(_id, rate) async {
    try {
      return await dio.put('http://10.0.2.2:3000/rateorder/$_id',
          data: {
            "rating": rate,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      //     msg: e.response!.data['msg'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
  }

  addtimeforworker(_id, time) async {
    try {
      return await dio.put('http://10.0.2.2:3000/addtimeforworker/$_id',
          data: {
            "time": time,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      //     msg: e.response!.data['msg'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
  }

  getworkerinfo(name) async {
    try {
      return await dio.get('http://10.0.2.2:3000/getworkerinfo/$name');
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      // msg: e.response!.data['msg'],
      // toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.BOTTOM,
      // backgroundColor: Colors.red,
      // textColor: Colors.white,
      // fontSize: 16.0);
    }
  }

  updateworkerinfo(name, category, password, region, phonenumber, about) async {
    try {
      return await dio.put('http://10.0.2.2:3000/updateworkerinfo/$phonenumber',
          data: {
            "name": name,
            "category": category,
            "password": password,
            "region": region,
            "about": about,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      //     msg: e.response!.data['msg'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
  }

  acceptrequest(_id) async {
    try {
      return await dio.put('http://10.0.2.2:3000/acceptrequest/$_id',
          data: {
            "_id": _id,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getclientnameandphonenumber(clientname) async {
    try {
      return await dio
          .get('http://10.0.2.2:3000/getclientnameandphonenumber/$clientname');
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      // msg: e.response!.data['msg'],
      // toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.BOTTOM,
      // backgroundColor: Colors.red,
      // textColor: Colors.white,
      // fontSize: 16.0);
    }
  }

  getassignedorder(_id) async {
    try {
      return await dio.get('http://10.0.2.2:3000/getassignedorder/$_id');
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      // msg: e.response!.data['msg'],
      // toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.BOTTOM,
      // backgroundColor: Colors.red,
      // textColor: Colors.white,
      // fontSize: 16.0);
    }
  }

  endrequest(_id, durationTime) async {
    try {
      return await dio.put('http://10.0.2.2:3000/endrequest/$_id',
          data: {
            "_id": _id,
            "durationTime": durationTime,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  removetimeforworker(_id, time) async {
    time = time
        .toString()
        .replaceAll("اليوم", 'Today')
        .replaceAll("غدا", "Tomorrow");
    try {
      return await dio.put(
          'http://10.0.2.2:3000/removetimeforworker/$_id/$time',
          data: {
            "time": time,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      //     msg: e.response!.data['msg'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
  }

  startrequest(_id) async {
    try {
      return await dio.put('http://10.0.2.2:3000/startrequest/$_id',
          data: {
            "_id": _id,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getlast10times(service) async {
    try {
      return await dio.get('http://10.0.2.2:3000/getlast10times/$service');
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      // msg: e.response!.data['msg'],
      // toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.BOTTOM,
      // backgroundColor: Colors.red,
      // textColor: Colors.white,
      // fontSize: 16.0);
    }
  }

  changeestimatedtime(service, estimatedTime) async {
    try {
      return await dio.put('http://10.0.2.2:3000/changeestimatedtime/$service',
          data: {
            "service": service,
            "estimatedTime": estimatedTime,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getworkerrate(worker) async {
    try {
      return await dio.get('http://10.0.2.2:3000/getworkerrate/$worker');
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      // msg: e.response!.data['msg'],
      // toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.BOTTOM,
      // backgroundColor: Colors.red,
      // textColor: Colors.white,
      // fontSize: 16.0);
    }
  }

  changeworkerrate(_id, rating) async {
    try {
      return await dio.put('http://10.0.2.2:3000/changeworkerrate/$_id',
          data: {
            "_id": _id,
            "rating": rating,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      //     msg: e.response!.data['msg'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
  }

  newpassforclient(name, oldpass, password) async {
    try {
      return await dio.put('http://10.0.2.2:3000/newpassforclient/$name',
          data: {
            "passworrd": password,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getorderfornot(name) async {
    try {
      return await dio.get('http://10.0.2.2:3000/getorder/$name',
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      //     msg: e.response!.data['msg'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
  }
}
