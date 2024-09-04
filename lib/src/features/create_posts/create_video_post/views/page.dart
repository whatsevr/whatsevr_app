import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:whatsevr_app/config/enums/post_creator_type.dart';

import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/src/features/create_posts/create_video_post/bloc/create_post_bloc.dart';

class CreateVideoPostPageArgument {
  final EnumPostCreatorType postCreatorType;
  const CreateVideoPostPageArgument({required this.postCreatorType});
}

class CreateVideoPost extends StatelessWidget {
  final CreateVideoPostPageArgument pageArgument;
  const CreateVideoPost({super.key, required this.pageArgument});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context) => CreateVideoPostBloc()
        ..add(CreatePostInitialEvent(pageArgument: pageArgument)),
      child: Builder(
        builder: (BuildContext context) {
          return buildPage(context);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    return BlocBuilder<CreateVideoPostBloc, CreateVideoPostState>(
      builder: (BuildContext context, CreateVideoPostState state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Create ${pageArgument.postCreatorType.value} post'),
          ),
          body: ListView(
            padding: PadHorizontal.padding,
            children: <Widget>[
              Gap(12),
              Column(
                children: [
                  Builder(
                    builder: (BuildContext context) {
                      if (state.thumbnailFile != null) {
                        return Stack(
                          children: <Widget>[
                            ExtendedImage.file(
                              state.thumbnailFile!,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            Positioned.fill(
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    AppNavigationService.newRoute(
                                      RoutesName.fullVideoPlayer,
                                      extras: <String>[state.videoFile!.path],
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.play_circle_fill_rounded,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      if (state.videoFile != null) {
                        return MaterialButton(
                          onPressed: () {
                            context
                                .read<CreateVideoPostBloc>()
                                .add(const PickThumbnailEvent());
                          },
                          minWidth: double.infinity,
                          height: 200,
                          color: Colors.black12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }
                      return MaterialButton(
                        onPressed: () {
                          context
                              .read<CreateVideoPostBloc>()
                              .add(const PickVideoEvent());
                        },
                        minWidth: double.infinity,
                        height: 200,
                        color: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Icon(Icons.video_file_rounded),
                            Text('Add a video'),
                          ],
                        ),
                      );
                    },
                  ),
                  if (state.videoFile != null || state.thumbnailFile != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (state.videoFile != null &&
                            state.thumbnailFile != null)
                          MaterialButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                context
                                    .read<CreateVideoPostBloc>()
                                    .add(const PickThumbnailEvent());
                              },
                              child: Text('Update Thumbnail',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 12))),
                        if (state.videoFile != null)
                          MaterialButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                context
                                    .read<CreateVideoPostBloc>()
                                    .add(const PickVideoEvent());
                              },
                              child: Text('Update Video',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 12))),
                      ],
                    ),
                ],
              ),
              TextField(
                maxLength: 100,
                controller: context.read<CreateVideoPostBloc>().titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  helperStyle: TextStyle(fontSize: 10),
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Gap(12),
              TextField(
                maxLength: 5000,
                minLines: 3,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  filled: true,
                  helperStyle: TextStyle(fontSize: 10),
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Gap(12),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Hashtags',
                  filled: true,
                  helperText: 'Max 30 hashtags',
                  helperStyle: TextStyle(fontSize: 10),
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Gap(12),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Location',
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Icon(Icons.location_on),
                ),
              ),
              Gap(12),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: MaterialButton(
              color: Colors.blue,
              onPressed: () {
                context
                    .read<CreateVideoPostBloc>()
                    .add(const SubmitPostEvent());
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Create Post',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
