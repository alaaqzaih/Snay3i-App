import 'package:flutter/material.dart';
import 'package:flutter_app/screens/client/homeuser.dart';
import 'package:flutter_app/services/authservice.dart';

class Rating extends StatefulWidget {
  final int maximumRating;
  final Function(int) onRatingSelected;
  var id, workerid, name;
  Rating(this.id, this.workerid, this.name, this.onRatingSelected,
      [this.maximumRating = 5]);

  @override
  _Rating createState() => _Rating(id, workerid, name);
}

class _Rating extends State<Rating> {
  int _currentRating = 0;
  var id, workerid, name;
  _Rating(this.id, this.workerid, this.name);
  Widget _buildRatingStar(int index) {
    if (index < _currentRating) {
      return Icon(
        Icons.star,
        color: Colors.orange,
        size: 40.0,
      );
    } else {
      return Icon(
        Icons.star_border_outlined,
        size: 40.0,
      );
    }
  }

  Widget _buildBody() {
    final stars = List<Widget>.generate(this.widget.maximumRating, (index) {
      return GestureDetector(
        child: _buildRatingStar(index),
        onTap: () {
          setState(() {
            _currentRating = index + 1;
          });

          this.widget.onRatingSelected(_currentRating);
        },
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          child: const Text("قيم",
              style: TextStyle(color: Colors.blue, fontSize: 18)),
          onPressed: () {
            int sum = 0;
            var average = 0.0;
            var count = 0.0;
            print(id);
            AuthService().setratefororder(id, _currentRating);
            AuthService().getworkerrate(workerid).then((val) {
              print(val.data['msg']);
              for (int i = 0; i < val.data!['msg'].length; i++) {
                // ignore: unnecessary_null_comparison
                if (val.data!['msg'][i]['rating'].toString() == "null") {
                  continue;
                }
                //print(val.data['msg'][i]['rating']);
                //print(val.data['msg'][i]['worker']);
                sum += int.parse(val.data!['msg'][i]['rating'].toString());
                count++;
              }
              print(sum);
              print(count);
              average = (sum / count) % 5;
              AuthService().changeworkerrate(workerid, average.round());
              print(average.round());
            });

            setState(() {
              _currentRating = 0;
            });
            this.widget.onRatingSelected(_currentRating);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => SelectService(
                  name: name,
                ),
              ),
            );
          },
        ),
        Row(
          children: stars,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
