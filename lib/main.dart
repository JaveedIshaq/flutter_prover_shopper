import 'package:flutter/material.dart';
import 'package:flutter_provider_shopper/common/theme.dart';
import 'package:flutter_provider_shopper/models/cart.dart';
import 'package:flutter_provider_shopper/models/catalog.dart';
import 'package:flutter_provider_shopper/screens/cart.dart';
import 'package:flutter_provider_shopper/screens/catalog.dart';
import 'package:flutter_provider_shopper/screens/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            cart.catalog = catalog;
            return cart;
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Provider Flutter Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (_) => MyLogin(),
          '/catalog': (_) => MyCatalog(),
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}
