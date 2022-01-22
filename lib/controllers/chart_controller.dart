import 'dart:async';
import 'dart:math';

import '../models/hour_counting.dart';
import '../models/playing_log.dart';
import '../providers/playing_log_provider.dart';
import '../utils/my_datetime.dart';

const CHART_TOP = 3; // 3 bài hát

class ChartController {
  static final ChartController instance = ChartController._internal();
  ChartController._internal() {
    _setupTimer();
  }

  final Map<String, HourCounting> _allData = {};
  List<HourCounting> currentChartData = [];

  final StreamController<void> _chartUpdateController =
      StreamController<void>.broadcast();
  Stream<void> get onChartUpdate => _chartUpdateController.stream;
  final StreamController<void> _listUpdateController =
      StreamController<void>.broadcast();
  Stream<void> get onListUpdate => _listUpdateController.stream;

  late DateTime _firstHour;
  late DateTime _lastHour;
  final StreamController<DateTime> _hourController =
      StreamController<DateTime>.broadcast();

  DateTime get currentHour => _lastHour;
  int get firstHour => _firstHour.hour;
  int get lastHour => _lastHour.hour;

  bool isInit = false;
  void init() {
    if (isInit) return;
    PlayingLogProvider.instance.setupChangesListener();
    _initData();
    _setupUpdateListener();
    isInit = true;
  }

  void _initData() {
    List<PlayingLog> logs = PlayingLogProvider.instance.list;
    for (PlayingLog log in logs) {
      _addLog(log);
    }
    _selectTop();
  }

  void _setupUpdateListener() {
    _hourController.stream.listen((event) {
      _selectTop();
      _chartUpdateController.add(null);
    });

    PlayingLogProvider.instance.onNewLogs.listen((logs) {
      for (PlayingLog log in logs) {
        _addLog(log);
      }
      var isChanges = _selectTop();
      if (isChanges['chartChange']!) {
        _chartUpdateController.add(null);
      }
      if (isChanges['listChange']!) {
        _listUpdateController.add(null);
      }
    });
  }

  void _addLog(PlayingLog log) {
    final logHour = MyDateTime.getToHour(log.datetime.toDate());
    if (MyDateTime.isToday(logHour)) {
      if (logHour.difference(_firstHour).inSeconds >= 0) {
        if (!_allData.containsKey(log.musicID)) {
          _allData[log.musicID] = HourCounting(log.musicID, _firstHour);
        }
        _allData[log.musicID]!.inc(logHour);
      }
    }
  }

  Map<String, bool> _selectTop() {
    List<String> keys = [];
    List<int> values = [];

    _allData.forEach((key, value) {
      keys.add(key);
      values.add(value.sumListens(_lastHour));
    });

    for (int i = 0; i < values.length - 1; i++) {
      for (int j = i + 1; j < values.length; j++) {
        if (values[i] < values[j]) {
          var tmp1 = values[i];
          values[i] = values[j];
          values[j] = tmp1;
          var tmp2 = keys[i];
          keys[i] = keys[j];
          keys[j] = tmp2;
        }
      }
    }

    List<HourCounting> newChartData = [];
    keys.take(min(CHART_TOP, _allData.length)).toList().forEach((musicId) {
      newChartData.add(_allData[musicId]!);
    });

    newChartData = _handleColor(newChartData);
    if (newChartData.length != currentChartData.length) {
      currentChartData = newChartData;
      return {'chartChange': true, 'listChange': true};
    }

    bool isChartChanged = true;
    for (int i = 0; i < newChartData.length; i++) {
      if (!newChartData[i].equals(currentChartData[i])) {
        isChartChanged = false;
      }
    }
    bool isListChange = true;
    for (int i = 0; i < newChartData.length; i++) {
      if (newChartData[i].musicID != currentChartData[i].musicID) {
        isListChange = false;
      }
    }
    currentChartData = newChartData;
    return {'chartChange': isChartChanged, 'listChange': isListChange};
  }

  List<HourCounting> _handleColor(List<HourCounting> newChartData) {
    List<String> oldMusicIDs = currentChartData.map((e) => e.musicID).toList();
    List<int> colorPool = [for (int i = 1; i <= CHART_TOP; i++) i];
    List<int> diffIdx = [];

    for (int i = 0; i < min(CHART_TOP, newChartData.length); i++) {
      int j = oldMusicIDs.indexOf(newChartData[i].musicID);
      if (j != -1) {
        newChartData[i].color = currentChartData[j].color;
        colorPool.remove(newChartData[i].color);
      } else {
        diffIdx.add(i);
      }
    }

    for (int i in diffIdx) {
      newChartData[i].color = colorPool.last;
      colorPool.removeLast();
    }

    return newChartData;
  }

  void _setupTimer() {
    DateTime current = DateTime.now();
    _lastHour = MyDateTime.getToHour(current);
    _firstHour = _lastHour.subtract(const Duration(hours: HOURS - 1));

    Stream.periodic(const Duration(minutes: 1), (count) => count).listen((_) {
      current = current.add(const Duration(minutes: 1));
      if (current.hour != _lastHour.hour) {
        _lastHour = MyDateTime.getToHour(current);
        _firstHour = _lastHour.subtract(const Duration(hours: HOURS));
        _hourController.add(_lastHour);
      }
    });
  }
}
