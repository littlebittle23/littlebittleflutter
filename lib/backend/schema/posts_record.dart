import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PostsRecord extends FirestoreRecord {
  PostsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "post_photo" field.
  String? _postPhoto;
  String get postPhoto => _postPhoto ?? '';
  bool hasPostPhoto() => _postPhoto != null;

  // "post_user" field.
  DocumentReference? _postUser;
  DocumentReference? get postUser => _postUser;
  bool hasPostUser() => _postUser != null;

  // "time_posted" field.
  DateTime? _timePosted;
  DateTime? get timePosted => _timePosted;
  bool hasTimePosted() => _timePosted != null;

  // "likes" field.
  List<DocumentReference>? _likes;
  List<DocumentReference> get likes => _likes ?? const [];
  bool hasLikes() => _likes != null;

  // "num_comments" field.
  int? _numComments;
  int get numComments => _numComments ?? 0;
  bool hasNumComments() => _numComments != null;

  // "post_caption" field.
  String? _postCaption;
  String get postCaption => _postCaption ?? '';
  bool hasPostCaption() => _postCaption != null;

  // "allow_comments" field.
  bool? _allowComments;
  bool get allowComments => _allowComments ?? false;
  bool hasAllowComments() => _allowComments != null;

  // "allow_likes" field.
  bool? _allowLikes;
  bool get allowLikes => _allowLikes ?? false;
  bool hasAllowLikes() => _allowLikes != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  bool hasLocation() => _location != null;

  // "call_to_action_enabled" field.
  bool? _callToActionEnabled;
  bool get callToActionEnabled => _callToActionEnabled ?? false;
  bool hasCallToActionEnabled() => _callToActionEnabled != null;

  // "call_to_action_text" field.
  String? _callToActionText;
  String get callToActionText => _callToActionText ?? '';
  bool hasCallToActionText() => _callToActionText != null;

  // "call_to_action_link" field.
  String? _callToActionLink;
  String get callToActionLink => _callToActionLink ?? '';
  bool hasCallToActionLink() => _callToActionLink != null;

  // "tagged_users" field.
  List<DocumentReference>? _taggedUsers;
  List<DocumentReference> get taggedUsers => _taggedUsers ?? const [];
  bool hasTaggedUsers() => _taggedUsers != null;

  // "labels" field.
  String? _labels;
  String get labels => _labels ?? '';
  bool hasLabels() => _labels != null;

  // "deleted" field.
  bool? _deleted;
  bool get deleted => _deleted ?? false;
  bool hasDeleted() => _deleted != null;

  void _initializeFields() {
    _postPhoto = snapshotData['post_photo'] as String?;
    _postUser = snapshotData['post_user'] as DocumentReference?;
    _timePosted = snapshotData['time_posted'] as DateTime?;
    _likes = getDataList(snapshotData['likes']);
    _numComments = castToType<int>(snapshotData['num_comments']);
    _postCaption = snapshotData['post_caption'] as String?;
    _allowComments = snapshotData['allow_comments'] as bool?;
    _allowLikes = snapshotData['allow_likes'] as bool?;
    _location = snapshotData['location'] as String?;
    _callToActionEnabled = snapshotData['call_to_action_enabled'] as bool?;
    _callToActionText = snapshotData['call_to_action_text'] as String?;
    _callToActionLink = snapshotData['call_to_action_link'] as String?;
    _taggedUsers = getDataList(snapshotData['tagged_users']);
    _labels = snapshotData['labels'] as String?;
    _deleted = snapshotData['deleted'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('posts');

  static Stream<PostsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PostsRecord.fromSnapshot(s));

  static Future<PostsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PostsRecord.fromSnapshot(s));

  static PostsRecord fromSnapshot(DocumentSnapshot snapshot) => PostsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PostsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PostsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PostsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PostsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPostsRecordData({
  String? postPhoto,
  DocumentReference? postUser,
  DateTime? timePosted,
  int? numComments,
  String? postCaption,
  bool? allowComments,
  bool? allowLikes,
  String? location,
  bool? callToActionEnabled,
  String? callToActionText,
  String? callToActionLink,
  String? labels,
  bool? deleted,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'post_photo': postPhoto,
      'post_user': postUser,
      'time_posted': timePosted,
      'num_comments': numComments,
      'post_caption': postCaption,
      'allow_comments': allowComments,
      'allow_likes': allowLikes,
      'location': location,
      'call_to_action_enabled': callToActionEnabled,
      'call_to_action_text': callToActionText,
      'call_to_action_link': callToActionLink,
      'labels': labels,
      'deleted': deleted,
    }.withoutNulls,
  );

  return firestoreData;
}

class PostsRecordDocumentEquality implements Equality<PostsRecord> {
  const PostsRecordDocumentEquality();

  @override
  bool equals(PostsRecord? e1, PostsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.postPhoto == e2?.postPhoto &&
        e1?.postUser == e2?.postUser &&
        e1?.timePosted == e2?.timePosted &&
        listEquality.equals(e1?.likes, e2?.likes) &&
        e1?.numComments == e2?.numComments &&
        e1?.postCaption == e2?.postCaption &&
        e1?.allowComments == e2?.allowComments &&
        e1?.allowLikes == e2?.allowLikes &&
        e1?.location == e2?.location &&
        e1?.callToActionEnabled == e2?.callToActionEnabled &&
        e1?.callToActionText == e2?.callToActionText &&
        e1?.callToActionLink == e2?.callToActionLink &&
        listEquality.equals(e1?.taggedUsers, e2?.taggedUsers) &&
        e1?.labels == e2?.labels &&
        e1?.deleted == e2?.deleted;
  }

  @override
  int hash(PostsRecord? e) => const ListEquality().hash([
        e?.postPhoto,
        e?.postUser,
        e?.timePosted,
        e?.likes,
        e?.numComments,
        e?.postCaption,
        e?.allowComments,
        e?.allowLikes,
        e?.location,
        e?.callToActionEnabled,
        e?.callToActionText,
        e?.callToActionLink,
        e?.taggedUsers,
        e?.labels,
        e?.deleted
      ]);

  @override
  bool isValidKey(Object? o) => o is PostsRecord;
}
