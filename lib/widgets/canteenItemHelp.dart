import 'package:flutter/material.dart';

class CanteenItemHelp extends StatelessWidget {
  final title;
  final imageUrl;
  final price;

  CanteenItemHelp(this.title, this.imageUrl, this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            InkWell(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 5,
                          child: Container(
                            color: Colors.black54,
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            width: 220,
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(price),
                        IconButton(
                            icon: Icon(Icons.favorite), onPressed: () {}),
                      ],
                    )
                  ],
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

