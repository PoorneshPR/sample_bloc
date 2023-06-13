import 'dart:async';

class MyBloc{
// Define the sink and stream controllers
  int i=0;

  final _myController = StreamController<int>();
  Stream<int> get myStream => _myController.stream;
  Sink<int> get mySink => _myController.sink;

  // Define the business logic
  void processEvent(int event) {
i=i+1;
   int newState = event;
    mySink.add(newState);
  }

  // Dispose the controllers
  void dispose() {
    _myController.close();
  }
}