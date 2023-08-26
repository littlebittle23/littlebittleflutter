import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'tagged_users_component_model.dart';
export 'tagged_users_component_model.dart';

class TaggedUsersComponentWidget extends StatefulWidget {
  const TaggedUsersComponentWidget({
    Key? key,
    this.user,
  }) : super(key: key);

  final DocumentReference? user;

  @override
  _TaggedUsersComponentWidgetState createState() =>
      _TaggedUsersComponentWidgetState();
}

class _TaggedUsersComponentWidgetState
    extends State<TaggedUsersComponentWidget> {
  late TaggedUsersComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TaggedUsersComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
      child: StreamBuilder<UsersRecord>(
        stream: UsersRecord.getDocument(widget.user!),
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
          final rowUsersRecord = snapshot.data!;
          return InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              if (rowUsersRecord.reference == currentUserReference) {
                context.pushNamed('Profile');
              } else {
                context.pushNamed(
                  'ProfileOther',
                  queryParameters: {
                    'username': serializeParam(
                      rowUsersRecord.username,
                      ParamType.String,
                    ),
                  }.withoutNulls,
                );
              }
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
                      rowUsersRecord.photoUrl,
                      'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rowUsersRecord.displayName,
                          maxLines: 1,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                fontSize: 14.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 2.0, 0.0, 0.0),
                          child: Text(
                            rowUsersRecord.username,
                            maxLines: 1,
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodySmallFamily,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodySmallFamily),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 6.0, 0.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => StreamBuilder<List<FollowersRecord>>(
                      stream: queryFollowersRecord(
                        parent: rowUsersRecord.reference,
                        singleRecord: true,
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
                        List<FollowersRecord> containerFollowersRecordList =
                            snapshot.data!;
                        final containerFollowersRecord =
                            containerFollowersRecordList.isNotEmpty
                                ? containerFollowersRecordList.first
                                : null;
                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if ((currentUserDocument?.following?.toList() ?? [])
                                .contains(rowUsersRecord.reference)) {
                              await currentUserReference!.update({
                                'following': FieldValue.arrayRemove(
                                    [rowUsersRecord.reference]),
                              });

                              await containerFollowersRecord!.reference.update({
                                'userRefs': FieldValue.arrayRemove(
                                    [currentUserReference]),
                              });
                              _model.timerController.onExecute
                                  .add(StopWatchExecute.reset);
                            } else {
                              await currentUserReference!.update({
                                'following': FieldValue.arrayUnion(
                                    [rowUsersRecord.reference]),
                              });

                              await containerFollowersRecord!.reference.update({
                                'userRefs': FieldValue.arrayUnion(
                                    [currentUserReference]),
                              });
                              _model.timerController.onExecute
                                  .add(StopWatchExecute.start);
                            }
                          },
                          child: Container(
                            width: 110.0,
                            height: 35.0,
                            decoration: BoxDecoration(
                              color:
                                  (currentUserDocument?.following?.toList() ??
                                              [])
                                          .contains(rowUsersRecord.reference)
                                      ? Color(0xFFEFEFEF)
                                      : FlutterFlowTheme.of(context).secondary,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 6.0, 8.0, 6.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      () {
                                        if (rowUsersRecord.following.contains(
                                                currentUserReference) &&
                                            !(currentUserDocument?.following
                                                        ?.toList() ??
                                                    [])
                                                .contains(
                                                    rowUsersRecord.reference)) {
                                          return 'Follow back';
                                        } else if (!rowUsersRecord.following
                                                .contains(
                                                    currentUserReference) &&
                                            !(currentUserDocument?.following
                                                        ?.toList() ??
                                                    [])
                                                .contains(
                                                    rowUsersRecord.reference)) {
                                          return 'Follow';
                                        } else {
                                          return 'Unfollow';
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: (currentUserDocument
                                                            ?.following
                                                            ?.toList() ??
                                                        [])
                                                    .contains(rowUsersRecord
                                                        .reference)
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryText
                                                : Colors.white,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
                    var notificationsRecordReference =
                        NotificationsRecord.createDoc(rowUsersRecord.reference);
                    await notificationsRecordReference
                        .set(createNotificationsRecordData(
                      notificationType: 'Follow',
                      userRef: currentUserReference,
                      timeCreated: getCurrentTimestamp,
                    ));
                    _model.notification =
                        NotificationsRecord.getDocumentFromData(
                            createNotificationsRecordData(
                              notificationType: 'Follow',
                              userRef: currentUserReference,
                              timeCreated: getCurrentTimestamp,
                            ),
                            notificationsRecordReference);

                    await rowUsersRecord.reference.update({
                      'unreadNotifications': FieldValue.arrayUnion(
                          [_model.notification?.reference]),
                    });

                    setState(() {});
                  },
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        color: FlutterFlowTheme.of(context).primary,
                        fontSize: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyMediumFamily),
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
