import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_paging_model.freezed.dart';

part 'base_paging_model.g.dart';

@Freezed(genericArgumentFactories: true)
class BasePagingModel<T> with _$BasePagingModel<T> {
  const factory BasePagingModel({
    @JsonKey(name: 'data') List<T>? data,
    @JsonKey(name: 'count') int? count,
  }) = _BasePagingModel;

factory BasePagingModel.fromJson(Map<String, Object?> json, T Function(Object?) fromJsonT,) => _$BasePagingModelFromJson(json, fromJsonT);
}
