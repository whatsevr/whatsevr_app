abstract class LongRunningTask {
  final String taskTitle;
  final String taskDescription;
  final String taskType; // Identifies the type of task (photo, video, etc.)

  LongRunningTask({
    required this.taskTitle,
    required this.taskDescription,
    required this.taskType,
  });

  Map<String, dynamic> toMap();

  // Factory method to create the appropriate PostTaskData subtype from a map.
  static LongRunningTask fromMap(Map<String, dynamic> map) {
    switch (map['task-type']) {
      case 'new-video-post-task':
        return VideoPostTaskDataForLRT.fromMap(map);

      default:
        throw Exception('Unknown task, type: ${map['task-type']}');
    }
  }
}

class VideoPostTaskDataForLRT extends LongRunningTask {
  final String? title;
  final String? description;
  final String? userUid;
  final String? videoFilePath;
  final String? thumbnailFilePath;
  final List<String>? hashtags;
  final String? location;

  final String? postCreatorType;
  final String? addressLatLongWkb;
  final String? creatorLatLongWkb;
  final List<String>? taggedUserUids;
  final List<String>? taggedCommunityUids;
  final int? videoDurationInSec;
  final String? communityUid;

  VideoPostTaskDataForLRT({
    this.title,
    this.description,
    required this.userUid,
    required this.videoFilePath,
    required this.thumbnailFilePath,
    this.hashtags,
    this.location,
    this.postCreatorType,
    this.addressLatLongWkb,
    this.creatorLatLongWkb,
    this.taggedUserUids,
    this.taggedCommunityUids,
    this.videoDurationInSec,
    this.communityUid,
  }) : super(
          taskTitle: 'New Video Post: $title',
          taskDescription: 'Creating post please wait...',
          taskType: 'new-video-post-task',
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'task-type': taskType,
      'userUid': userUid,
      'title': title,
      'description': description,
      'videoFilePath': videoFilePath,
      'thumbnailFilePath': thumbnailFilePath,
      'hashtags': hashtags,
      'location': location,
      'postCreatorType': postCreatorType,
      'addressLatLongWkb': addressLatLongWkb,
      'creatorLatLongWkb': creatorLatLongWkb,
      'taggedUserUids': taggedUserUids,
      'taggedCommunityUids': taggedCommunityUids,
      'videoDurationInSec': videoDurationInSec,
      'communityUid': communityUid,
    };
  }

  factory VideoPostTaskDataForLRT.fromMap(Map<String, dynamic> map) {
    return VideoPostTaskDataForLRT(
      userUid: map['userUid'],
      title: map['title'],
      description: map['description'],
      videoFilePath: map['videoFilePath'],
      thumbnailFilePath: map['thumbnailFilePath'],
      hashtags: map['hashtags']?.cast<String>(),
      location: map['location'],
      taggedCommunityUids: map['taggedCommunityUids']?.cast<String>(),
      addressLatLongWkb: map['addressLatLongWkb'],
      creatorLatLongWkb: map['creatorLatLongWkb'],
      postCreatorType: map['postCreatorType'],
      taggedUserUids: map['taggedUserUids']?.cast<String>(),
      videoDurationInSec: map['videoDurationInSec'],
      communityUid: map['communityUid'],
    );
  }
}
