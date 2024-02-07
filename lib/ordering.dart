import 'package:flutter/material.dart';
import 'package:ordering/constant.dart';
import 'package:ordering/constantBox.dart';
import 'package:ordering/tabbar.dart';

class Ordering extends StatefulWidget {
  const Ordering({Key? key}) : super(key: key);

  @override
  State<Ordering> createState() => _OrderingState();
}

class _OrderingState extends State<Ordering> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5,
        automaticallyImplyLeading: false,
        backgroundColor: GlobalVariables.mainColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                              blurStyle: BlurStyle.normal,
                              color: Colors.grey.withOpacity(1),
                              blurRadius: 5,
                              offset: Offset.fromDirection(-4)),
                        ],
                      ),
                      child: Container(
                        height: 48,
                        width: 295,
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Where to? ',
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 15,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.tune),
                          iconSize: 20,
                          color: Colors.black,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Tabbar(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 16),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CustomBox(
                          title: 'Gurung Bakery ${index + 1}',
                          subtitle:
                              'Delight in Every Bite: Your Neighborhood Bakery',
                          location: 'Chipledhunga, Pokhara',
                          phone: '+977-9800000000',
                          rating: '4.9'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
