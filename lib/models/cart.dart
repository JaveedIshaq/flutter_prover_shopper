import 'package:flutter/foundation.dart';
import 'package:flutter_provider_shopper/models/catalog.dart';

class CartModel extends ChangeNotifier {
  /// the private field backing
  CatalogModel _catalogModel;

  /// internal private state of the Cart. Stores the ids of each item.
  final List<int> _itemIds = [];

  /// The current catalog. Used to construct items from numeric ids.
  CatalogModel get catalog => _catalogModel;

  set catalog(CatalogModel newCatalog) {
    assert(newCatalog != null);
    assert(_itemIds.every((id) => newCatalog.getById(id) != null),
        'The catalog $newCatalog does not have one of $_itemIds in it.');
    _catalogModel = newCatalog;

    // Notify listeners, in case the new catalog provides information
    // different from the previous one. For example, availability of an item
    // might have changed.

    notifyListeners();
  }

  /// List of items in the cart.
  List<Item> get items =>
      _itemIds.map((id) => _catalogModel.getById(id)).toList();

  /// the current total price of all items
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  /// Adds [item] to cart. This is the only way to modify the cart from outside.

  void add(Item item) {
    _itemIds.add(item.id);

    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.

    notifyListeners();
  }
}
