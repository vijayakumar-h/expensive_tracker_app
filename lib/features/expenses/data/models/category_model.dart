import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'expense_model.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final int iconCode;
  final TransactionType type;

  CategoryModel({
    String? id,
    required this.name,
    required this.iconCode,
    required this.type,
  }) : id = id ?? const Uuid().v4();

  factory CategoryModel.fromMap(Map<dynamic, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String?,
      name: map['name'] as String? ?? 'General',
      iconCode: map['iconCode'] as int? ?? Icons.category.codePoint,
      type: map['type'] == 'income'
          ? TransactionType.income
          : TransactionType.expense,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconCode': iconCode,
      'type': type == TransactionType.income ? 'income' : 'expense',
    };
  }

  @override
  List<Object?> get props => [id, name, iconCode, type];
}
