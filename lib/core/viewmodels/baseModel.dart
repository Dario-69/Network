import 'package:flutter/cupertino.dart';

class BaseModel extends ChangeNotifier{
  bool _submit = false;
  bool get submit => _submit;

  void setBusy(bool value) {
    _submit = value;
    notifyListeners();
  }
}
