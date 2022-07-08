import 'package:network_tracer/utils/object_connector/line_data.dart';

class ConnectionData {
  ConnectionData(this.l1, this.l2);

  final ConnectionLineData l1;
  final ConnectionLineData l2;

  @override
  bool operator ==(Object other) =>
      other is ConnectionData &&
      (l1 == other.l1 && l2 == other.l2 || l1 == other.l2 && l2 == other.l1);

  @override
  int get hashCode => l1.hashCode * l2.hashCode;
}
