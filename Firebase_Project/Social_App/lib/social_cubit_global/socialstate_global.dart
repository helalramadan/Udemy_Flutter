abstract class SocialState {}

class SocialinitialState extends SocialState {}

class SocialGetUserLoadState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  final String error;

  SocialGetUserErrorState(this.error);
}

class InitialSearchState extends SocialState {}

class LoadingSearchState extends SocialState {}

class SuccessSearchState extends SocialState {}

class ErrorSearchState extends SocialState {
  final String error;

  ErrorSearchState(this.error);
}

class CahnageBottomNavState extends SocialState {}

class NewPostNavState extends SocialState {}

class SocialProfileImagePickedSuccessState extends SocialState {}

class SocialProfileImagePickedErrorState extends SocialState {
  // final String error;

  // SocialProfileImagePickedErrorState(this.error);
}

class SocialCoverImagePickedSuccessState extends SocialState {}

class SocialCoverImagePickedErrorState extends SocialState {
  // final String error;

  // SocialProfileImagePickedErrorState(this.error);
}

class SocialUploadProfileImageState extends SocialState {}

class SocialUploadProfileImageSuccessState extends SocialState {}

class SocialUploadProfileImageErrorState extends SocialState {
  final String error;

  SocialUploadProfileImageErrorState(this.error);
}

class SocialUploadCoverImageSuccessState extends SocialState {}

class SocialUploadCoverImageErrorState extends SocialState {
  final String error;

  SocialUploadCoverImageErrorState(this.error);
}

class SocialUpdateInfromtionErrorState extends SocialState {
  final String error;

  SocialUpdateInfromtionErrorState(this.error);
}
// creat post

class SocialRemoveImageState extends SocialState {}

class SocialCreatNewPostLoadingState extends SocialState {}

class SocialCreatNewPostSuccessState extends SocialState {}

class SocialCreatNewPostErrorState extends SocialState {
  final String error;

  SocialCreatNewPostErrorState(this.error);
}

class SocialPostImagePickedSuccessState extends SocialState {}

class SocialPostImagePickedErrorState extends SocialState {
  // final String error;

  // SocialPostImagePickedErrorState(this.error);
}

class SocialSignOutSuccessState extends SocialState {}

class SocialSignOutErrorState extends SocialState {
  final String error;

  SocialSignOutErrorState(this.error);
}

class SocialGetPostsSuccessState extends SocialState {}

class SocialGetPostsErrorState extends SocialState {
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialGetAllUserSuccessState extends SocialState {}

class SocialGetAllUserErrorState extends SocialState {
  final String error;

  SocialGetAllUserErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialState {}

class SocialLikePostErrorState extends SocialState {
  final String error;

  SocialLikePostErrorState(this.error);
}

class SocialCommintPostSuccessState extends SocialState {}

class SocialCommintPostErrorState extends SocialState {
  final String error;

  SocialCommintPostErrorState(this.error);
}

class SocialSendMessageSuccessState extends SocialState {}

class SocialSendMessageErrorState extends SocialState {
  final String error;

  SocialSendMessageErrorState(this.error);
}

class SocialGetMessagesSuccessState extends SocialState {}

class SocialGetMessagesErrorState extends SocialState {
  final String error;

  SocialGetMessagesErrorState(this.error);
}
