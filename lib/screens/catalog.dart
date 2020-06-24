import 'package:flutter/material.dart';
import 'package:flutter_provider_shopper/models/cart.dart';
import 'package:flutter_provider_shopper/models/catalog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _MyAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 24.0)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MyListItem(index),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      title: Text(
        "Catalog",
        style: GoogleFonts.corben(
          textStyle: Theme.of(context).textTheme.headline1,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  const _MyListItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var catalog = Provider.of<CatalogModel>(context);
    var item = catalog.getByPosition(index);
    var textTheme = Theme.of(context).textTheme.headline6;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    return FlatButton(
        onPressed: cart.items.contains(item) ? null : () => cart.add(item),
        child: cart.items.contains(item)
            ? Icon(
                Icons.check,
                semanticLabel: "ADDED",
              )
            : Text("ADD"));
  }
}
