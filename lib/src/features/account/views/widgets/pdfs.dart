import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';
import 'package:whatsevr_app/config/api/response_model/profile_details.dart';
import 'package:colorful_iconify_flutter/icons/vscode_icons.dart';
import 'package:whatsevr_app/config/services/file_download.dart';
import '../../bloc/account_bloc.dart';

class AccountPagePdfsView extends StatelessWidget {
  const AccountPagePdfsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            UserPdf? userPdf = state.profileDetailsResponse?.userPdfs?[index];
            return Column(
              children: [
                ExtendedImage.network(
                  '${userPdf?.thumbnailUrl}',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Gap(8),
                Row(
                  children: <Widget>[
                    Iconify(
                      VscodeIcons.file_type_pdf2,
                      size: 45,
                    ),
                    const Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <StatelessWidget>[
                          Text(
                            '${userPdf?.title}',
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Gap(8),
                          Text(
                            'Updated on ${DateFormat('dd MMM yyyy').format(userPdf!.createdAt!)}',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(8),
                    IconButton(
                      onPressed: () {
                        DownloadService.downloadFile(
                            '${userPdf.fileUrl}', '${userPdf.title}.pdf');
                      },
                      icon: Icon(
                        Icons.download,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Gap(8);
          },
          itemCount: state.profileDetailsResponse?.userPdfs?.length ?? 0,
        );
      },
    );
  }
}