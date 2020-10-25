import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/auth_screen.dart';
import 'screens/edit_product_screen.dart';
import 'provider/orders.dart';
import 'provider/cart.dart';
import 'provider/auth.dart';
import './provider/products_provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          // <Auth> zorgt ervoor dat de provider afhangt van de Auth Provider.
          update: (ctx, auth, previousProducts) => Products(
              auth.token,
              previousProducts == null
                  ? []
                  : previousProducts
                      .items), // haalt items uit de oude state. Zo verlies je geen items in je scherm
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.amber,
            accentColor: Colors.grey,
            fontFamily: 'Lato',
            errorColor: Colors.red,
          ),
          home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen()
          },
        ),
      ),
    );
  }
}
