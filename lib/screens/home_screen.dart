import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mistubishi_example_app/models/data.dart';
import 'package:mistubishi_example_app/widgets/item_categoris_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black, //or set color with: Color(0xFF0000FF)
    ));

    final categories = LoadData().initCategories();

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(color: Colors.black),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo top - left
                    Hero(
                      tag: 'banner',
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: AspectRatio(
                          aspectRatio: 7 / 3,
                          child: Center(
                            child: Image.asset(
                              'assets/logo-mits.png',
                              scale: 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Slogan top - right
                    Padding(
                      padding: EdgeInsets.only(right: 35),
                      child: AspectRatio(
                        aspectRatio: 5 / 3,
                        child: Center(
                          child: Image.asset(
                            'assets/slogan.png',
                            scale: 0.1,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // List view show Categories
            Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return ItemCategoriesWidget(item: categories[index]);
                      }),
                ))
          ],
        ),
      ),
    );
  }
}
