import "package:arcane_helper_utils/arcane_helper_utils.dart";
import "package:test/test.dart";

void main() {
  group("Ticker", () {
    test("no ticks emitted when interval is null and timeout is less than 1s",
        () async {
      const ticker = Ticker();
      final stream = ticker.tick(
        timeout: const Duration(milliseconds: 300),
      );

      final List<int> emitted = await stream.toList();
      expect(emitted, isEmpty);
    });

    test("one tick emitted when interval is null and timeout is 1s", () async {
      const ticker = Ticker();
      final stream = ticker.tick(
        timeout: const Duration(seconds: 1),
      );

      final List<int> emitted = await stream.toList();
      expect(emitted, [0]);
    });

    test("multiple ticks emitted when interval is null and timeout >1s",
        () async {
      const ticker = Ticker();
      final stream = ticker.tick(
        timeout: const Duration(seconds: 3),
      );

      final List<int> emitted = await stream.toList();
      expect(emitted, [2, 1, 0]);
    });

    test("respects custom interval", () async {
      const ticker = Ticker();
      final stream = ticker.tick(
        timeout: const Duration(milliseconds: 400),
        interval: const Duration(milliseconds: 200),
      );

      final List<int> emitted = await stream.toList();
      expect(emitted, [1, 0]);
    });

    test("handles zero timeout", () async {
      const ticker = Ticker();
      final stream = ticker.tick(
        timeout: Duration.zero,
        interval: const Duration(seconds: 1),
      );

      final List<int> emitted = await stream.toList();
      expect(emitted, isEmpty);
    });

    test("handles timeout less than interval", () async {
      const ticker = Ticker();
      final stream = ticker.tick(
        timeout: const Duration(milliseconds: 500),
        interval: const Duration(seconds: 1),
      );

      final List<int> emitted = await stream.toList();
      expect(emitted, isEmpty);
    });
  });
}
