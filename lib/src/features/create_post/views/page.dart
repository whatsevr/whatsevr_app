import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

import '../../../../config/routes/router.dart';
import '../../../../config/routes/routes_name.dart';
import '../bloc/create_post_bloc.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) =>
          CreatePostBloc()..add(const CreatePostInitialEvent()),
      child: Builder(
        builder: (context) {
          return buildPage(context);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    return BlocBuilder<CreatePostBloc, CreatePostState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
          ),
          body: ListView(
            padding: PadHorizontal.padding,
            children: [
              Gap(12),
              Builder(
                builder: (context) {
                  if (state.thumbnailFile != null) {
                    return Stack(
                      children: [
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
                            .read<CreatePostBloc>()
                            .add(const PickThumbnailEvent());
                      },
                      minWidth: double.infinity,
                      height: 200,
                      color: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.photo_size_select_large_rounded),
                          Text('Add a thumbnail'),
                        ],
                      ),
                    );
                  }
                  return MaterialButton(
                    onPressed: () {
                      context
                          .read<CreatePostBloc>()
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
                      children: const [
                        Icon(Icons.video_file_rounded),
                        Text('Add a video'),
                      ],
                    ),
                  );
                },
              ),
              Gap(12),
              TextField(
                maxLength: 100,
                controller: context.read<CreatePostBloc>().titleController,
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
                context.read<CreatePostBloc>().add(const SubmitPostEvent());
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('Create Post',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        );
      },
    );
  }
}
