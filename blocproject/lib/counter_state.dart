part of 'counter_cubit.dart';
// import 'package:equatable/equatable.dart';
class CounterState extends Equatable {
  int counterValue;


  CounterState({
    required this.counterValue,

  });

  Map<String, dynamic> toMap() {
    return {
      'counterValue': counterValue,

    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return CounterState(
      counterValue: map['counterValue'],

    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source));

  @override
  String toString() =>
       '$counterValue';

  @override
  // TODO: implement props
  List<Object?> get props => [counterValue];


  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'number': counterValue,
    };
  }

  // Helper function to convert a Map to an instance of MyUser
  CounterState.fromFirebaseMap(Map<int, Object?> data)
      : counterValue = data['number'] as int;

  // Helper function that updates some properties of this instance,
  // and returns a new updated instance of MyUser
  CounterState copyWith({
    int? counterValue,
  }) {
    return CounterState(
      counterValue: counterValue ?? this.counterValue,
    );
  }
}