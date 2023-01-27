import 'package:flutter/material.dart';
import 'package:flutter_app/screens/client/workers.dart';

class workerProfilePage extends StatelessWidget {
  var name, phonenumber, about, region, rate;
  var address, category, service, estimatedtime, clientname;
  // ignore: use_key_in_widget_constructors

  workerProfilePage(
      this.name,
      this.phonenumber,
      this.about,
      this.region,
      this.rate,
      this.address,
      this.category,
      this.service,
      this.estimatedtime,
      this.clientname);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xffE63220),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => workersPage(clientname, address,
                        category, service, estimatedtime)));
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [],
                ),
              )
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/E.jpg'),
                  ),
                ),
              ),
              Container(
                height: 50,
                //color: Colors.red,
                alignment: Alignment.bottomLeft,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    name,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Color.fromARGB(255, 250, 243, 149),
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.phone),
                          color: const Color.fromARGB(255, 0, 0, 0),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Color.fromARGB(255, 250, 243, 149),
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.email),
                          color: const Color.fromARGB(255, 0, 0, 0),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Ink(
                        child: IconButton(
                          icon: const Icon(Icons.location_pin),
                          color: const Color.fromARGB(255, 0, 0, 0),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Center(
                      child: Ink(
                        child: Text(
                          region,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                  ]),
              Container(
                height: 130,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),

                //color: Colors.red,
                alignment: Alignment.bottomLeft,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    about,
                    //maxLines: 3,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < rate; i++)
                      Center(
                        child: Ink(
                          child: IconButton(
                            icon: const Icon(Icons.star),
                            color: Colors.orange,
                            onPressed: () {},
                          ),
                        ),
                      ),
                  ]),
            ],
          ),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xffE63220);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
