import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/post_widget.dart';
import '/components/story_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:async';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class FeedModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl1 = '';

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  // State field(s) for PostFeed widget.

  PagingController<DocumentSnapshot?, PostsRecord>? postFeedPagingController;
  Query? postFeedPagingQuery;
  List<StreamSubscription?> postFeedStreamSubscriptions = [];

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    postFeedStreamSubscriptions.forEach((s) => s?.cancel());
    postFeedPagingController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  PagingController<DocumentSnapshot?, PostsRecord> setPostFeedController(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    postFeedPagingController ??= _createPostFeedController(query, parent);
    if (postFeedPagingQuery != query) {
      postFeedPagingQuery = query;
      postFeedPagingController?.refresh();
    }
    return postFeedPagingController!;
  }

  PagingController<DocumentSnapshot?, PostsRecord> _createPostFeedController(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, PostsRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryPostsRecordPage(
          queryBuilder: (_) => postFeedPagingQuery ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: postFeedStreamSubscriptions,
          controller: controller,
          pageSize: 5,
          isStream: true,
        ),
      );
  }
}
