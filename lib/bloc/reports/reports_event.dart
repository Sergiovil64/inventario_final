import 'package:equatable/equatable.dart';

abstract class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSalesAndPurchasesReport extends ReportsEvent {
  const LoadSalesAndPurchasesReport({
    required this.startDate,
    required this.endDate,
    this.locationId,
  });

  final DateTime startDate;
  final DateTime endDate;
  final String? locationId;

  @override
  List<Object?> get props => [startDate, endDate, locationId];
}

class LoadTransfersReport extends ReportsEvent {
  const LoadTransfersReport({
    required this.startDate,
    required this.endDate,
    this.sourceLocationId,
    this.targetLocationId,
  });

  final DateTime startDate;
  final DateTime endDate;
  final String? sourceLocationId;
  final String? targetLocationId;

  @override
  List<Object?> get props => [startDate, endDate, sourceLocationId, targetLocationId];
}

class LoadDailySalesReport extends ReportsEvent {
  const LoadDailySalesReport({required this.date});

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

class ResetReports extends ReportsEvent {
  const ResetReports();
}

