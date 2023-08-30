import * as shared from './shared.js';
import { Launcher } from './shared.js';
import { Workspaces, Client, Special } from './widgets/hyprland.js';
import { Swww } from './widgets/swww.js';
import { Separator } from '../modules/misc.js';
import { PanelIndicator as MediaIndicator } from './widgets/media.js';
import { PanelIndicator as NotificationIndicator } from './widgets/notifications.js';
import { DistroIcon } from '../modules/misc.js';
import { PanelButton as ColorPicker } from '../modules/colorpicker.js';
import { PanelButton as PowerMenu } from './widgets/powermenu.js';
import { PanelButton as DashBoard } from './widgets/dashboard.js';
import { PanelButton as ScreenRecord } from '../modules/screenrecord.js';
import { PanelButton as QuickSettings } from './widgets/quicksettings.js';

const Bar = monitor => shared.Bar({
  anchor: 'top left right',
  monitor,
  start: [
    Workspaces(),
    Separator({ valign: 'center' }),
    Special(),
    Separator({ valign: 'center' }),
    Client(),
    MediaIndicator({ hexpand: true, halign: 'end' }),
  ],
  center: [
    DashBoard({ format: '%H:%M' }),
  ],
  end: [
    NotificationIndicator({ direction: 'right', hexpand: true, halign: 'start' }),
    ags.Widget.Box({ hexpand: true }),
    Swww(),
    ScreenRecord(),
    // ColorPicker(),
    QuickSettings(),
    Separator({ valign: 'center' }),
    PowerMenu(),
  ],
});

export default monitors => ([
  ...monitors.map(mon => [
    Bar(mon),
    shared.Notifications(mon, 'slide_down', 'top'),
    shared.Desktop(mon),
    ...shared.Corners(mon),
    shared.OSDIndicator(mon),
    shared.Dock(mon),
  ]),
  shared.Quicksettings({ position: 'top right' }),
  shared.Dashboard({ position: 'top' }),
]).flat(2);
