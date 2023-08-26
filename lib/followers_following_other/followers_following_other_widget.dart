import '/backend/backend.dart';
import '/components/follower_componant_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'followers_following_other_model.dart';
export 'followers_following_other_model.dart';

class FollowersFollowingOtherWidget extends StatefulWidget {
  const FollowersFollowingOtherWidget({
    Key? key,
    this.userRef,
  }) : super(key: key);

  final DocumentReference? userRef;

  @override
  _FollowersFollowingOtherWidgetState createState() =>
      _FollowersFollowingOtherWidgetState();
}

class _FollowersFollowingOtherWidgetState
    extends State<FollowersFollowingOtherWidget> with TickerProviderStateMixin {
  late FollowersFollowingOtherModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FollowersFollowingOtherModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
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
          title: StreamBuilder<UsersRecord>(
            stream: UsersRecord.getDocument(widget.userRef!),
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
              final textUsersRecord = snapshot.data!;
              return Text(
                valueOrDefault<String>(
                  textUsersRecord.username,
                  'user',
                ),
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).titleMediumFamily,
                      color: Color(0xFF030055),
                      fontSize: 16.0,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleMediumFamily),
                    ),
              );
            },
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: StreamBuilder<UsersRecord>(
            stream: UsersRecord.getDocument(widget.userRef!),
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
              final containerUsersRecord = snapshot.data!;
              return Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 1.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: StreamBuilder<List<FollowersRecord>>(
                  stream: queryFollowersRecord(
                    parent: widget.userRef,
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
                    List<FollowersRecord> tabBarFollowersRecordList =
                        snapshot.data!;
                    final tabBarFollowersRecord =
                        tabBarFollowersRecordList.isNotEmpty
                            ? tabBarFollowersRecordList.first
                            : null;
                    return Column(
                      children: [
                        Align(
                          alignment: Alignment(0.0, 0),
                          child: TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Color(0x80000000),
                            labelStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  fontSize: 15.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                            unselectedLabelStyle: TextStyle(),
                            indicatorColor: Colors.black,
                            indicatorWeight: 2.0,
                            tabs: [
                              Tab(
                                text: valueOrDefault<String>(
                                  '${formatNumber(
                                    tabBarFollowersRecord?.userRefs?.length,
                                    formatType: FormatType.compact,
                                  )} Fans 👑',
                                  '0 Followers',
                                ),
                              ),
                              Tab(
                                text: valueOrDefault<String>(
                                  '${valueOrDefault<String>(
                                    formatNumber(
                                      containerUsersRecord.following.length,
                                      formatType: FormatType.compact,
                                    ),
                                    '0',
                                  )} Favourites 🫂',
                                  '0 Followers',
                                ),
                              ),
                            ],
                            controller: _model.tabBarController,
                            onTap: (value) => setState(() {}),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _model.tabBarController,
                            children: [
                              KeepAliveWidgetWrapper(
                                builder: (context) => Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 15.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      final followers = tabBarFollowersRecord
                                              ?.userRefs
                                              ?.toList() ??
                                          [];
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: followers.length,
                                        itemBuilder: (context, followersIndex) {
                                          final followersItem =
                                              followers[followersIndex];
                                          return FollowerComponantWidget(
                                            key: Key(
                                                'Keyt0b_${followersIndex}_of_${followers.length}'),
                                            users: followersItem,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              KeepAliveWidgetWrapper(
                                builder: (context) => Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 15.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      final following = containerUsersRecord
                                          .following
                                          .toList();
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: following.length,
                                        itemBuilder: (context, followingIndex) {
                                          final followingItem =
                                              following[followingIndex];
                                          return FollowerComponantWidget(
                                            key: Key(
                                                'Key2ku_${followingIndex}_of_${following.length}'),
                                            users: followingItem,
                                          );
                                        },
                                      );
                                    },
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
              );
            },
          ),
        ),
      ),
    );
  }
}
