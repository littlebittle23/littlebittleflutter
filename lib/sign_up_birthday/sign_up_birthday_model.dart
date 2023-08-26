import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUpBirthdayModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for Body widget.
  ScrollController? body;
  DateTime? datePicked;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    body = ScrollController();
  }

  void dispose() {
    unfocusNode.dispose();
    body?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
