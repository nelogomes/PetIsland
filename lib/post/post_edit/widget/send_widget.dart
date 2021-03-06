part of petisland.post.post_edit.widget;

class SendWidget extends TStatelessWidget {
  final Function() onPressSend;

  SendWidget({@required this.onPressSend});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.done),
          onPressed: _onTapSend,
          // color: T,
        ),
        // Text('Đăng', style: theme.accentTextTheme.subtitle.co),
      ],
    );
  }

  void _onTapSend() {
    if (onPressSend != null) onPressSend();
  }
}
