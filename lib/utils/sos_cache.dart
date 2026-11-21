/* sos
 * Copyright (c) 2025 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './export.dart';

import 'package:open_ui/open_ui.dart';
import 'package:material_ui/material_ui.dart';

class SOSCache extends EzAppCache {
  Locale _locale;
  Lang _l10n;

  late EzSwitchColor _videoColor;
  late Color _videoTextColor;

  SOSCache(Locale locale, Lang l10n)
      : _locale = locale,
        _l10n = l10n;

  @override
  void init(EzProvider config) => _setVideoColors(config);

  @override
  Future<void> rebuild(EzProvider config) async {
    _setVideoColors(config);

    if (_locale != config.locale) {
      _locale = config.locale;
      _l10n = await Lang.delegate.load(config.locale);
    }
  }

  void _setVideoColors(EzProvider config) {
    _videoColor =
        ezCOG(EzManager.get(config.isDark ? darkVideoColorKey : lightVideoColorKey)) ?? _backupFill;
    _videoTextColor = ezTextColor(_videoColor.asColor);
  }
}

// Global //

SOSCache _cache(EzProvider config) => config.appCache! as SOSCache;

bool get isIOS => EzManager.platform == TargetPlatform.iOS;
bool get showTutorial => EzManager.get(showTutorialKey);

Lang l10n(EzProvider config) => _cache(config)._l10n;

// SOS //

bool get autoShareMedia => EzManager.get(autoShareMediaKey);

List<String> get emc => EzManager.get(emcKey);

bool get sosOnOpen => EzManager.get(sosOnOpenKey);
bool get sosOnClose => EzManager.get(sosOnCloseKey);
bool get sosOnInterrupt => EzManager.get(sosOnInterruptKey);
LLType get linkType => LLTypeConfig.safeLookup(EzManager.get(linkTypeKey));

// Color //

const EzSwitchColor _backupFill = EzSwitchColor(color: Colors.red);
EzSwitchColor videoFill(EzProvider config) => _cache(config)._videoColor;

Color videoTextColor(EzProvider config) => _cache(config)._videoTextColor;
EzSwitchColor videoTextFiller(EzProvider config) => EzSwitchColor(color: videoTextColor(config));
