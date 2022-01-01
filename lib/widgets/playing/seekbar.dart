import 'package:flutter/material.dart';

import '../../controller/player_controller.dart';
import '../../utils/converter.dart';

class SeekBar extends StatefulWidget {
  const SeekBar({Key? key}) : super(key: key);

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  final controller = PlayerController.instance;
  bool isDragging = false;
  double position = 0;

  @override
  Widget build(BuildContext context) {
    final duration = controller.current!.duration;

    return StreamBuilder<Duration>(
        stream: controller.onPositionChanged,
        builder: (context, snapshot) {
          if (!isDragging && snapshot.hasData) {
            position = snapshot.data!.inSeconds.toDouble();
          }

          // TODO: Giải pháp tạm thời
          // Nguyên nhân: Khi chuyển sang bài mới, onPositionChanged vẫn nhận gửi giá trị
          // dẫn đến trường hợp position > duration
          // Lỗi tồn tại: Khi chuyển bài, position có thể nằm ở giữa rồi mới về 0
          if (position > duration) {
            position = 0;
          }

          return Slider(
            value: position,
            onChangeStart: (_) {
              isDragging = true;
            },
            onChanged: (value) {
              setState(() {
                position = value;
              });
            },
            onChangeEnd: (value) {
              isDragging = false;
              controller.setPosition(value.toInt());
            },
            divisions: duration,
            label: Converter.formatSecond(position.toInt()) +
                ' / ' +
                Converter.formatSecond(duration),
            min: 0,
            max: duration.toDouble(),
            activeColor: Theme.of(context).primaryColor,
          );
        });
  }
}
