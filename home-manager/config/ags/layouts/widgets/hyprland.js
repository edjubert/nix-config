import * as hyprland from '../../modules/hyprland.js';
const { Box, EventBox, Button, Label } = ags.Widget;
const { execAsync } = ags.Utils;

export const Workspaces = ({ monitor, ...props }) => Box({
  ...props,
  className: 'workspaces panel-button',
  children: [Box({
    children: [EventBox({
      className: 'eventbox',
      child: hyprland.Workspaces({
        monitor,
        indicator: () => Box({
          className: 'indicator',
          valign: 'center',
          children: [Box({ className: 'fill' })],
        }),
      }),
    })],
  })],
});

export const Special = props => Button({
  ...props,
  className: 'client panel-button',
  onClicked: () => execAsync('gophrland expose show'),
  child: Box({
    child: Label('Special')
  })
})

export const Client = props => Button({
  ...props,
  className: 'client panel-button',
  onSecondaryClick: () => execAsync('gophrland expose toggle'),
  child: Box({
    children: [
      hyprland.ClientIcon({
        symbolic: true,
        substitutes: [
          { from: 'com.transmissionbt.Transmission._43_219944-symbolic', to: 'com.transmissionbt.Transmission-symbolic' },
          { from: 'com.transmissionbt.Transmission._40_219944-symbolic', to: 'com.transmissionbt.Transmission-symbolic' },
          { from: 'com.transmissionbt.Transmission._37_219944-symbolic', to: 'com.transmissionbt.Transmission-symbolic' },
          { from: 'blueberry.py-symbolic', to: 'bluetooth-symbolic' },
          { from: 'org.wezfurlong.wezterm-symbolic', to: 'folder-code-symbolic' },
          { from: 'Caprine-symbolic', to: 'facebook-messenger-symbolic' },
          { from: '-symbolic', to: 'preferences-desktop-display-symbolic' },
        ],
      }),
      hyprland.ClientLabel({
        show: 'class',
        substitutes: [
          { from: 'jetbrains-idea', to: 'IntelliJ' },
          { from: 'alacritty', to: 'Alacritty' },
          { from: 'firefox', to: 'Firefox' },
          { from: 'org.gnome.Nautilus', to: 'Files' },
          { from: '', to: 'Desktop' },
        ],
      }),
    ],
  }),
});
