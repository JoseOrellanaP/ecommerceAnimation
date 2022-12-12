

import 'package:animationsapp/constants.dart';
import 'package:animationsapp/controllers/home_controller.dart';
import 'package:animationsapp/models/Product.dart';
import 'package:animationsapp/models/ProductItem.dart';
import 'package:animationsapp/screens/details/details_screen.dart';
import 'package:animationsapp/screens/home/components/cart_short_view.dart';
import 'package:animationsapp/screens/home/components/product_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'components/cart_datails_view.dart';
import 'components/cart_detailsview_card.dart';
import 'components/header.dart';

class HomeScreen extends StatelessWidget {

  final controller = HomeController();

  void _onVerticalGesture(DragUpdateDetails details){
    if(details.primaryDelta! < .7){
      controller.changeHomeState(HomeState.cart);
    }else if(details.primaryDelta! > 12){
      controller.changeHomeState(HomeState.normal);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Color(0xFFEAEAEA),
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return LayoutBuilder(
                builder: (context, BoxConstraints constraints) {
                  return Stack(
                    children: [
                      AnimatedPositioned(
                        duration: panelTransition,
                        top: controller.homeState == HomeState.normal
                          ? headerHeight
                          : -(constraints.maxHeight - cartBarHeight * 2 - headerHeight),
                        left: 0,
                        right: 0,
                        height: 
                          constraints.maxHeight - headerHeight - cartBarHeight,
                        child: Container(
                          padding: 
                            const EdgeInsets.symmetric(horizontal: defaultPadding),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(defaultPadding * 1.5),
                                bottomRight: Radius.circular(defaultPadding * 1.5),
                              )
                            ),
                          child: GridView.builder(
                            itemCount: demo_products.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: .75,
                              mainAxisSpacing: defaultPadding,
                              crossAxisSpacing: defaultPadding,
                            ),
                            itemBuilder: (context, index) => ProductCard(
                              product: demo_products[index],
                              press: (){
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: 
                                      const Duration(milliseconds: 500),
                                    reverseTransitionDuration: 
                                      const Duration(milliseconds: 500),
                                    pageBuilder: (context, animation,
                                      secondaryAnimation) => 
                                        FadeTransition(
                                          opacity: animation,
                                          child: DetailsScreen(
                                            product: demo_products[index],
                                            onProductAdd: (){
                                              controller.addProductToCard(
                                                demo_products[index]);
                                            },
                                          ),
                                        )
                                  )
                                );
                              }
                            ),
                          ),
                        ),
                      ),
                      // Card panel
                      AnimatedPositioned(
                        duration: panelTransition,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: controller.homeState == HomeState.normal
                          ? cartBarHeight
                          : (constraints.maxHeight -
                            cartBarHeight),
                        child: GestureDetector(
                          onVerticalDragUpdate: _onVerticalGesture,
                          child: Container(
                            //color: Colors.red,
                            color: Color(0xFFEAEAEA),
                            alignment: Alignment.topLeft,
                            child: AnimatedSwitcher(
                              duration: panelTransition,
                              child: controller.homeState == HomeState.normal 
                              ? CartShortView(controller: controller)
                              : CartDetailsView(controller: controller,),
                            ),
                          ),
                        ),
                      ),
                      // Header
                      AnimatedPositioned(
                        duration: panelTransition,
                        top: controller.homeState == HomeState.normal
                          ? 0
                          : - headerHeight,
                        left: 0,
                        right: 0,
                        height: headerHeight,
                        child: HomeHeader(),
                      ),
                    ],
                  );
                }
              );
            }
          ),
        ),
      ),
    );
  }
}
