import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ordering/constant.dart';

class CustomBox extends StatefulWidget {
  final String title;
  final String subtitle;
  final String location;
  final String phone;
  final Color? color;
  final String rating;

  const CustomBox({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.phone,
    this.color,
    required this.rating,
  }) : super(key: key);

  @override
  _CustomBoxState createState() => _CustomBoxState();
}

class _CustomBoxState extends State<CustomBox> {
  int currentIndex = 0;
  final List<String> images = [
    'assets/bakery.png',
    'assets/bakery.png',
    'assets/bakery.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 447,
      decoration: BoxDecoration(
        color: widget.color ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 188,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index % images.length;
                      });
                    },
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image.asset(
                          images[index % images.length],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (index) => buildIndicator(index == currentIndex),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title, // Changed
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFA200),
                          size: 18,
                        ),
                        Text(
                          widget.rating, // Changed
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  widget.subtitle, // Changed
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5F6980),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFF03528A),
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.location, // Changed
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF5F6980),
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.gps_fixed,
                      color: Color(0xFF03528A),
                      size: 18,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: Color(0xFF03528A),
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.phone, // Changed
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF5F6980),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      width: 170,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF2F4F7),
                            ),
                            width: 36,
                            height: 36,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.facebook,
                                color: Color(
                                  0xFF5F6980,
                                ),
                                size: 22,
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF2F4F7),
                            ),
                            width: 36,
                            height: 36,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Ionicons.logo_instagram,
                                color: Color(
                                  0xFF5F6980,
                                ),
                                size: 18,
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF2F4F7),
                            ),
                            width: 36,
                            height: 36,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Ionicons.logo_twitter,
                                color: Color(
                                  0xFF5F6980,
                                ),
                                size: 18,
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF2F4F7),
                            ),
                            width: 36,
                            height: 36,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Ionicons.logo_tiktok,
                                color: Color(
                                  0xFF5F6980,
                                ),
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                SizedBox(
                  height: 35,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Visit Shop',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: GlobalVariables.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Container(
      height: isSelected ? 12 : 8,
      width: isSelected ? 12 : 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.white : Colors.grey,
      ),
    );
  }
}
