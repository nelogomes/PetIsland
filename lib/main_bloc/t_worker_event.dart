part of petisland.main_bloc;

abstract class WorkerEvent extends BaseEvent {}

class UploadImageEvent<T> extends WorkerEvent {
  final int numRetry;
  final List<String> imagesMustUpload;
  final T postModal;

  UploadImageEvent._({
    @required this.imagesMustUpload,
    @required this.postModal,
    this.numRetry = 0,
  });

  UploadImageEvent retry() {
    if (numRetry < PetIslandConstants.max_retry) {
      return UploadImageEvent._(
        numRetry: numRetry + 1,
        imagesMustUpload: imagesMustUpload,
        postModal: postModal,
      );
    } else
      throw LimitRetryException();
  }
}

class UploadPostEvent extends WorkerEvent {
  final int numRetry;
  final PostCreateModal postMustUpload;

  UploadPostEvent._({@required this.postMustUpload, this.numRetry = 0});

  UploadPostEvent retry() {
    if (numRetry < PetIslandConstants.max_retry) {
      return UploadPostEvent._(
        numRetry: numRetry + 1,
        postMustUpload: postMustUpload,
      );
    } else
      throw LimitRetryException();
  }
}

class UpdatePostEvent extends WorkerEvent {
  final int numRetry;
  final PostEditModal postMustUpdate;

  UpdatePostEvent._({@required this.postMustUpdate, this.numRetry = 0});

  UpdatePostEvent retry() {
    if (numRetry < PetIslandConstants.max_retry) {
      return UpdatePostEvent._(numRetry: numRetry + 1, postMustUpdate: postMustUpdate);
    } else
      throw LimitRetryException();
  }
}

class UploadPostSuccessEvent extends WorkerEvent {
  final Post item;

  UploadPostSuccessEvent(this.item);
}

class UploadFailedEvent extends BaseErrorEvent implements WorkerEvent {
  UploadFailedEvent(String message) : super(message);
}

class LikePostEvent extends WorkerEvent {
  final String id;

  LikePostEvent(this.id);
}

class ReportPostEvent extends WorkerEvent {
  final String reason;
  final String postId;
  final String accountId;
  final String description;
  final int numRetry;

  ReportPostEvent(this.reason, this.postId, this.accountId, {this.description})
      : numRetry = 0;

  ReportPostEvent._(this.reason, this.postId, this.accountId,
      {this.description, @required this.numRetry});

  ReportPostEvent retry() {
    if (numRetry < PetIslandConstants.max_retry) {
      return ReportPostEvent._(
        reason,
        postId,
        accountId,
        numRetry: numRetry + 1,
      );
    } else
      throw LimitRetryException();
  }
}

class DeletePostEvent extends WorkerEvent {
  final String postId;

  DeletePostEvent(this.postId);
}

class CommentPostEvent extends WorkerEvent {
  final String postId;
  final String message;

  CommentPostEvent(this.postId, this.message);
}

class DeleteCommentPostEvent extends WorkerEvent {
  final String postId;
  final String commentId;

  DeleteCommentPostEvent(this.postId, this.commentId);
}
