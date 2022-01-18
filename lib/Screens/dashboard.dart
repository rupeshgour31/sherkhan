import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_project/Config/common_widgets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.orange,
        title: Text('DashBoard'),
        // leading: Padding(
        //   padding: EdgeInsets.only(left: 5, bottom: 3),
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(5),
        //     child: Image.asset('assets/images/appimg1.jpeg'),
        //   ),
        // ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 25, right: 25, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Top Category',
                style: TextStyle(
                  color: CustomColors.black,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 15),
              sliderList(),
              SizedBox(height: 20),
              Text(
                'Explore ',
                style: TextStyle(
                  color: CustomColors.black,
                  fontSize: 18,
                ),
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 4,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: 25,
                ),
                itemCount: 8,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ViewCategoryData(
                      //       catId: sliderList[i]['id'],
                      //       heading: sliderList[i]['title']['en'],
                      //     ),
                      //   ),
                      // );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.grey.shade200,
                            Colors.grey.shade300,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Image.network(
                          //   widget.viewItems['path'] +
                          //       '/' +
                          //       sliderList[i]['image'],
                          //   height: 50,
                          // ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              'Title',
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sliderList() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      // decoration: BoxDecoration(border: Border.all(color: Colors.grey,),),
      child: CarouselSlider(
        options: CarouselOptions(
            initialPage: 0,
            height: 150,
            enlargeCenterPage: true,
            reverse: false,
            enableInfiniteScroll: true,
            scrollDirection: Axis.horizontal,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                //   _current = index;
              });
            }),
        items: <Widget>[
          for (var i = 0; i < 5; i++)
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 130,
                width: MediaQuery.of(context).size.width * 0.6,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      CustomColors.orange.withOpacity(0.6),
                      CustomColors.darkOrange,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    color: CustomColors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
