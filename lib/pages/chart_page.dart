import 'package:charts_flutter/flutter.dart' hide Color;
import 'package:flutter/material.dart';

import '../controllers/player_controller.dart';
import '../models/music.dart';
import '../providers/music_provider.dart';
import '../widgets/common/ranked_music_card.dart';
import '../controllers/chart_controller.dart';
import '../models/hour_counting.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final chartColorMap = {
      0: MaterialPalette.white,
      1: MaterialPalette.blue.shadeDefault,
      2: MaterialPalette.red.shadeDefault,
      3: MaterialPalette.green.shadeDefault,
    };

    final listColorMap = {
      0: Colors.white,
      1: Colors.blue,
      2: Colors.red,
      3: Colors.green,
    };

    final playerController = PlayerController.instance;
    final chartController = ChartController.instance;
    chartController.init();

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
                child: StreamBuilder<void>(
                    stream: chartController.onChartUpdate,
                    builder: (_, __) {
                      final List<Series<dynamic, num>> seriesList = [
                        for (var hourCounting
                            in chartController.currentChartData)
                          Series<Point, int>(
                              id: hourCounting.musicID,
                              colorFn: (_, __) =>
                                  chartColorMap[hourCounting.color] ??
                                  MaterialPalette.white,
                              domainFn: (Point point, _) => point.x,
                              measureFn: (Point point, _) => point.y,
                              data: hourCounting
                                  .getPoints(chartController.currentHour))
                      ];

                      return LineChart(
                        seriesList,
                        animate: false,
                        defaultRenderer: LineRendererConfig(
                            includePoints: true, strokeWidthPx: 3),
                        primaryMeasureAxis: const NumericAxisSpec(
                            renderSpec: GridlineRendererSpec(
                          labelStyle: TextStyleSpec(
                            fontSize: 12,
                            color: MaterialPalette.white,
                          ),
                        )),
                        domainAxis: NumericAxisSpec(
                          tickProviderSpec: StaticNumericTickProviderSpec([
                            for (int i = chartController.firstHour;
                                i <= chartController.lastHour;
                                i++)
                              TickSpec(i),
                          ]),
                          renderSpec: const GridlineRendererSpec(
                            axisLineStyle: LineStyleSpec(
                                color: MaterialPalette.transparent),
                            lineStyle: LineStyleSpec(
                                color: MaterialPalette.transparent),
                            labelStyle: TextStyleSpec(
                              fontSize: 12,
                              color: MaterialPalette.white,
                            ),
                          ),
                        ),
                      );
                    }),
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
            child: StreamBuilder<void>(
                stream: chartController.onListUpdate,
                builder: (_, __) {
                  final musicIDs = chartController.currentChartData
                      .map((e) => e.musicID)
                      .toList();

                  List<Music> musics = musicIDs
                      .map((id) => MusicProvider.instance.getByID(id))
                      .toList();
                  List<Color> colors = chartController.currentChartData
                      .map((e) => listColorMap[e.color]!)
                      .toList();

                  return ListView.builder(
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      itemCount: musics.length,
                      itemBuilder: (_, i) {
                        final music = musics[i];
                        return InkWell(
                          child: RankedMusicCard(
                            order: i + 1,
                            title: music.title,
                            artists: music.artists,
                            thumbnailUrl: music.thumbnailUrl,
                            orderColor: colors[i],
                            orderWidth: 60,
                          ),
                          onTap: () {
                            if (!playerController.isActive) {
                              playerController.maximizeScreen(context);
                            }
                            playerController.setMusicList(musics, index: i);
                            playerController.notifyMusicChange();
                          },
                        );
                      });
                }),
          ),
        )
      ],
    );
  }
}
