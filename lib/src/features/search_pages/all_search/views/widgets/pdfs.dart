part of 'package:whatsevr_app/src/features/search_pages/all_search/views/page.dart';

class _PdfsView extends StatelessWidget {
  _PdfsView();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    onReachingEndOfTheList(_scrollController, execute: () {
      context.read<AllSearchBloc>().add(SearchMorePdfs());
    },);
    return BlocBuilder<AllSearchBloc, AllSearchState>(
      builder: (context, state) {
        return ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: state.searchedPdfs?.pdfs?.length ?? 0,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            final pdf = state.searchedPdfs?.pdfs?[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: ExtendedImage.network(
                    pdf?.thumbnailUrl ?? MockData.imagePlaceholder('Thumbnail'),
                    width: double.infinity,
                    fit: BoxFit.contain,
                    enableLoadState: false,
                  ),
                ),
                const Gap(8),
                Row(
                  children: <Widget>[
                    const Iconify(
                      VscodeIcons.file_type_pdf2,
                      size: 45,
                    ),
                    const Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <StatelessWidget>[
                          Text(
                            '${pdf?.title}',
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(8),
                          Text(
                            GetTimeAgo.parse(pdf!.createdAt!),
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(8),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.download,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Text(
                  '${pdf.description}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
