import 'package:stacked/stacked.dart';

const singleton = 'singleton';

@singleton
class DiscoverVM extends FutureViewModel<List<stores>> {
  @override
  Future<List<stores>> futureToRun() {
    // TODO: implement futureToRun
    throw UnimplementedError();
  }


}

class stores {
}