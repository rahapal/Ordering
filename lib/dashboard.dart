import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ordering/constant.dart';
import 'package:ordering/model/datamodel.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<UserDetail> _dataFuture;
  List<String> items = <String>['This Month', 'Last Month', 'This Year'];
  String dropdownValue = 'This Month';
  List<String> productsName = [
    'Pizza',
    'Burger',
    'Pasta',
    'Sandwich',
    'Noodles'
  ];
  List<int> productsCount = [525, 325, 425, 225, 125];

  @override
  void initState() {
    _dataFuture = readLocalJson();
    super.initState();
  }

  Future<UserDetail> readLocalJson() async {
    final jsonString = await rootBundle.loadString('assets/report.json');
    final userDetail = userDetailFromJson(jsonString);
    return userDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf2f3f7),
      appBar: AppBar(
        toolbarHeight: 5,
        automaticallyImplyLeading: false,
        backgroundColor: GlobalVariables.mainColor,
        elevation: 0,
      ),
      body: FutureBuilder<UserDetail>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Bill> bills = snapshot.data!.allBills!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 333,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    'Overview',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: DropdownButton<String>(
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                    value: dropdownValue,
                                    items: items.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.withOpacity(0.07),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SfCartesianChart(
                                  primaryXAxis: DateTimeAxis(
                                    dateFormat: DateFormat('yyyy-MM-dd'),
                                  ),
                                  primaryYAxis: const NumericAxis(
                                    interval:
                                        25000, // Adjust the interval as needed
                                  ),
                                  series: <CartesianSeries>[
                                    LineSeries<Bill, DateTime>(
                                      dataSource: bills,
                                      xValueMapper: (Bill bill, _) =>
                                          DateTime.parse(bill.paidAt!),
                                      yValueMapper: (Bill bill, _) =>
                                          bill.grandTotal!,
                                      dataLabelSettings:
                                          const DataLabelSettings(
                                        isVisible: true,
                                        labelAlignment:
                                            ChartDataLabelAlignment.top,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 170,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text('Analytics',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 100,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.07),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Sales',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data!.totalSales}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        '+2.3%',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 110,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.07),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Revenue',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data!.totalRevenue}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        '+1.3%',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 110,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.07),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Profit',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data!.profit}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        '+3.5%',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: Container(
                        height: 400,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 3),
                                child: Text(
                                  'Top Products',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Container(
                                    height: 325,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.withOpacity(0.07),
                                    ),
                                    child: ListView.builder(
                                      itemCount: productsName.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: GlobalVariables
                                                              .mainColor
                                                              .withOpacity(0.2),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            '${index + 1}',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        productsName[index],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '${productsCount[index]}',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
