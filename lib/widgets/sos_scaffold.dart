/* sos
 * Copyright (c) 2025 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:ywt_private/ywt_private.dart' as ywt;

import 'package:open_ui/open_ui.dart';
import 'package:material_ui/material_ui.dart';

class SosScaffold extends StatelessWidget {
  final EzCP config;
  final Widget body;
  final List<Widget>? fabs;
  final bool isHome;

  const SosScaffold(
    this.config, {
    super.key,
    required this.body,
    this.fabs,
    this.isHome = false,
  });

  @override
  Widget build(BuildContext context) => EzAdaptiveParent(
        small: EzScaffold(
          config,
          body: body,
          footer: EzFooter(
            config,
            quiet: isHome,
            a11howPath: ywt.sosContributeA11,
          ),
          fabs: <Widget>[
            EzUpdaterFAB(
              config,
              appVersion: '3.1.0',
              versionSource:
                  'https://raw.githubusercontent.com/YWT-LLC/sos/refs/heads/main/APP_VERSION',
              gPlay: ywt.sosGPlay,
              appStore: ywt.sosAppStore,
              github: ywt.sosReleases,
            ),
            if (fabs != null) ...fabs!,
            ...config.backFABs(isHome: isHome),
          ],
        ),
      );
}
