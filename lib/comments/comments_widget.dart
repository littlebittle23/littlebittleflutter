import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/post_options_widget.dart';
import '/components/send_post_widget.dart';
import '/components/story_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'comments_model.dart';
export 'comments_model.dart';

class CommentsWidget extends StatefulWidget {
  const CommentsWidget({
    Key? key,
    this.post,
  }) : super(key: key);

  final DocumentReference? post;

  @override
  _CommentsWidgetState createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget>
    with TickerProviderStateMixin {
  late CommentsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'iconOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ScaleEffect(
          curve: Curves.elasticOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.2, 0.2),
          end: Offset(1.0, 1.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommentsModel());

    _model.commentController ??= TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          iconTheme:
              IconThemeData(color: FlutterFlowTheme.of(context).primaryText),
          automaticallyImplyLeading: false,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.pop();
            },
            child: Icon(
              FFIcons.karrowLeft,
              color: Colors.black,
              size: 24.0,
            ),
          ),
          title: Text(
            'Comments',
            style: FlutterFlowTheme.of(context).headlineSmall.override(
                  fontFamily: FlutterFlowTheme.of(context).headlineSmallFamily,
                  color: Color(0xFF030055),
                  fontSize: 16.0,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).headlineSmallFamily),
                ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
              child: FutureBuilder<PostsRecord>(
                future: PostsRecord.getDocumentOnce(widget.post!),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 12.0,
                        height: 12.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                  final stackPostsRecord = snapshot.data!;
                  return Stack(
                    children: [
                      if (stackPostsRecord.postUser != currentUserReference)
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                barrierColor: Color(0x00000000),
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () => FocusScope.of(context)
                                        .requestFocus(_model.unfocusNode),
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: SendPostWidget(
                                        post: widget.post,
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => setState(() {}));
                            },
                            child: Icon(
                              FFIcons.kshare,
                              color: Colors.black,
                              size: 24.0,
                            ),
                          ),
                        ),
                      if (stackPostsRecord.postUser == currentUserReference)
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                barrierColor: Color(0x00000000),
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () => FocusScope.of(context)
                                        .requestFocus(_model.unfocusNode),
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: PostOptionsWidget(
                                        post: stackPostsRecord,
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => setState(() {}));
                            },
                            child: Icon(
                              FFIcons.kmore,
                              color: Colors.black,
                              size: 24.0,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: StreamBuilder<PostsRecord>(
            stream: PostsRecord.getDocument(widget.post!),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 12.0,
                    height: 12.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                );
              }
              final columnPostsRecord = snapshot.data!;
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    decoration: BoxDecoration(
                      color: Color(0xFFDADADA),
                    ),
                  ),
                  if (!columnPostsRecord.deleted)
                    Expanded(
                      child: StreamBuilder<PostsRecord>(
                        stream: PostsRecord.getDocument(widget.post!),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 12.0,
                                height: 12.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }
                          final activeColumnPostsRecord = snapshot.data!;
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 0.0, 15.0, 12.0),
                                        child: FutureBuilder<UsersRecord>(
                                          future: UsersRecord.getDocumentOnce(
                                              activeColumnPostsRecord
                                                  .postUser!),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 12.0,
                                                  height: 12.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            final rowUsersRecord =
                                                snapshot.data!;
                                            return Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 12.0, 0.0),
                                                  child: Stack(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    children: [
                                                      StreamBuilder<
                                                          List<StoriesRecord>>(
                                                        stream:
                                                            queryStoriesRecord(
                                                          queryBuilder: (storiesRecord) => storiesRecord
                                                              .where('user',
                                                                  isEqualTo:
                                                                      rowUsersRecord
                                                                          .reference)
                                                              .where(
                                                                  'expire_time',
                                                                  isGreaterThan:
                                                                      getCurrentTimestamp),
                                                          singleRecord: true,
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 12.0,
                                                                height: 12.0,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  valueColor:
                                                                      AlwaysStoppedAnimation<
                                                                          Color>(
                                                                    Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<StoriesRecord>
                                                              containerStoriesRecordList =
                                                              snapshot.data!;
                                                          // Return an empty Container when the item does not exist.
                                                          if (snapshot
                                                              .data!.isEmpty) {
                                                            return Container();
                                                          }
                                                          final containerStoriesRecord =
                                                              containerStoriesRecordList
                                                                      .isNotEmpty
                                                                  ? containerStoriesRecordList
                                                                      .first
                                                                  : null;
                                                          return InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                barrierColor: Color(
                                                                    0x00000000),
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return GestureDetector(
                                                                    onTap: () => FocusScope.of(
                                                                            context)
                                                                        .requestFocus(
                                                                            _model.unfocusNode),
                                                                    child:
                                                                        Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          StoryWidget(
                                                                        story:
                                                                            containerStoriesRecord,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  setState(
                                                                      () {}));
                                                            },
                                                            child: Container(
                                                              width: 40.0,
                                                              height: 40.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Color(
                                                                        0xFF1E4C7C),
                                                                    Color(
                                                                        0xFF004C8B),
                                                                    Color(
                                                                        0xFFA594F9)
                                                                  ],
                                                                  stops: [
                                                                    0.0,
                                                                    0.5,
                                                                    1.0
                                                                  ],
                                                                  begin:
                                                                      AlignmentDirectional(
                                                                          1.0,
                                                                          -1.0),
                                                                  end:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          1.0),
                                                                ),
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            if (rowUsersRecord
                                                                    .reference ==
                                                                currentUserReference) {
                                                              context.pushNamed(
                                                                  'Profile');
                                                            } else {
                                                              context.pushNamed(
                                                                'ProfileOther',
                                                                queryParameters:
                                                                    {
                                                                  'username':
                                                                      serializeParam(
                                                                    rowUsersRecord
                                                                        .username,
                                                                    ParamType
                                                                        .String,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            }
                                                          },
                                                          child: Container(
                                                            width: 37.0,
                                                            height: 37.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: Image
                                                                    .network(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    rowUsersRecord
                                                                        .photoUrl,
                                                                    'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                                                  ),
                                                                ).image,
                                                              ),
                                                              shape: BoxShape
                                                                  .circle,
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                width: 2.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          if (rowUsersRecord
                                                                  .reference ==
                                                              currentUserReference) {
                                                            context.pushNamed(
                                                                'Profile');
                                                          } else {
                                                            context.pushNamed(
                                                              'ProfileOther',
                                                              queryParameters: {
                                                                'username':
                                                                    serializeParam(
                                                                  rowUsersRecord
                                                                      .username,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          }
                                                        },
                                                        child: custom_widgets
                                                            .PhotoCaption(
                                                          width:
                                                              double.infinity,
                                                          height: 17.0,
                                                          name: valueOrDefault<
                                                              String>(
                                                            rowUsersRecord
                                                                .username,
                                                            'user',
                                                          ),
                                                          caption:
                                                              activeColumnPostsRecord
                                                                  .postCaption,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    6.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          dateTimeFormat(
                                                            'relative',
                                                            activeColumnPostsRecord
                                                                .timePosted!,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmallFamily,
                                                                fontSize: 11.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodySmallFamily),
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 0.5,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFDADADA),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                StreamBuilder<List<CommentsRecord>>(
                                  stream: queryCommentsRecord(
                                    parent: widget.post,
                                    queryBuilder: (commentsRecord) =>
                                        commentsRecord.orderBy('time_posted'),
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 12.0,
                                          height: 12.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<CommentsRecord>
                                        listViewCommentsRecordList =
                                        snapshot.data!;
                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          listViewCommentsRecordList.length,
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewCommentsRecord =
                                            listViewCommentsRecordList[
                                                listViewIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 16.0, 15.0, 16.0),
                                          child: FutureBuilder<UsersRecord>(
                                            future: UsersRecord.getDocumentOnce(
                                                listViewCommentsRecord
                                                    .postUser!),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 12.0,
                                                    height: 12.0,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              final rowUsersRecord =
                                                  snapshot.data!;
                                              return Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                12.0, 0.0),
                                                    child: Stack(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      children: [
                                                        StreamBuilder<
                                                            List<
                                                                StoriesRecord>>(
                                                          stream:
                                                              queryStoriesRecord(
                                                            queryBuilder: (storiesRecord) => storiesRecord
                                                                .where('user',
                                                                    isEqualTo:
                                                                        rowUsersRecord
                                                                            .reference)
                                                                .where(
                                                                    'expire_time',
                                                                    isGreaterThan:
                                                                        getCurrentTimestamp),
                                                            singleRecord: true,
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 12.0,
                                                                  height: 12.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    valueColor:
                                                                        AlwaysStoppedAnimation<
                                                                            Color>(
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            List<StoriesRecord>
                                                                containerStoriesRecordList =
                                                                snapshot.data!;
                                                            // Return an empty Container when the item does not exist.
                                                            if (snapshot.data!
                                                                .isEmpty) {
                                                              return Container();
                                                            }
                                                            final containerStoriesRecord =
                                                                containerStoriesRecordList
                                                                        .isNotEmpty
                                                                    ? containerStoriesRecordList
                                                                        .first
                                                                    : null;
                                                            return InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  barrierColor:
                                                                      Color(
                                                                          0x00000000),
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return GestureDetector(
                                                                      onTap: () => FocusScope.of(
                                                                              context)
                                                                          .requestFocus(
                                                                              _model.unfocusNode),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            StoryWidget(
                                                                          story:
                                                                              containerStoriesRecord,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    setState(
                                                                        () {}));
                                                              },
                                                              child: Container(
                                                                width: 40.0,
                                                                height: 40.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      Color(
                                                                          0xFF1E4C7C),
                                                                      Color(
                                                                          0xFF004C8B),
                                                                      Color(
                                                                          0xFFA594F9)
                                                                    ],
                                                                    stops: [
                                                                      0.0,
                                                                      0.5,
                                                                      1.0
                                                                    ],
                                                                    begin:
                                                                        AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                    end: AlignmentDirectional(
                                                                        -1.0,
                                                                        1.0),
                                                                  ),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              if (rowUsersRecord
                                                                      .reference ==
                                                                  currentUserReference) {
                                                                context.pushNamed(
                                                                    'Profile');
                                                              } else {
                                                                context
                                                                    .pushNamed(
                                                                  'ProfileOther',
                                                                  queryParameters:
                                                                      {
                                                                    'username':
                                                                        serializeParam(
                                                                      rowUsersRecord
                                                                          .username,
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 37.0,
                                                              height: 37.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: Image
                                                                      .network(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      rowUsersRecord
                                                                          .photoUrl,
                                                                      'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                                                    ),
                                                                  ).image,
                                                                ),
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  width: 2.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                if (rowUsersRecord
                                                                        .reference ==
                                                                    currentUserReference) {
                                                                  context.pushNamed(
                                                                      'Profile');
                                                                } else {
                                                                  context
                                                                      .pushNamed(
                                                                    'ProfileOther',
                                                                    queryParameters:
                                                                        {
                                                                      'username':
                                                                          serializeParam(
                                                                        rowUsersRecord
                                                                            .username,
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                    }.withoutNulls,
                                                                  );
                                                                }
                                                              },
                                                              child: custom_widgets
                                                                  .PhotoCaption(
                                                                width: double
                                                                    .infinity,
                                                                height: 17.0,
                                                                name:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  rowUsersRecord
                                                                      .username,
                                                                  'user',
                                                                ),
                                                                caption:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  listViewCommentsRecord
                                                                      .comment,
                                                                  'No comment',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      6.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Text(
                                                                dateTimeFormat(
                                                                  'relative',
                                                                  listViewCommentsRecord
                                                                      .timePosted!,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodySmallFamily,
                                                                      fontSize:
                                                                          11.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).bodySmallFamily),
                                                                    ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            18.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  '${valueOrDefault<String>(
                                                                    formatNumber(
                                                                      listViewCommentsRecord
                                                                          .likes
                                                                          .length,
                                                                      formatType:
                                                                          FormatType
                                                                              .compact,
                                                                    ),
                                                                    '0',
                                                                  )}${listViewCommentsRecord.likes.length == 1 ? ' like' : ' likes'}',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).bodySmallFamily,
                                                                        fontSize:
                                                                            11.5,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        useGoogleFonts:
                                                                            GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                      ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            18.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    await showModalBottomSheet(
                                                                      isScrollControlled:
                                                                          true,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      barrierColor:
                                                                          Color(
                                                                              0x00000000),
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return GestureDetector(
                                                                          onTap: () =>
                                                                              FocusScope.of(context).requestFocus(_model.unfocusNode),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                MediaQuery.viewInsetsOf(context),
                                                                            child:
                                                                                SendPostWidget(
                                                                              post: widget.post,
                                                                              comment: listViewCommentsRecord.reference,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        setState(
                                                                            () {}));
                                                                  },
                                                                  child: Text(
                                                                    'Send',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context).bodySmallFamily,
                                                                          fontSize:
                                                                              11.5,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              if ((listViewCommentsRecord
                                                                          .postUser ==
                                                                      currentUserReference) ||
                                                                  (activeColumnPostsRecord
                                                                          .postUser ==
                                                                      currentUserReference))
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          18.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      await listViewCommentsRecord
                                                                          .reference
                                                                          .delete();

                                                                      await activeColumnPostsRecord
                                                                          .reference
                                                                          .update({
                                                                        'num_comments':
                                                                            FieldValue.increment(-(1)),
                                                                      });
                                                                    },
                                                                    child: Text(
                                                                      'Delete',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).bodySmallFamily,
                                                                            fontSize:
                                                                                11.5,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            useGoogleFonts:
                                                                                GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Stack(
                                                    children: [
                                                      if (!listViewCommentsRecord
                                                          .likes
                                                          .contains(
                                                              currentUserReference))
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await listViewCommentsRecord
                                                                .reference
                                                                .update({
                                                              'likes': FieldValue
                                                                  .arrayUnion([
                                                                currentUserReference
                                                              ]),
                                                            });
                                                            HapticFeedback
                                                                .lightImpact();
                                                            if (activeColumnPostsRecord
                                                                    .postUser !=
                                                                currentUserReference) {
                                                              var notificationsRecordReference =
                                                                  NotificationsRecord
                                                                      .createDoc(
                                                                          rowUsersRecord
                                                                              .reference);
                                                              await notificationsRecordReference
                                                                  .set(
                                                                      createNotificationsRecordData(
                                                                notificationType:
                                                                    'Comment_Like',
                                                                userRef:
                                                                    currentUserReference,
                                                                postRef:
                                                                    widget.post,
                                                                timeCreated:
                                                                    getCurrentTimestamp,
                                                                commentRef:
                                                                    listViewCommentsRecord
                                                                        .reference,
                                                              ));
                                                              _model.notification =
                                                                  NotificationsRecord
                                                                      .getDocumentFromData(
                                                                          createNotificationsRecordData(
                                                                            notificationType:
                                                                                'Comment_Like',
                                                                            userRef:
                                                                                currentUserReference,
                                                                            postRef:
                                                                                widget.post,
                                                                            timeCreated:
                                                                                getCurrentTimestamp,
                                                                            commentRef:
                                                                                listViewCommentsRecord.reference,
                                                                          ),
                                                                          notificationsRecordReference);

                                                              await rowUsersRecord
                                                                  .reference
                                                                  .update({
                                                                'unreadNotifications':
                                                                    FieldValue
                                                                        .arrayUnion([
                                                                  _model
                                                                      .notification
                                                                      ?.reference
                                                                ]),
                                                              });
                                                            }

                                                            setState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .star_outline_outlined,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            size: 14.0,
                                                          ),
                                                        ),
                                                      if (listViewCommentsRecord
                                                          .likes
                                                          .contains(
                                                              currentUserReference))
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await listViewCommentsRecord
                                                                .reference
                                                                .update({
                                                              'likes': FieldValue
                                                                  .arrayRemove([
                                                                currentUserReference
                                                              ]),
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.star_outlined,
                                                            color: Color(
                                                                0xFF1E4C7C),
                                                            size: 14.0,
                                                          ),
                                                        ).animateOnPageLoad(
                                                            animationsMap[
                                                                'iconOnPageLoadAnimation']!),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  if (!columnPostsRecord.deleted)
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 0.5,
                          decoration: BoxDecoration(
                            color: Color(0xFFDADADA),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 16.0, 15.0, 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '🥳',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 28.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                              ),
                              Text(
                                '🤩',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 28.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                              ),
                              Text(
                                '🎉',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 28.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                              ),
                              Text(
                                '💯',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 28.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                              ),
                              Text(
                                '🔥',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 28.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                              ),
                              Text(
                                '🚀',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 28.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                              ),
                              Text(
                                '😂',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 28.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 15.0, 24.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 1.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Container(
                                    width: 45.0,
                                    height: 45.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        currentUserPhoto,
                                        'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 0.0, 0.0),
                                  child: Stack(
                                    alignment: AlignmentDirectional(1.0, 1.0),
                                    children: [
                                      AuthUserStreamWidget(
                                        builder: (context) => TextFormField(
                                          controller: _model.commentController,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium,
                                            hintText:
                                                'Add a comment as ${valueOrDefault(currentUserDocument?.username, '')}...',
                                            hintStyle: FlutterFlowTheme.of(
                                                    context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontWeight: FontWeight.normal,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFDADADA),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24.0),
                                            ),
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 16.0, 50.0, 16.0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily),
                                                lineHeight: 1.5,
                                              ),
                                          maxLines: 5,
                                          minLines: 1,
                                          validator: _model
                                              .commentControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 16.0, 17.0),
                                        child: FutureBuilder<PostsRecord>(
                                          future: PostsRecord.getDocumentOnce(
                                              widget.post!),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 12.0,
                                                  height: 12.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            final textPostsRecord =
                                                snapshot.data!;
                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                var commentsRecordReference =
                                                    CommentsRecord.createDoc(
                                                        widget.post!);
                                                await commentsRecordReference
                                                    .set({
                                                  ...createCommentsRecordData(
                                                    postUser:
                                                        currentUserReference,
                                                    timePosted:
                                                        getCurrentTimestamp,
                                                    comment: _model
                                                        .commentController.text,
                                                  ),
                                                  'likes':
                                                      FFAppState().emptyList,
                                                });
                                                _model.comment = CommentsRecord
                                                    .getDocumentFromData({
                                                  ...createCommentsRecordData(
                                                    postUser:
                                                        currentUserReference,
                                                    timePosted:
                                                        getCurrentTimestamp,
                                                    comment: _model
                                                        .commentController.text,
                                                  ),
                                                  'likes':
                                                      FFAppState().emptyList,
                                                }, commentsRecordReference);

                                                await widget.post!.update({
                                                  'num_comments':
                                                      FieldValue.increment(1),
                                                });
                                                setState(() {
                                                  _model.commentController
                                                      ?.clear();
                                                });
                                                if (columnPostsRecord
                                                        .postUser !=
                                                    currentUserReference) {
                                                  var notificationsRecordReference =
                                                      NotificationsRecord
                                                          .createDoc(
                                                              textPostsRecord
                                                                  .postUser!);
                                                  await notificationsRecordReference
                                                      .set(
                                                          createNotificationsRecordData(
                                                    notificationType:
                                                        'Post_Comment',
                                                    userRef:
                                                        currentUserReference,
                                                    postRef: widget.post,
                                                    timeCreated:
                                                        getCurrentTimestamp,
                                                    commentRef: _model
                                                        .comment?.reference,
                                                  ));
                                                  _model.notification1 =
                                                      NotificationsRecord
                                                          .getDocumentFromData(
                                                              createNotificationsRecordData(
                                                                notificationType:
                                                                    'Post_Comment',
                                                                userRef:
                                                                    currentUserReference,
                                                                postRef:
                                                                    widget.post,
                                                                timeCreated:
                                                                    getCurrentTimestamp,
                                                                commentRef: _model
                                                                    .comment
                                                                    ?.reference,
                                                              ),
                                                              notificationsRecordReference);

                                                  await textPostsRecord
                                                      .postUser!
                                                      .update({
                                                    'unreadNotifications':
                                                        FieldValue.arrayUnion([
                                                      _model.notification1
                                                          ?.reference
                                                    ]),
                                                  });
                                                }

                                                setState(() {});
                                              },
                                              child: Text(
                                                'Post',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily),
                                                        ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (columnPostsRecord.deleted)
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                48.0, 0.0, 48.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sorry, this post isn\'t\navailable.',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .displaySmallFamily,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .displaySmallFamily),
                                        lineHeight: 1.2,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 24.0, 0.0, 0.0),
                                  child: Text(
                                    'The link you followed may be broken, or the post may have been removed.',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily),
                                          lineHeight: 1.5,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 24.0, 0.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pop();
                                    },
                                    child: Text(
                                      'Go back.',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily),
                                            lineHeight: 1.5,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
