import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rx_widgets_plus/rx_widgets.dart';

void main() {
  testWidgets("ReactiveText - When have data", (tester) async {
    var _controller = StreamController<String>();

    var widget = MaterialApp(
        home: RxText(
      _controller.stream,
    ));

    _controller.add("Text");
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text("Text");

    expect(textFinder, findsOneWidget);

    await _controller.close();
  });

  testWidgets("ReactiveText - When have initialData", (tester) async {
    var _controller = StreamController<String>();

    var widget = MaterialApp(
        home: RxText(
      _controller.stream,
      initialData: "WelloWorld",
    ));

    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text("WelloWorld");

    expect(textFinder, findsOneWidget);

    await _controller.close();
  });

  testWidgets("ReactiveText - When the stream receive a error and errorBuilder is passed ", (tester) async {
    var _controller = StreamController<String>();

    var errorKey = Key("ErrorKey");

    var widget = MaterialApp(
        home: RxText(
      _controller.stream,
      errorBuilder: (_, error) => Text(error.toString(), key: errorKey),
    ));

    _controller.addError("Error");
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final keyFinder = find.byKey(errorKey);
    expect(keyFinder, findsOneWidget);

    await _controller.close();
  });

  testWidgets("ReactiveText - When the stream receive a error and no errorBuilder is passed ", (tester) async {
    var _controller = StreamController<String>();

    var widget = MaterialApp(
        home: RxText(
      _controller.stream,
    ));

    _controller.addError("Error");
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final finderContainer = find.byType(Container);
    expect(finderContainer, findsOneWidget);

    await _controller.close();
  });

  testWidgets("ReactiveText - When the stream is empty and no streamEmptyBuilder is passed ", (tester) async {
    var _controller = StreamController<String>();

    var widget = MaterialApp(
        home: RxText(
      _controller.stream,
    ));

    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final finderContainer = find.byType(Container);
    expect(finderContainer, findsOneWidget);

    await _controller.close();
  });

  testWidgets("ReactiveText - When the stream is empty and streamEmptyBuilder is passed ", (tester) async {
    var _controller = StreamController<String>();

    var emptyKey = Key("EmptyKey");

    var widget = MaterialApp(
        home: RxText(
      _controller.stream,
      placeHolderBuilder: (_) => Text("Test", key: emptyKey),
    ));

    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final finderContainer = find.byKey(emptyKey);
    expect(finderContainer, findsOneWidget);

    await _controller.close();
  });
}
