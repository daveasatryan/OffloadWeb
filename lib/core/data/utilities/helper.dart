import 'package:dart_extensions_methods/dart_extension_methods.dart';

extension ObjectExt<T> on T {
  R let<R>(R Function(T that) op) => op(this);

  M also<M>(Function(M that) op) {
    op(this as M);
    return this as M;
  }

  K? nullableCast<K>() => this is K ? (this as K) : null;
}

extension ListExt<T> on List<T> {
  Map<K, List<D>> groupBy<K, D>(K Function(D) keySelector) {
    final result = <K, List<D>>{};
    forEach(
      (element) {
        element.nullableCast<D>()?.let(
          (it) {
            final key = keySelector(it);
            if (result.containsKey(key)) {
              result[key]?.add(it);
            } else {
              result[key] = [it];
            }
          },
        );
      },
    );
    return result;
  }

  List<R> mapIndexed<R>(R Function(int index, T element) toValue) {
    final List<R> result = [];

    for (int index = 0; index < length; index++) {
      result.add(toValue(index, this[index]));
    }

    return result;
  }

  T? getOrNull(int index) {
    if (length > index && index >= 0) {
      return this[index];
    }

    return null;
  }
}

extension StringExt on String? {
  String? get nullIfEmpty => isNotNullOrEmpty() ? this : null;
}
