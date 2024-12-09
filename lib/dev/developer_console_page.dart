import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'package:whatsevr_app/config/routes/router.dart';
import 'package:whatsevr_app/config/routes/routes_name.dart';
import 'package:whatsevr_app/config/services/auth_db.dart';
import 'package:whatsevr_app/config/services/auth_user_service.dart';
import 'package:whatsevr_app/config/services/device_info.dart';
import 'package:whatsevr_app/config/themes/theme.dart';
import 'package:whatsevr_app/config/widgets/stack_toast.dart';
import 'package:whatsevr_app/config/widgets/whatsevr_icons.dart';

class DeveloperConsolePage extends StatefulWidget {
  const DeveloperConsolePage({super.key});

  @override
  State<DeveloperConsolePage> createState() => _DeveloperConsolePageState();
}

class _DeveloperConsolePageState extends State<DeveloperConsolePage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Console'),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            _buildActionsCard(),
            const SizedBox(height: 8),
            _buildDeviceInfoCard(),
            const SizedBox(height: 8),
            _buildLoggedUserInfoCard(),
            const SizedBox(height: 8),
            _buildSupportiveDataCard(),
            Gap(8),
            _buildAllAuthorizedUsersCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceInfoCard() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black.withOpacity(0.2),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              FontAwesomeIcons.mobileAlt,
              color: Colors.redAccent,
              size: 24,
            ),
            title: Text(
              'Device Information',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          for ((String, String) itm in <(String, String)>[
            (
              'Device Name',
              DeviceInfoService.currentDeviceInfo?.deviceName ?? 'Unknown'
            ),
            (
              'Country Code',
              DeviceInfoService.currentDeviceInfo?.countryCode ?? 'Unknown'
            ),
            (
              'Device Type',
              DeviceInfoService.currentDeviceInfo?.isAndroid ?? false
                  ? 'Android'
                  : DeviceInfoService.currentDeviceInfo?.isIos ?? false
                      ? 'iOS'
                      : 'Unknown',
            ),
          ])
            ListTile(
              title: Text(
                itm.$1,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              subtitle: Text(
                itm.$2,
                style: TextStyle(color: Colors.grey[700], fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoggedUserInfoCard() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black.withOpacity(0.2),
      child: Column(
        children: [
          ListTile(
            leading:
                Icon(FontAwesomeIcons.user, color: Colors.redAccent, size: 24),
            title: Text(
              'Logged User Information',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          for ((String, String) itm in <(String, String)>[
            ('User UID', AuthUserDb.getLastLoggedUserUid() ?? 'Unknown'),
          ])
            ListTile(
              title: Text(
                itm.$1,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              subtitle: Text(
                itm.$2,
                style: TextStyle(color: Colors.grey[700], fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAllAuthorizedUsersCard() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black.withOpacity(0.2),
      child: Column(
        children: [
          ListTile(
            leading:
                Icon(FontAwesomeIcons.users, color: Colors.redAccent, size: 24),
            title: Text(
              'All Authorized Users',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          for (String? userUid
              in AuthUserDb.getAllAuthorisedUserUid() ?? <String?>[])
            ListTile(
              title: Text(
                userUid ?? 'Unknown',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSupportiveDataCard() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black.withOpacity(0.2),
      child: Column(
        children: [
          ListTile(
            leading: Icon(FontAwesomeIcons.database,
                color: Colors.redAccent, size: 24,),
            title: Text(
              'Supportive Data of current user',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Key',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Value',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              for ((String?, String?) itm in [
                ('Name', AuthUserService.supportiveData?.userInfo?.name),
                (
                  'Is Portfolio',
                  AuthUserService.supportiveData?.userInfo?.isPortfolio
                      .toString()
                ),
              ])
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${itm.$1}'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${itm.$2}'),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionsCard() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black.withOpacity(0.2),
      child: Column(
        children: [
          ListTile(
            leading:
                Icon(FontAwesomeIcons.cogs, color: Colors.redAccent, size: 24),
            title: const Text(
              'Actions',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          for ((String, Future<void>? Function()) itm
              in <(String, Future<void>? Function())>[
            (
              'Monitoring Console',
              () async {
                await AppNavigationService.newRoute(
                  RoutesName.talkerMonitorPage,
                );
              }
            ),
            (
              'Check Theme Colors',
              () async {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return _ThemePropertiesShowcase();
                  },
                );
              }
            ),
             (
              'Whatsevr Icons',
              () async {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return _WhatsevrIconsShowcase();
                  },
                );
              }
            ),
            (
              'Test Function 1',
              () async {
                SmartDialog.showToast( 'Success Test Function');
                
              }
            ),
            (
              'Test Function 2',
              () async {
                WhatsevrStackToast.showFailed('Failed Test Function');
              }
            ),
          ])
            ListTile(
              title: TextButton(
                onPressed: itm.$2,
                child: Text(
                  itm.$1,
                  style: TextStyle(color: Colors.redAccent, fontSize: 14),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ThemePropertiesShowcase extends StatelessWidget {
  const _ThemePropertiesShowcase();

  @override
  Widget build(BuildContext context) {
    final theme = context.whatsevrTheme;

    return Scaffold(
      backgroundColor: theme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(theme.spacing2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Theme Properties', style: theme.h1),
                  Switch(
                    value: context.isDarkMode,
                    onChanged: (_) => context.toggleTheme(),
                  ),
                ],
              ),
              SizedBox(height: theme.spacing3),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Colors
                      _buildSection(
                        'Colors',
                        [
                          _ThemePropertyBox(
                              name: 'Primary',
                              color: theme.primary,
                              icon: Icons.color_lens,
                              tooltip: 'Primary color',),
                          _ThemePropertyBox(
                              name: 'Secondary',
                              color: theme.secondary,
                              icon: Icons.colorize,
                              tooltip: 'Secondary color',),
                          _ThemePropertyBox(
                              name: 'Background',
                              color: theme.background,
                              icon: Icons.format_paint,
                              tooltip: 'Background color',),
                          _ThemePropertyBox(
                              name: 'Surface',
                              color: theme.surface,
                              icon: Icons.layers,
                              tooltip: 'Surface color',),
                          _ThemePropertyBox(
                              name: 'Error',
                              color: theme.error,
                              icon: Icons.error,
                              tooltip: 'Error color',),
                          _ThemePropertyBox(
                              name: 'Success',
                              color: theme.success,
                              icon: Icons.check_circle,
                              tooltip: 'Success color',),
                          _ThemePropertyBox(
                              name: 'Warning',
                              color: theme.warning,
                              icon: Icons.warning,
                              tooltip: 'Warning color',),
                          _ThemePropertyBox(
                              name: 'Info',
                              color: theme.info,
                              icon: Icons.info,
                              tooltip: 'Info color',),
                          _ThemePropertyBox(
                              name: 'Text',
                              color: theme.text,
                              icon: Icons.text_fields,
                              tooltip: 'Text color',),
                          _ThemePropertyBox(
                              name: 'Text Light',
                              color: theme.textLight,
                              icon: Icons.text_format,
                              tooltip: 'Light text color',),
                          _ThemePropertyBox(
                              name: 'Divider',
                              color: theme.divider,
                              icon: Icons.line_weight,
                              tooltip: 'Divider color',),
                          _ThemePropertyBox(
                              name: 'Disabled',
                              color: theme.disabled,
                              icon: Icons.block,
                              tooltip: 'Disabled color',),
                          _ThemePropertyBox(
                              name: 'Accent',
                              color: theme.accent,
                              icon: Icons.highlight,
                              tooltip: 'Accent color',),
                          _ThemePropertyBox(
                              name: 'Button',
                              color: theme.buttonColor,
                              icon: Icons.smart_button,
                              tooltip: 'Button color',),
                          _ThemePropertyBox(
                              name: 'Card',
                              color: theme.card,
                              icon: Icons.credit_card,
                              tooltip: 'Card color',),
                          _ThemePropertyBox(
                              name: 'Icon',
                              color: theme.icon,
                              icon: Icons.interests,
                              tooltip: 'Icon color',),
                          _ThemePropertyBox(
                              name: 'Shadow',
                              color: theme.shadow,
                              icon: Icons.blur_on,
                              tooltip: 'Shadow color',),
                          _ThemePropertyBox(
                              name: 'AppBar',
                              color: theme.appBar,
                              icon: Icons.web_asset,
                              tooltip: 'AppBar color',),
                          _ThemePropertyBox(
                              name: 'Light Background',
                              color: theme.lightBackground,
                              icon: Icons.light_mode,
                              tooltip: 'Light background color',),
                          _ThemePropertyBox(
                              name: 'Dark Background',
                              color: theme.darkBackground,
                              icon: Icons.dark_mode,
                              tooltip: 'Dark background color',),
                        ],
                      ),
                      // Spacing
                      _buildSection(
                        'Spacing',
                        [
                          _ThemePropertyBox(
                              name: 'Spacing 1',
                              value: theme.spacing1,
                              icon: Icons.space_bar,
                              tooltip: 'Base spacing',),
                          _ThemePropertyBox(
                              name: 'Spacing 2',
                              value: theme.spacing2,
                              icon: Icons.space_bar,
                              tooltip: 'Double spacing',),
                          _ThemePropertyBox(
                              name: 'Spacing 3',
                              value: theme.spacing3,
                              icon: Icons.space_bar,
                              tooltip: 'Triple spacing',),
                          _ThemePropertyBox(
                              name: 'Spacing 4',
                              value: theme.spacing4,
                              icon: Icons.space_bar,
                              tooltip: 'Quadruple spacing',),
                          _ThemePropertyBox(
                              name: 'Spacing 5',
                              value: theme.spacing5,
                              icon: Icons.space_bar,
                              tooltip: 'Quintuple spacing',),
                          _ThemePropertyBox(
                              name: 'Spacing 6',
                              value: theme.spacing6,
                              icon: Icons.space_bar,
                              tooltip: 'Sextuple spacing',),
                        ],
                      ),
                      // Other Metrics
                      _buildSection(
                        'Metrics',
                        [
                          _ThemePropertyBox(
                              name: 'Border Radius',
                              value: theme.borderRadius,
                              icon: Icons.rounded_corner,
                              tooltip: 'Default border radius',),
                          _ThemePropertyBox(
                              name: 'Button Height',
                              value: theme.buttonHeight,
                              icon: Icons.height,
                              tooltip: 'Standard button height',),
                          _ThemePropertyBox(
                              name: 'Elevation Small',
                              value: theme.elevationSmall,
                              icon: Icons.elevator,
                              tooltip: 'Small elevation',),
                          _ThemePropertyBox(
                              name: 'Elevation Medium',
                              value: theme.elevationMedium,
                              icon: Icons.elevator,
                              tooltip: 'Medium elevation',),
                          _ThemePropertyBox(
                              name: 'Elevation Large',
                              value: theme.elevationLarge,
                              icon: Icons.elevator,
                              tooltip: 'Large elevation',),
                        ],
                      ),
                      // Opacity
                      _buildSection(
                        'Opacity',
                        [
                          _ThemePropertyBox(
                              name: 'Dialog Barrier',
                              value: theme.dialogBarrierOpacity,
                              icon: Icons.opacity,
                              tooltip: 'Dialog barrier opacity',),
                          _ThemePropertyBox(
                              name: 'Disabled',
                              value: theme.disabledOpacity,
                              icon: Icons.opacity,
                              tooltip: 'Disabled state opacity',),
                          _ThemePropertyBox(
                              name: 'Hover',
                              value: theme.hoverOpacity,
                              icon: Icons.opacity,
                              tooltip: 'Hover state opacity',),
                          _ThemePropertyBox(
                              name: 'Focus',
                              value: theme.focusOpacity,
                              icon: Icons.opacity,
                              tooltip: 'Focus state opacity',),
                          _ThemePropertyBox(
                              name: 'Selected',
                              value: theme.selectedOpacity,
                              icon: Icons.opacity,
                              tooltip: 'Selected state opacity',),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const SizedBox(height: 16),
      ],
    );
  }
}

class _ThemePropertyBox extends StatelessWidget {
  final String name;
  final Color? color;
  final double? value;
  final IconData icon;
  final String tooltip;

  const _ThemePropertyBox({
    required this.name,
    this.color,
    this.value,
    required this.icon,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final isColorProperty = color != null;
    final displayValue = isColorProperty ? '' : value.toString();
    final displayColor = isColorProperty ? color : Colors.grey[200];
    final textColor = isColorProperty
        ? (ThemeData.estimateBrightnessForColor(color!) == Brightness.light
            ? Colors.black
            : Colors.white)
        : Colors.black;

    return Container(
      width: double.infinity,
      height: 80,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: displayColor,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Tooltip(
            message: tooltip,
            child: Icon(icon, color: textColor),
          ),
          SizedBox(width: 16),
          Text(
            '$name: $displayValue',
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _WhatsevrIconsShowcase extends StatelessWidget {
  const _WhatsevrIconsShowcase();

  @override
  Widget build(BuildContext context) {
    final theme = context.whatsevrTheme;

    return Scaffold(
      backgroundColor: theme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(theme.spacing2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Whatsevr Icons', style: theme.h1),
              SizedBox(height: theme.spacing3),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _iconData.length,
                  itemBuilder: (context, index) {
                    final icon = _iconData[index];
                    return GestureDetector(
                      onTap: (){
                        Clipboard.setData(ClipboardData(text: 'Icon(WhatsevrIcons.${icon.$1})'));
                        WhatsevrStackToast.showSuccess('Copied ${icon.$1} to clipboard');
                      },
                      child: Card(
                        color: theme.card,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(icon.$2, size: 32),
                            SizedBox(height: 8),
                            Text(
                              icon.$1,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } 

  List<(String, IconData)> get _iconData => [
        ('Play_Button', WhatsevrIcons.Play_Button),
        ('Post_Memories', WhatsevrIcons.Post_Memories),
        ('Post_Upload_Icon_002', WhatsevrIcons.Post_Upload_Icon_002),
        ('Search_Icon', WhatsevrIcons.Search_Icon),
        ('Share', WhatsevrIcons.Share),
        ('Upload_photo', WhatsevrIcons.Upload_photo),
        ('WTV_Icon', WhatsevrIcons.WTV_Icon),
        ('Book_Mark_Icon_Line', WhatsevrIcons.Book_Mark_Icon_Line),
        ('Book_Mark_Icon', WhatsevrIcons.Book_Mark_Icon),
        ('Comment_icon', WhatsevrIcons.Comment_icon),
        ('EditPencile_02', WhatsevrIcons.EditPencile_02),
        ('Flicks_Icon_001', WhatsevrIcons.Flicks_Icon_001),
        ('Hamburger_Icon', WhatsevrIcons.Hamburger_Icon),
        ('I_Button_Icon', WhatsevrIcons.I_Button_Icon),
        ('Icon_Explore_002_SVG', WhatsevrIcons.Icon_Explore_002_SVG),
        ('Icon_WhatServ_001_SVG', WhatsevrIcons.Icon_WhatServ_001_SVG),
        ('Like_Outline', WhatsevrIcons.Like_Outline),
        ('Like_Solid', WhatsevrIcons.Like_Solid),
        ('Message', WhatsevrIcons.Message),
        ('Notification_Icon_001', WhatsevrIcons.Notification_Icon_001),
        ('Offer_Icon', WhatsevrIcons.Offer_Icon),
        ('PDF_Icon', WhatsevrIcons.PDF_Icon),
        ('Docts_icon', WhatsevrIcons.Docts_icon),
        ('Account', WhatsevrIcons.Account),
      ];
}
