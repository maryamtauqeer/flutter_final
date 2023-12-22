import 'package:flutter/material.dart';

class UIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommended for',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'your devices',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 50),
              TextButton(
                child: Text(
                  "See All",
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 400.0,
            width: 400.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://cgaxisimages.fra1.cdn.digitaloceanspaces.com/2021/11/airpods_max_silver_a.webp',
                ),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.rectangle,
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.bookmark_border_outlined, color: Colors.blue),
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'Free Engraving',
              style: TextStyle(
                fontSize: 15,
                color: Colors.yellow,
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'AirPods Max - Silver',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'A\$899.00',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildColoredCircle(
                  const Color.fromARGB(255, 29, 29, 29), Colors.grey),
              _buildColoredCircle(Colors.red, Colors.white),
              _buildColoredCircle(Colors.grey, Colors.black),
              _buildColoredCircle(
                  Colors.white, const Color.fromARGB(255, 84, 82, 81)),
              SizedBox(width: 20),
              Text(
                '+1 more',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColoredCircle(Color upperColor, Color lowerColor) {
    return Container(
      width: 16,
      height: 16,
      margin: const EdgeInsets.only(left: 8),
      child: ClipOval(
        child: Stack(
          children: [
            Container(
              width: 16,
              height: 8,
              color: upperColor,
            ),
            Container(
              width: 16,
              height: 8,
              color: lowerColor,
              margin: EdgeInsets.only(top: 8),
            ),
          ],
        ),
      ),
    );
  }
}
