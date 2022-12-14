import 'package:animationsapp/components/fav_btn.dart';
import 'package:animationsapp/components/price.dart';
import 'package:animationsapp/constants.dart';
import 'package:animationsapp/models/Product.dart';
import 'package:animationsapp/screens/details/componets/cart_counter.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
    { Key? key, required this.product, required this.onProductAdd }
    ) : super(key: key);

    final Product product;
    final VoidCallback onProductAdd;

  @override
  _DetailScreenState createState() => _DetailScreenState();


}

class _DetailScreenState extends State<DetailsScreen>{
  String _cartTag = "";
  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: ElevatedButton(
              onPressed: (){
                widget.onProductAdd();
                setState(() {
                  _cartTag = '_cartTag';
                });
                Navigator.pop(context);
              },
              child: Text("Add to cart"),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.37,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  color: Color(0xFFF8F8F8),
                  child: Hero(
                    tag: widget.product.title! + _cartTag,
                    child: Image.asset(widget.product.image!),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  child: CartCounter(),
                )
              ],
            ),
          ),
          SizedBox(height: defaultPadding * 1.5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.product.title!,
                    style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Price(amount: "20.00"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Text(
              "Cabbage is a green thing",
              style: TextStyle(
                color: Color(0xFFBDBDBD),
                height: 1.8
              ),
            ),
          )
        ],
      ),
    );
  }
}

AppBar buildAppBar(){
  return AppBar(
    leading: BackButton(
      color: Colors.black,
    ),
    backgroundColor: Color(0xFFF8F8F8),
    elevation: 0,
    centerTitle: true,
    title: Text(
      "Fruits",
      style: TextStyle(color: Colors.black),
    ),
    actions: [
      FavBtn(radius: 20),
      SizedBox(width: defaultPadding,)
    ],
  );
}