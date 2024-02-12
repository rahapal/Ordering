import 'dart:convert';

import 'package:flutter/material.dart';

UserDetail userDetailFromJson(String str) =>
    UserDetail.fromJson(jsonDecode(str));

class UserDetail {
  int? totalSales;

  int? totalRevenue;
  int? profit;
  List<Bill>? allBills;

  UserDetail({this.totalSales, this.totalRevenue, this.profit, this.allBills});

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      totalSales: json['data']['dailySalesReport']['totalSales'],
      totalRevenue: json['data']['dailySalesReport']['totalRevenue'],
      profit: json['data']['dailySalesReport']['profit'],
      allBills: List<Bill>.from(json['data']['dailySalesReport']['allBills']
          .map((x) => Bill.fromJson(x))),
    );
  }
}

class Bill {
  String? id;
  String? orderId;
  String? businessName;
  int? totalAmount;
  String? paidAt;

  int? grandTotal;

  Bill(
      {this.id,
      this.orderId,
      this.businessName,
      this.totalAmount,
      this.paidAt,
      this.grandTotal});

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json['_id'],
      orderId: json['orderId'],
      businessName: json['businessName'],
      totalAmount: json['totalAmount'],
      grandTotal: json['grandTotal'],
      paidAt: json['paidAt'],
    );
  }
}
