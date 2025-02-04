import 'package:flutter/material.dart';

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  const RadioItem(this._item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              color: _item.isSelected ? Colors.blueAccent : Colors.transparent,
              border: Border.all(
                width: 1.0,
                color: _item.isSelected ? Colors.blueAccent : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: Center(
              child: Text(
                _item.buttonText,
                style: TextStyle(
                  color: _item.isSelected ? Colors.white : Colors.black87,
                  fontWeight: _item.isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10), // إضافة مساحة بين المربع والنص
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10.0),
              child: Text(
                _item.text,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected, this.buttonText, this.text);
}
