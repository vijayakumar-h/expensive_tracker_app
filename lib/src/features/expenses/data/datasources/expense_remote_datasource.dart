import 'package:expensive_tracker_app/common_exports.dart';

abstract class ExpenseRemoteDataSource {
  Future<void> syncExpenses();
}

class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  final ApiService apiService;

  ExpenseRemoteDataSourceImpl({required this.apiService});

  @override
  Future<void> syncExpenses() async {
    // Interacts with ApiService singleton if API endpoint is active
  }
}
