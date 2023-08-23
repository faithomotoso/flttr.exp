class Utils {
  // Can be an extension
  static Map<K, List<V>> groupBy<K, V>(Iterable<V> data, K Function(V d) keyGen) {
    Map<K, List<V>> mapData = {};

    for (V v in data) {
      K key = keyGen(v);
      if (!mapData.containsKey(key)) {
        // New group
        mapData[key] = [];
      }

      // Append to list
      mapData[key]!.add(v);
    }

    return mapData;
  }
}
