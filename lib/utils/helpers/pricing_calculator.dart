class CPricingCalculator {
  //nanti cari api buat perkiraan shipping cost
  static double getShippingCost(String location) {
    //contoh
    return 10000;
  }

  //ngitung total harga setelah pajak + ongkir
  static double calculateTotalPrice(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    double totalPrice = productPrice + shippingCost;
    return totalPrice;
  }

  //jumlahin harga di keranjang
  // static double calculateCartTotal(CartModel cart) {
  //   return cart.items.map((e) => e.price).fold(0, (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0));
  // }
}
