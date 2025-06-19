extension ListsExtension<T> on Iterable<T>? {
  bool isEmptyOrNull() {
    return this == null || this!.isEmpty;
  }

  bool isNotEmptyOrNull() {
    return this != null && this!.isNotEmpty;
  }

  T? firstWhereOrNull(bool Function(T element) test) {
    if (this == null) return null;
    for (var element in this!) {
      if (test(element)) return element;
    }
    return null;
  }
}
