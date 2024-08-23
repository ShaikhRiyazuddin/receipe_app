import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:receipe_app/core/constants/constant.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.size,
    required this.name,
    required this.image,
  });

  final Size size;
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  padding: EdgeInsets.only(top: 6, bottom: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: const [
                      BoxShadow(
                        color: kGreyColor,
                        spreadRadius: 4,
                        blurRadius: 4,
                        //offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(children: [
                      CachedNetworkImage(
                        width: size.width / 5.2,
                        height: size.height / 12,
                        imageUrl: '$image',
                        imageBuilder: (_, image) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: image,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                     const SizedBox(width: 16.0),
                      Container(
                        width: 150.0,
                        child: Text(
                          name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              //  SizedBox(width: 16, height: 24)
            ],
          ),
        ],
      ),
    );
  }
}

class HeaderWithImage extends StatelessWidget {
  const HeaderWithImage({
    super.key,
    required this.name,
    required this.img,
    required this.height,
  });

  final String img;
  final String name;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 190,
          width: double.infinity,
          //color: const Color(0xff673ab7),
          child: Column(
            children: [
              Container(
                height: 150,
                child: Image.network(img),
              ),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
      ],
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({
    super.key,
    required this.size,
    required this.name,
    required this.image,
  });

  final Size size;
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              width: size.width / 5.2,
              height: size.height / 12,
              imageUrl: '$image',
              imageBuilder: (_, image) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image,
                  ),
                ),
              ),
             placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Text(
              name.toUpperCase(),
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class CustomFavButton extends StatelessWidget {
  final bool isFavorate;
  final Function(bool add) onPress;
  CustomFavButton({super.key, this.isFavorate = false, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress(isFavorate ? false : true);
      },
      child: Container(
        height: 38,
        width: 38,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.black87,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child:  Icon(isFavorate ? Icons.favorite : Icons.favorite_border_outlined, color: isFavorate ? Colors.redAccent : Colors.grey.shade300,) 
        ),
      ),
    );
  }
}
