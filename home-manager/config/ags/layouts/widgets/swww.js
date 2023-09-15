const { Box, Button, Label } = ags.Widget;
const { execAsync } = ags.Utils;

export const Swww = props => Button({
  ...props,
  className: 'swww panel-button',
  onClicked: () => execAsync('/home/edjubert/.config/swww/swwwallpaper.sh -n'),
  onSecondaryClick: () => execAsync('/home/edjubert/.config/swww/swwwallpaper.sh -s'),
  child: Box({
    child: Label('󰉼')
  })
})

