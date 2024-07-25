import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

enum PriceCategory {
  below50,
  between50And100,
  between100And250,
  above250,
}

extension PriceCategoryExtension on PriceCategory {
  String get description {
    switch (this) {
      case PriceCategory.below50:
        return 'Below \$50';
      case PriceCategory.between50And100:
        return '\$50 - \$100';
      case PriceCategory.between100And250:
        return '\$100 - \$250';
      case PriceCategory.above250:
        return 'Above \$250';
      default:
        return '';
    }
  }

  static PriceCategory fromDescription(String description) {
    return PriceCategory.values.firstWhere(
      (category) => category.description == description,
      orElse: () => throw ArgumentError('Invalid category description'),
    );
  }
}

final formatter = DateFormat.yMd();
const uuid = Uuid();

class PopModel {
  const PopModel({
    required this.name,
    required this.salary,
    required this.date,
    required this.gender,
  });

  final String name;
  final String salary;
  final DateTime date;
  final String gender;

  String get formattedDate {
    return formatter.format(date);
  }
}

class PopBucket {
  final PriceCategory category;
  int number;

  PopBucket({required this.category, this.number = 0});
}



