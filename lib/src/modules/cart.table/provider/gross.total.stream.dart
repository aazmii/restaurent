import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_sq/src/app.db/tables/item.table.dart';
import 'package:pos_sq/src/modules/order.detail/models/item.dart';
import 'package:pos_sq/src/modules/order.detail/provider/order.provider.dart';

final grossStream = StreamProvider<double>((ref) {
  final sl = ref.watch(orderProvider);
  if (sl == null) return const Stream.empty();
  Stream<List<Item>> itemDataStream = ItemTable.watchItems(orderSerial: sl);

  return itemDataStream.map((List<Item> itemDataList) {
    return itemDataList.fold(0.0, (sum, Item item) {
      final price = item.price ?? 0.0;
      return sum + (price) * item.count!;
    });
  });
});
