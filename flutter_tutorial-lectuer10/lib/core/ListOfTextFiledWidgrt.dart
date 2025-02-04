import 'package:flutter/material.dart';

class FriendTextFields extends StatefulWidget {
  final int index;

  const FriendTextFields(this.index, {Key? key}) : super(key: key);

  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _MyFormState.friendsList[widget.index] ?? '');
    _nameController.addListener(() {
      _MyFormState.friendsList[widget.index] = _nameController.text;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        hintText: "Enter your friend's name",
      ),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}

class _MyFormState {
  static List<String?> friendsList = List.filled(10, null);
}
