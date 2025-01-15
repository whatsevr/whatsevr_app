part of '../page.dart';

class BookmarkFolder {
  final String id;
  final String name;
  final String? icon;
  final DateTime createdAt;
  final List<SavedContent> items;

  BookmarkFolder({
    required this.id,
    required this.name,
    this.icon,
    required this.createdAt,
    required this.items,
  });
}

class SavedContent {
  final String uid;
  final WhatsevrContentType type;
  final String title;
  final String? thumbnail;
  final DateTime savedAt;
  final String? description;
  final Map<String, dynamic>? metadata;

  SavedContent({
    required this.uid,
    required this.type,
    required this.title,
    this.thumbnail,
    required this.savedAt,
    this.description,
    this.metadata,
  });
}

class _BookmarksView extends StatefulWidget {
  const _BookmarksView();

  @override
  State<_BookmarksView> createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<_BookmarksView> {
  BookmarkFolder? _selectedFolder;

  final List<BookmarkFolder> _folders = [
    BookmarkFolder(
      id: '1',
      name: 'Tutorials',
      icon: '📚',
      createdAt: DateTime.now(),
      items: [
        SavedContent(
          uid: '1',
          type: WhatsevrContentType.wtv,
          title: 'Flutter Animation Tutorial',
          thumbnail: 'https://picsum.photos/200/200?random=1',
          savedAt: DateTime.now(),
          description: 'Learn advanced animations in Flutter',
          metadata: {'duration': '10:30', 'views': 1200},
        ),
        SavedContent(
          uid: '2',
          type: WhatsevrContentType.pdf,
          title: 'UI Design Guidelines',
          thumbnail: 'https://picsum.photos/200/200?random=2',
          savedAt: DateTime.now(),
          metadata: {'pages': 25},
        ),
      ],
    ),
    BookmarkFolder(
      id: '2',
      name: 'Inspiration',
      icon: '💡',
      createdAt: DateTime.now(),
      items: [
        SavedContent(
          uid: '3',
          type: WhatsevrContentType.photo,
          title: 'Modern UI Examples',
          thumbnail: 'https://picsum.photos/200/200?random=3',
          savedAt: DateTime.now(),
        ),
        SavedContent(
          uid: '4',
          type: WhatsevrContentType.flick,
          title: 'Design Process',
          thumbnail: 'https://picsum.photos/200/200?random=4',
          savedAt: DateTime.now(),
          metadata: {'duration': '3:45'},
        ),
      ],
    ),
    // Add more sample folders...
  ];

  @override
  Widget build(BuildContext context) {
    return _selectedFolder == null
        ? _buildFoldersGrid()
        : _buildFolderContent();
  }

  Widget _buildFoldersGrid() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(context.whatsevrTheme.spacing2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Collections',
                style: context.whatsevrTheme.h3,
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // Show create folder dialog
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(context.whatsevrTheme.spacing2),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: context.whatsevrTheme.spacing2,
              crossAxisSpacing: context.whatsevrTheme.spacing2,
              childAspectRatio: 1,
            ),
            itemCount: _folders.length,
            itemBuilder: (context, index) {
              final folder = _folders[index];
              return _FolderCard(
                folder: folder,
                onTap: () => setState(() => _selectedFolder = folder),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFolderContent() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(context.whatsevrTheme.spacing2),
          decoration: BoxDecoration(
            color: context.whatsevrTheme.surface,
            boxShadow: [context.whatsevrTheme.boxShadow],
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => setState(() => _selectedFolder = null),
              ),
              const Gap(8),
              Text(
                _selectedFolder!.name,
                style: context.whatsevrTheme.subtitle,
              ),
              const Spacer(),
              Text(
                '${_selectedFolder!.items.length} items',
                style: context.whatsevrTheme.caption,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _selectedFolder!.items.length,
            itemBuilder: (context, index) {
              final item = _selectedFolder!.items[index];
              return _SavedItemTile(item: item);
            },
          ),
        ),
      ],
    );
  }
}

class _FolderCard extends StatelessWidget {
  final BookmarkFolder folder;
  final VoidCallback onTap;

  const _FolderCard({
    required this.folder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: context.whatsevrTheme.borderRadiusSmall,
      child: Container(
        padding: EdgeInsets.all(context.whatsevrTheme.spacing2),
        decoration: BoxDecoration(
          color: context.whatsevrTheme.surface,
          borderRadius: context.whatsevrTheme.borderRadiusSmall,
          boxShadow: [context.whatsevrTheme.boxShadow],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              folder.icon ?? '📁',
              style: TextStyle(fontSize: 32),
            ),
            const Gap(8),
            Text(
              folder.name,
              style: context.whatsevrTheme.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(4),
            Text(
              '${folder.items.length} items',
              style: context.whatsevrTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}

class _SavedItemTile extends StatelessWidget {
  final SavedContent item;

  const _SavedItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.whatsevrTheme.spacing2,
        vertical: context.whatsevrTheme.spacing1,
      ),
      decoration: BoxDecoration(
        color: context.whatsevrTheme.surface,
        borderRadius: context.whatsevrTheme.borderRadiusSmall,
        boxShadow: [context.whatsevrTheme.boxShadow],
      ),
      child: InkWell(
        onTap: () {
          // Handle item tap
        },
        child: Padding(
          padding: EdgeInsets.all(context.whatsevrTheme.spacing2),
          child: Row(
            children: [
              if (item.thumbnail != null)
                ClipRRect(
                  borderRadius: context.whatsevrTheme.borderRadiusSmall,
                  child: Image.network(
                    item.thumbnail!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          item.type.name.toUpperCase(),
                          style: context.whatsevrTheme.caption,
                        ),
                      ],
                    ),
                    const Gap(4),
                    Text(
                      item.title,
                      style: context.whatsevrTheme.subtitle.copyWith(
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item.description != null) ...[
                      const Gap(4),
                      Text(
                        item.description!,
                        style: context.whatsevrTheme.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const Gap(4),
                    _buildMetadataRow(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetadataRow(BuildContext context) {
    final List<Widget> metadata = [];

    if (item.metadata != null) {
      if (item.metadata!['duration'] != null) {
        metadata.add(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.timer_outlined,
                size: 12, color: context.whatsevrTheme.textLight,),
            const Gap(4),
            Text(
              item.metadata!['duration'],
              style: context.whatsevrTheme.caption,
            ),
          ],
        ),);
      }

      if (item.metadata!['views'] != null) {
        metadata.add(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.visibility_outlined,
                size: 12, color: context.whatsevrTheme.textLight,),
            const Gap(4),
            Text(
              NumberFormat.compact().format(item.metadata!['views']),
              style: context.whatsevrTheme.caption,
            ),
          ],
        ),);
      }
    }

    return Row(
      children: [
        if (metadata.isNotEmpty) ...[
          ...metadata
              .asMap()
              .entries
              .map((entry) => [
                    entry.value,
                    if (entry.key < metadata.length - 1) const Gap(8),
                  ],)
              .expand((x) => x),
          const Spacer(),
        ],
        Text(
          timeago.format(item.savedAt),
          style: context.whatsevrTheme.caption,
        ),
      ],
    );
  }
}
