import 'package:charts_flutter/flutter.dart' hide Color;
import 'package:flutter/material.dart';

class ListensPoint {
  final int hour;
  final int listens;

  ListensPoint(this.hour, this.listens);
}

class ChartPage extends StatelessWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final List<Series<dynamic, num>> seriesList = [
      Series<ListensPoint, int>(
          id: 'Bai 1',
          colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
          domainFn: (ListensPoint point, _) => point.hour,
          measureFn: (ListensPoint point, _) => point.listens,
          data: [
            ListensPoint(0, 7),
            ListensPoint(1, 2),
            ListensPoint(2, 4),
            ListensPoint(3, 5),
          ]),
      Series<ListensPoint, int>(
          id: 'Bai 2',
          colorFn: (_, __) => MaterialPalette.red.shadeDefault,
          domainFn: (ListensPoint point, _) => point.hour,
          measureFn: (ListensPoint point, _) => point.listens,
          data: [
            ListensPoint(0, 1),
            ListensPoint(1, 5),
            ListensPoint(2, 0),
            ListensPoint(3, 6),
          ]),
      Series<ListensPoint, int>(
          id: 'Bai 3',
          colorFn: (_, __) => MaterialPalette.green.shadeDefault,
          domainFn: (ListensPoint point, _) => point.hour,
          measureFn: (ListensPoint point, _) => point.listens,
          data: [
            ListensPoint(0, 5),
            ListensPoint(1, 2),
            ListensPoint(2, 7),
            ListensPoint(3, 3),
          ]),
    ];

    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight / 2 + 60,
              decoration: const BoxDecoration(
                  gradient: RadialGradient(radius: 0.6, colors: [
                Colors.black,
                // Color(0xFF261937),
                Color(0xFF391B50)
              ])),
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top, bottom: 20),
                child: LineChart(
                  seriesList,
                  animate: false,
                  defaultRenderer:
                      LineRendererConfig(includePoints: true, strokeWidthPx: 3),
                  primaryMeasureAxis: const NumericAxisSpec(
                      renderSpec: GridlineRendererSpec(
                    labelStyle: TextStyleSpec(
                      fontSize: 12,
                      color: MaterialPalette.white,
                    ),
                  )),
                  domainAxis: const NumericAxisSpec(
                      renderSpec: GridlineRendererSpec(
                    axisLineStyle:
                        LineStyleSpec(color: MaterialPalette.transparent),
                    lineStyle:
                        LineStyleSpec(color: MaterialPalette.transparent),
                    labelStyle: TextStyleSpec(
                      fontSize: 12,
                      color: MaterialPalette.white,
                    ),
                  )),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: screenHeight / 2 + 40),
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xFF271C3A),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
          ),
        )
      ],
    );
  }
}
