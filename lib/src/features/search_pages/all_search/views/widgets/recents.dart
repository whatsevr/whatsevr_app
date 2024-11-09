part of '../page.dart';

class _RecentView extends StatelessWidget {
  const _RecentView();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 0,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Gap(16),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  backgroundImage: ExtendedNetworkImageProvider(
                    MockData.randomImageAvatar(),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Username',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Location',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                const Icon(Icons.star),
                const Text(
                  'Rating 4.5',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const Gap(8),
                MaterialButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: const Text('Add Friend'),
                ),
                const Gap(8),
              ],
            ),
            const Gap(8),
            Stack(
              children: <Widget>[
                ExtendedImage.network(
                  MockData.randomImageAvatar(),
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Freelancer',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(8),
            Row(
              children: <Widget>[
                const Gap(8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Caption'),
                      Text('Joined On 4 April, MU 334'),
                      Text('#tag1 #tag2 #tag3'),
                    ],
                  ),
                ),
                const Gap(8),
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert_rounded),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
