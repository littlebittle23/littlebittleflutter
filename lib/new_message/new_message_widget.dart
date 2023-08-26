import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'new_message_model.dart';
export 'new_message_model.dart';

class NewMessageWidget extends StatefulWidget {
  const NewMessageWidget({Key? key}) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  late NewMessageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewMessageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().update(() {
        FFAppState().imageSearchDummyToggle = true;
      });
    });

    _model.searchInnputController ??= TextEditingController();
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
          title: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: StreamBuilder<List<UsersRecord>>(
                      stream: queryUsersRecord(),
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
                        List<UsersRecord> searchInnputUsersRecordList = snapshot
                            .data!
                            .where((u) => u.uid != currentUserUid)
                            .toList();
                        return Container(
                          width: 50.0,
                          child: TextFormField(
                            controller: _model.searchInnputController,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.searchInnputController',
                              Duration(milliseconds: 1000),
                              () async {
                                setState(() {
                                  _model.simpleSearchResults = TextSearch(
                                    searchInnputUsersRecordList
                                        .where((e) => (currentUserDocument
                                                    ?.following
                                                    ?.toList() ??
                                                [])
                                            .contains(e.reference))
                                        .toList()
                                        .map(
                                          (record) => TextSearchItem(record, [
                                            record.displayName!,
                                            record.username!
                                          ]),
                                        )
                                        .toList(),
                                  )
                                      .search(valueOrDefault<String>(
                                        _model.searchInnputController.text,
                                        'a',
                                      ))
                                      .map((r) => r.object)
                                      .take(15)
                                      .toList();
                                  ;
                                });
                              },
                            ),
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodySmallFamily,
                                    color: Color(0xFF7371FC),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodySmallFamily),
                                    lineHeight: 1.5,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF030055),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              filled: true,
                              fillColor: Color(0xFFE5D9F2),
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              prefixIcon: Icon(
                                FFIcons.ksearch,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 16.0,
                              ),
                              suffixIcon: _model
                                      .searchInnputController!.text.isNotEmpty
                                  ? InkWell(
                                      onTap: () async {
                                        _model.searchInnputController?.clear();
                                        setState(() {
                                          _model
                                              .simpleSearchResults = TextSearch(
                                            searchInnputUsersRecordList
                                                .where((e) =>
                                                    (currentUserDocument
                                                                ?.following
                                                                ?.toList() ??
                                                            [])
                                                        .contains(e.reference))
                                                .toList()
                                                .map(
                                                  (record) => TextSearchItem(
                                                      record, [
                                                    record.displayName!,
                                                    record.username!
                                                  ]),
                                                )
                                                .toList(),
                                          )
                                              .search(valueOrDefault<String>(
                                                _model.searchInnputController
                                                    .text,
                                                'a',
                                              ))
                                              .map((r) => r.object)
                                              .take(15)
                                              .toList();
                                          ;
                                        });
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        color: Color(0xFF7371FC),
                                        size: 18.0,
                                      ),
                                    )
                                  : null,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                            validator: _model.searchInnputControllerValidator
                                .asValidator(context),
                          ),
                        );
                      },
                    ),
                  ),
                  FlutterFlowTimer(
                    initialTime: _model.timerMilliseconds,
                    getDisplayTime: (value) => StopWatchTimer.getDisplayTime(
                      value,
                      hours: false,
                      minute: false,
                      milliSecond: false,
                    ),
                    timer: _model.timerController,
                    onChanged: (value, displayTime, shouldUpdate) {
                      _model.timerMilliseconds = value;
                      _model.timerValue = displayTime;
                      if (shouldUpdate) setState(() {});
                    },
                    onEnded: () async {
                      await FFAppState().tempUserRecord!.update({
                        'chats': FieldValue.arrayUnion([currentUserReference]),
                      });
                    },
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: FlutterFlowTheme.of(context).primary,
                          fontSize: 1.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
                        ),
                  ),
                ],
              ),
            ],
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (_model.searchInnputController.text != null &&
                    _model.searchInnputController.text != '')
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                      child: AuthUserStreamWidget(
                        builder: (context) => Builder(
                          builder: (context) {
                            final searchUsers = _model.simpleSearchResults
                                .where((e) =>
                                    !(currentUserDocument?.chats?.toList() ??
                                            [])
                                        .contains(e.reference))
                                .toList();
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(searchUsers.length,
                                  (searchUsersIndex) {
                                final searchUsersItem =
                                    searchUsers[searchUsersIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      FFAppState().update(() {
                                        FFAppState().tempUserList = [];
                                        FFAppState().addToTempUserList(
                                            currentUserReference!);
                                      });
                                      FFAppState().update(() {
                                        FFAppState().addToTempUserList(
                                            searchUsersItem.reference);
                                        FFAppState().tempUserRecord =
                                            searchUsersItem.reference;
                                      });

                                      var chatsRecordReference =
                                          ChatsRecord.collection.doc();
                                      await chatsRecordReference.set({
                                        ...createChatsRecordData(
                                          userA: currentUserReference,
                                          userB: searchUsersItem.reference,
                                          lastMessage: 'Hey! Let\'s chat!',
                                          lastMessageTime: getCurrentTimestamp,
                                          lastMessageSentBy:
                                              currentUserReference,
                                        ),
                                        'last_message_seen_by': [
                                          currentUserReference
                                        ],
                                        'users': FFAppState().tempUserList,
                                      });
                                      _model.chat =
                                          ChatsRecord.getDocumentFromData({
                                        ...createChatsRecordData(
                                          userA: currentUserReference,
                                          userB: searchUsersItem.reference,
                                          lastMessage: 'Hey! Let\'s chat!',
                                          lastMessageTime: getCurrentTimestamp,
                                          lastMessageSentBy:
                                              currentUserReference,
                                        ),
                                        'last_message_seen_by': [
                                          currentUserReference
                                        ],
                                        'users': FFAppState().tempUserList,
                                      }, chatsRecordReference);
                                      _model.timerController.onExecute
                                          .add(StopWatchExecute.start);

                                      await currentUserReference!.update({
                                        'chats': FieldValue.arrayUnion(
                                            [searchUsersItem.reference]),
                                      });

                                      context.pushNamed(
                                        'IndividualMessage',
                                        queryParameters: {
                                          'chat': serializeParam(
                                            _model.chat?.reference,
                                            ParamType.DocumentReference,
                                          ),
                                        }.withoutNulls,
                                      );

                                      setState(() {});
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 55.0,
                                          height: 55.0,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            valueOrDefault<String>(
                                              searchUsersItem.photoUrl,
                                              'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 0.0, 0.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  valueOrDefault<String>(
                                                    searchUsersItem.displayName,
                                                    'user',
                                                  ),
                                                  maxLines: 1,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        color:
                                                            Color(0xFF030055),
                                                        fontSize: 14.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 2.0, 0.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      searchUsersItem.username,
                                                      'username',
                                                    ),
                                                    maxLines: 1,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmallFamily,
                                                          color:
                                                              Color(0xFF7371FC),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily),
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_right_alt,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 20.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                if (_model.searchInnputController.text == null ||
                    _model.searchInnputController.text == '')
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                      child: AuthUserStreamWidget(
                        builder: (context) =>
                            StreamBuilder<List<RecentSearchesRecord>>(
                          stream: queryRecentSearchesRecord(
                            parent: currentUserReference,
                            queryBuilder: (recentSearchesRecord) =>
                                recentSearchesRecord
                                    .whereIn(
                                        'userRef',
                                        (currentUserDocument?.following
                                                ?.toList() ??
                                            []))
                                    .orderBy('time_searched', descending: true),
                          ),
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
                            List<RecentSearchesRecord>
                                recentSearchesRecentSearchesRecordList =
                                snapshot.data!;
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(
                                  recentSearchesRecentSearchesRecordList.length,
                                  (recentSearchesIndex) {
                                final recentSearchesRecentSearchesRecord =
                                    recentSearchesRecentSearchesRecordList[
                                        recentSearchesIndex];
                                return Visibility(
                                  visible:
                                      !(currentUserDocument?.chats?.toList() ??
                                              [])
                                          .contains(
                                              recentSearchesRecentSearchesRecord
                                                  .userRef),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 12.0, 0.0, 0.0),
                                    child: StreamBuilder<UsersRecord>(
                                      stream: UsersRecord.getDocument(
                                          recentSearchesRecentSearchesRecord
                                              .userRef!),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 12.0,
                                              height: 12.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        final profileDetailsUsersRecord =
                                            snapshot.data!;
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            FFAppState().update(() {
                                              FFAppState().tempUserList = [];
                                              FFAppState().addToTempUserList(
                                                  currentUserReference!);
                                            });
                                            FFAppState().update(() {
                                              FFAppState().addToTempUserList(
                                                  profileDetailsUsersRecord
                                                      .reference);
                                              FFAppState().tempUserRecord =
                                                  profileDetailsUsersRecord
                                                      .reference;
                                            });

                                            var chatsRecordReference =
                                                ChatsRecord.collection.doc();
                                            await chatsRecordReference.set({
                                              ...createChatsRecordData(
                                                userA: currentUserReference,
                                                userB: profileDetailsUsersRecord
                                                    .reference,
                                                lastMessage:
                                                    'Hey! Let\'s chat!',
                                                lastMessageTime:
                                                    getCurrentTimestamp,
                                                lastMessageSentBy:
                                                    currentUserReference,
                                              ),
                                              'last_message_seen_by': [
                                                currentUserReference
                                              ],
                                              'users':
                                                  FFAppState().tempUserList,
                                            });
                                            _model.chat1 = ChatsRecord
                                                .getDocumentFromData({
                                              ...createChatsRecordData(
                                                userA: currentUserReference,
                                                userB: profileDetailsUsersRecord
                                                    .reference,
                                                lastMessage:
                                                    'Hey! Let\'s chat!',
                                                lastMessageTime:
                                                    getCurrentTimestamp,
                                                lastMessageSentBy:
                                                    currentUserReference,
                                              ),
                                              'last_message_seen_by': [
                                                currentUserReference
                                              ],
                                              'users':
                                                  FFAppState().tempUserList,
                                            }, chatsRecordReference);

                                            await currentUserReference!.update({
                                              'chats': FieldValue.arrayUnion([
                                                profileDetailsUsersRecord
                                                    .reference
                                              ]),
                                            });
                                            _model.timerController.onExecute
                                                .add(StopWatchExecute.start);

                                            context.pushNamed(
                                              'IndividualMessage',
                                              queryParameters: {
                                                'chat': serializeParam(
                                                  _model.chat1?.reference,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                            );

                                            setState(() {});
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 55.0,
                                                height: 55.0,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Image.network(
                                                  valueOrDefault<String>(
                                                    profileDetailsUsersRecord
                                                        .photoUrl,
                                                    'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        profileDetailsUsersRecord
                                                            .displayName,
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: Color(
                                                                      0xFF030055),
                                                                  fontSize:
                                                                      14.0,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily),
                                                                ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    2.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          profileDetailsUsersRecord
                                                              .username,
                                                          maxLines: 1,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmallFamily,
                                                                color: Color(
                                                                    0xFF7371FC),
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
                                              ),
                                              Icon(
                                                Icons.arrow_right_alt,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 20.0,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
