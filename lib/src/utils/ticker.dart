/// Creates a [Ticker] that emits a tick every [interval] seconds until the
/// [timeout] is reached.
///
/// Options:
/// - `timeout` (Duration) - The amount of time the ticker should run for
/// - `interval` (Duration, _optional_) - The amount of time between each tick.
///    Defaults to `Duration(seconds: 1)`.
///
/// Usage:
/// ```dart
/// final Stream<int> ticker = const Ticker().tick(
///   timeout: Duration(seconds: 30),
///   interval: Duration(seconds: 5)
/// );
///
/// await for (final int ticksRemaining in ticker) {
///   if (ticksRemaining == 0) print("Time's up!");
///   print('Tick! $ticksRemaining');
/// }
/// ```
///
class Ticker {
  const Ticker();

  /// Starts the `Ticker`'s stream.
  Stream<int> tick({
    required Duration timeout,
    Duration interval = const Duration(seconds: 1),
  }) {
    final int ticks = timeout.inSeconds ~/ interval.inSeconds;
    return Stream.periodic(interval, (x) => ticks - x - 1).take(ticks);
  }
}
