import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:whatsevr_app/config/widgets/pad_horizontal.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      //instagram style create post
      body: ListView(
        padding: PadHorizontal.padding,
        children: [
          Gap(12),
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(Icons.video_collection_outlined),
            ),
          ),
          Gap(12),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Title',
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
            decoration: const InputDecoration(
              hintText: 'Description',
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
            decoration: const InputDecoration(
              hintText: 'Hashtags',
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
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child:
              const Text('Create Post', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
