import 'package:colorful_iconify_flutter/icons/vscode_icons.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../config/services/file_download.dart';
import '../../../../../config/widgets/previewers/pdf.dart';
import '../../bloc/account_bloc.dart';

class AccountPagePdfsView extends StatelessWidget {
  const AccountPagePdfsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (BuildContext context, AccountState state) {
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final userPdf = state.profileDetailsResponse?.userPdfs?[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      showPdfPreviewDialog(
                        context: context,
                        pdfUrl: userPdf?.fileUrl,
                        appBarTitle: userPdf?.title,
                      );
                    },
                    child: ExtendedImage.network(
                      '${userPdf?.thumbnailUrl}',
                      width: double.infinity,
                      fit: BoxFit.cover,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                    ),),
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
                            '${userPdf?.title}',
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(8),
                          Text(
                            'Updated on ${DateFormat('dd MMM yyyy').format(userPdf!.createdAt!)}',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(8),
                    IconButton(
                      onPressed: () {
                        DownloadService.downloadFile(
                          '${userPdf.fileUrl}',
                          '${userPdf.title}.pdf',
                        );
                      },
                      icon: const Icon(
                        Icons.download,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Text(
                  '${userPdf.description}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Gap(8);
          },
          itemCount: state.profileDetailsResponse?.userPdfs?.length ?? 0,
        );
      },
    );
  }
}
