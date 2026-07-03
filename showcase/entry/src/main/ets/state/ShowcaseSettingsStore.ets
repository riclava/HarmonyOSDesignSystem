import { common, ConfigurationConstant } from '@kit.AbilityKit';
import { preferences } from '@kit.ArkData';
import { i18n } from '@kit.LocalizationKit';
import { Density, initTheme, setBrand, setDensity } from '@riclava/designsystem';

export interface ShowcaseSettings {
  density: Density;
  brand: string;
  isDark: boolean;
  hasDarkPreference: boolean;
  language: string;
}

export class ShowcaseSettingsStore {
  private static readonly preferencesName: string = 'showcase_settings';
  private static readonly keyDensity: string = 'density';
  private static readonly keyLegacyCompact: string = 'compact';
  private static readonly keyBrand: string = 'brand';
  private static readonly keyDark: string = 'dark';
  private static readonly keyLanguage: string = 'language';
  private static store: preferences.Preferences | null = null;

  public static restore(
    context: common.UIAbilityContext,
    fallbackColorMode: ConfigurationConstant.ColorMode
  ): ShowcaseSettings {
    const settings: ShowcaseSettings = ShowcaseSettingsStore.read(context, fallbackColorMode);
    setDensity(settings.density);
    initTheme(
      settings.brand,
      settings.hasDarkPreference ? ShowcaseSettingsStore.colorModeFor(settings.isDark) : fallbackColorMode
    );

    if (settings.hasDarkPreference) {
      try {
        context.getApplicationContext().setColorMode(ShowcaseSettingsStore.colorModeFor(settings.isDark));
      } catch (err) {
      }
    }
    if (settings.language.length > 0) {
      ShowcaseSettingsStore.applyLanguage(settings.language);
    }
    return settings;
  }

  public static saveDensity(context: common.Context, density: Density): void {
    setDensity(density);
    ShowcaseSettingsStore.write(context, ShowcaseSettingsStore.keyDensity, density as number);
  }

  public static saveBrand(context: common.Context, brand: string): void {
    const normalized: string = ShowcaseSettingsStore.normalizeBrand(brand);
    setBrand(normalized);
    ShowcaseSettingsStore.write(context, ShowcaseSettingsStore.keyBrand, normalized);
  }

  public static saveDarkMode(context: common.Context, isDark: boolean): void {
    AppStorage.setOrCreate('isDark', isDark);
    ShowcaseSettingsStore.write(context, ShowcaseSettingsStore.keyDark, isDark);
  }

  public static saveLanguage(context: common.Context, language: string): void {
    const normalized: string = ShowcaseSettingsStore.normalizeLanguage(language);
    if (normalized.length === 0) {
      return;
    }
    ShowcaseSettingsStore.applyLanguage(normalized);
    ShowcaseSettingsStore.write(context, ShowcaseSettingsStore.keyLanguage, normalized);
  }

  public static prefersEnglish(): boolean {
    try {
      return i18n.System.getAppPreferredLanguage().toLowerCase().startsWith('en');
    } catch (err) {
      return false;
    }
  }

  private static read(
    context: common.Context,
    fallbackColorMode: ConfigurationConstant.ColorMode
  ): ShowcaseSettings {
    const defaults: ShowcaseSettings = {
      density: Density.Comfortable,
      brand: 'default',
      isDark: fallbackColorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK,
      hasDarkPreference: false,
      language: ''
    };

    try {
      const store: preferences.Preferences | null = ShowcaseSettingsStore.getStore(context);
      if (store === null) {
        return defaults;
      }
      const hasDarkPreference: boolean = store.hasSync(ShowcaseSettingsStore.keyDark);
      return {
        density: ShowcaseSettingsStore.readDensity(store, defaults.density),
        brand: ShowcaseSettingsStore.normalizeBrand(
          ShowcaseSettingsStore.readString(store, ShowcaseSettingsStore.keyBrand, defaults.brand)
        ),
        isDark: ShowcaseSettingsStore.readBool(store, ShowcaseSettingsStore.keyDark, defaults.isDark),
        hasDarkPreference,
        language: ShowcaseSettingsStore.normalizeLanguage(
          ShowcaseSettingsStore.readString(store, ShowcaseSettingsStore.keyLanguage, defaults.language)
        )
      };
    } catch (err) {
      return defaults;
    }
  }

  private static getStore(context: common.Context): preferences.Preferences | null {
    if (ShowcaseSettingsStore.store !== null) {
      return ShowcaseSettingsStore.store;
    }
    try {
      const store: preferences.Preferences = preferences.getPreferencesSync(context, {
        name: ShowcaseSettingsStore.preferencesName
      });
      ShowcaseSettingsStore.store = store;
      return store;
    } catch (err) {
      return null;
    }
  }

  private static write(context: common.Context, key: string, value: preferences.ValueType): void {
    try {
      const store: preferences.Preferences | null = ShowcaseSettingsStore.getStore(context);
      if (store === null) {
        return;
      }
      store.putSync(key, value);
      store.flush().catch(() => {
      });
    } catch (err) {
    }
  }

  private static readDensity(store: preferences.Preferences, fallback: Density): Density {
    try {
      // Prefer the new numeric density key; migrate the legacy boolean 'compact'.
      if (store.hasSync(ShowcaseSettingsStore.keyDensity)) {
        const value: preferences.ValueType = store.getSync(ShowcaseSettingsStore.keyDensity, fallback as number);
        if (typeof value === 'number' && value >= Density.Comfortable && value <= Density.SuperCompact) {
          return value as Density;
        }
      }
      if (store.hasSync(ShowcaseSettingsStore.keyLegacyCompact)) {
        const legacy: preferences.ValueType = store.getSync(ShowcaseSettingsStore.keyLegacyCompact, false);
        if (typeof legacy === 'boolean') {
          return legacy ? Density.Compact : Density.Comfortable;
        }
      }
      return fallback;
    } catch (err) {
      return fallback;
    }
  }

  private static readBool(store: preferences.Preferences, key: string, fallback: boolean): boolean {
    try {
      const value: preferences.ValueType = store.getSync(key, fallback);
      return typeof value === 'boolean' ? value : fallback;
    } catch (err) {
      return fallback;
    }
  }

  private static readString(store: preferences.Preferences, key: string, fallback: string): string {
    try {
      const value: preferences.ValueType = store.getSync(key, fallback);
      return typeof value === 'string' ? value : fallback;
    } catch (err) {
      return fallback;
    }
  }

  private static colorModeFor(isDark: boolean): ConfigurationConstant.ColorMode {
    return isDark
      ? ConfigurationConstant.ColorMode.COLOR_MODE_DARK
      : ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT;
  }

  private static normalizeBrand(brand: string): string {
    return brand === 'violet' ? 'violet' : 'default';
  }

  private static normalizeLanguage(language: string): string {
    const normalized: string = language.toLowerCase();
    if (normalized.startsWith('en')) {
      return 'en-US';
    }
    if (normalized.startsWith('zh')) {
      return 'zh-Hans';
    }
    return '';
  }

  private static applyLanguage(language: string): void {
    try {
      i18n.System.setAppPreferredLanguage(language);
    } catch (err) {
    }
  }
}
