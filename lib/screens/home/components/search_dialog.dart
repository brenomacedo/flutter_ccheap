import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {


  SearchDialog({ this.currentSearch }) :
    _controller = TextEditingController(
      text: currentSearch
    );

  final String currentSearch;
  final _controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 2,
          left: 2,
          right: 2,
          child: Card(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                prefixIcon: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.grey[700],
                  onPressed: Navigator.of(context).pop,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: _controller.clear,
                  color: Colors.grey[700],
                )
              ),
              onSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
              textInputAction: TextInputAction.search,
              autofocus: true,
            ),
          ),
        )
      ],
    );
  }
}