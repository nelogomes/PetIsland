part of petisland.post.screen.widget;

class CommentListingWidget extends StatefulWidget {
  final Post item;
  final CommentBloc bloc;

  const CommentListingWidget({Key key, @required this.item, @required this.bloc}) : super(key: key);

  @override
  _CommentListingWidgetState createState() => _CommentListingWidgetState();
}

class _CommentListingWidgetState extends State<CommentListingWidget> {
  CommentBloc get bloc => widget.bloc;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildTextDescription(context, 'Bình luận'),
        BlocBuilder<CommentBloc, CommentState>(
          bloc: bloc,
          condition: (_, state) => state is ReloadUIState,
          builder: _buildCommentUI,
        ),
      ],
    );
  }

  Widget _buildCommentUI(BuildContext context, CommentState state) {
    if (state is ReloadUIState) {
      final items = state.items;
      return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: items.length + 1,
        itemBuilder: (_, __) => _buildComment(_, __, items),
        separatorBuilder: (_, int index) {
          return Divider();
        },
      );
    } else {
      final random = DI.get<Random>(Random);
      return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: random.nextInt(15) + 7,
        itemBuilder: (_, __) => _CommentLoadingWidget(),
        separatorBuilder: (_, int index) {
          return Divider();
        },
      );
    }
  }

  Widget _buildComment(BuildContext context, int index, List<Comment> items) {
    if (index < items.length) {
      final item = items[index];
      return _CommentWidget(item: item, onTapDelete: () => _onTapDelete(index, item));
    } else
      return SizedBox(height: 150);
  }

  void _onTapDelete(int index, Comment comment) {
    DI.get<TWorker>(TWorker).deleteComment(bloc.postId, comment.id);
    bloc.softDeleteComment(comment.id);
  }
}
