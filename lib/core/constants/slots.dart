enum DeliverySlot { morning, afternoon, evening }

extension DeliverySlotLabel on DeliverySlot {
  String get label => switch (this) {
        DeliverySlot.morning => 'Morning 8–11',
        DeliverySlot.afternoon => 'Afternoon 12–3',
        DeliverySlot.evening => 'Evening 4–7',
      };
}
