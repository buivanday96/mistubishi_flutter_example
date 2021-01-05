import 'package:flutter/material.dart';
import 'package:mistubishi_example_app/models/categories.dart';
import 'package:mistubishi_example_app/models/trucks.dart';
import 'package:mistubishi_example_app/screens/detail_screen.dart';

import '../utils/screen_utils.dart';

class ItemCategoriesWidget extends StatefulWidget {
  final Categories item;

  const ItemCategoriesWidget({Key key, @required this.item}) : super(key: key);
  @override
  _ItemCategoriesWidgetState createState() => _ItemCategoriesWidgetState();
}

class _ItemCategoriesWidgetState extends State<ItemCategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Category Name
        Container(
          decoration: BoxDecoration(color: Colors.grey[800]),
          child: Row(
            children: [
              // Icon - left
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 30),
                child: Icon(
                  Icons.arrow_left_sharp,
                  color: Colors.tealAccent[700],
                  size: 40,
                ),
              ),

              // Category Name - right
              Text(
                widget.item.name,
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
        ),

        ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: ScreenUtils().getHeightScreen(context) * (1 / 6.5) + 40,
              minHeight: ScreenUtils().getHeightScreen(context) * (1 / 6.5)),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.item.trucks.length,
              itemBuilder: (context, index) {
                return _itemTruck(context, widget.item.trucks[index], widget.item.name);
                //return Text('');
              }),
        )
      ],
    );
  }

  Widget _itemTruck(BuildContext context, Trucks truck, String categoryName) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6, left: 6, right: 10),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'image${truck.id}${truck.nameCode}$categoryName',
                  child: Image.asset(
                    truck.image,
                    height: ScreenUtils().getHeightScreen(context) * (1 / 6.5),
                    width: ScreenUtils().getWidthScreen(context) * (1 / 6),
                  ),
                ),
                Positioned.fill(
                    child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      //   return DetailScreen(
                      //     trucks: truck,
                      //     categoryName: categoryName,
                      //   );
                      // }));
                      Navigator.of(context).push(PageRouteBuilder(
                          fullscreenDialog: true,
                          transitionDuration: Duration(milliseconds: 500),
                          reverseTransitionDuration: Duration(milliseconds: 500),
                          pageBuilder: (context, animation, secondAnimation) {
                            return DetailScreen(
                              trucks: truck,
                              categoryName: categoryName,
                            );
                          },
                          transitionsBuilder: (context, animation, secondAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          }));
                    },
                  ),
                ))
              ],
            ),

            // Truck Name
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(truck.nameCode),
              ),
            )
          ],
        ),
      ),
    );
  }
}
