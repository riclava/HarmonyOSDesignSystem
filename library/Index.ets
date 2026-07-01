/**
 * @riclava/designsystem — 公共 API 出口
 *
 * 用法：
 *   import { Token, AppButton, AppButtonType } from '@riclava/designsystem';
 */

// 主题 / Token
export { Token, initColorMode, isDarkMode, isCompactMode } from './src/main/ets/theme/Tokens';

// 基础组件
export { AppButton, AppButtonType, AppButtonSize } from './src/main/ets/components/AppButton';
export { AppCard } from './src/main/ets/components/AppCard';
export { AppTag, AppTagTone } from './src/main/ets/components/AppTag';
export { AppBadge } from './src/main/ets/components/AppBadge';
export { AppAvatar, AppAvatarShape } from './src/main/ets/components/AppAvatar';

// 表单组件
export { AppTextField } from './src/main/ets/components/AppTextField';
export { AppSearch } from './src/main/ets/components/AppSearch';
export { AppSwitch } from './src/main/ets/components/AppSwitch';
export { AppCheckbox } from './src/main/ets/components/AppCheckbox';
export { AppRadioGroup, AppRadioOption } from './src/main/ets/components/AppRadioGroup';
export { AppSlider } from './src/main/ets/components/AppSlider';
export { AppProgress, AppProgressKind } from './src/main/ets/components/AppProgress';

// 导航 / 列表
export { AppTabs } from './src/main/ets/components/AppTabs';
export { AppListItem } from './src/main/ets/components/AppListItem';

// 浮层 / 反馈
export { AppDialog } from './src/main/ets/components/AppDialog';
export { AppMenu, AppMenuItem } from './src/main/ets/components/AppMenu';
export { AppSheet } from './src/main/ets/components/AppSheet';
export { AppPopover } from './src/main/ets/components/AppPopover';
export { AppToast } from './src/main/ets/components/AppToast';

// 选择器
export { AppDatePicker } from './src/main/ets/components/AppDatePicker';
export { AppTimePicker, AppTimePickerMode } from './src/main/ets/components/AppTimePicker';
export { AppCalendar } from './src/main/ets/components/AppCalendar';

// 状态页 / 占位
export { StateView, StateKind } from './src/main/ets/components/StateView';
export { Skeleton } from './src/main/ets/components/Skeleton';
