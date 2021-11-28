import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
    this.onTap,
    this.autofocus = false,
    this.enabled = true,
  }) : super(key: key);

  final void Function()? onTap;
  final bool autofocus;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    const height = 30.0;

    return SizedBox(
      height: height,
      child: GestureDetector(
        onTap: onTap,
        child: TextField(
          autofocus: autofocus,
          enabled: enabled,
          textAlignVertical: TextAlignVertical.bottom,
          cursorColor: Theme.of(context).primaryColor,
          cursorWidth: 1.5,
          decoration: InputDecoration(
            hintText: 'Bài hát, nghệ sĩ...',
            hintStyle: TextStyle(
              color: Theme.of(context).hintColor,
            ),
            prefixIcon: Icon(Icons.search, color: Theme.of(context).hintColor),
            isDense: true,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(height / 2),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
