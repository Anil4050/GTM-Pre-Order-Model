class StockSnapshot {
final String productId;
final DateTime date; // service date
final int availableQty;
const StockSnapshot({required this.productId, required this.date, required this.availableQty});
}