# Show Values KDE Plasma

Plasma 6 widget that fetches CO2 / humidity / temperature from a local HTTP endpoint and displays them.

## Specs

- Endpoint: `http://localhost:5605`
- Poll interval: 10,000ms
- Display: `<icon><ppm> ppm, <humidity>%, <temperature>℃`
- Thresholds: `threshold1 = 800`, `threshold2 = 900`
- Blink: 300ms when `ppm >= threshold1`, otherwise 1000ms
- Tooltip: last modified timestamp + `stat` JSON

## Requirements

- KDE Plasma 6
- `kpackagetool6`

## Install

```bash
kpackagetool6 -t Plasma/Applet -i /path/to/show_values_KDE_Plasma
```

## Update

```bash
kpackagetool6 -t Plasma/Applet -u /path/to/show_values_KDE_Plasma
```

## Uninstall

```bash
rm -rf ~/.local/share/plasma/plasmoids/show_values_kde_plasma
```

## Add the widget

1. Right-click the desktop → Edit Mode
2. Add Widgets → place `Show Values`
3. Run `nohup plasmashell --replace >/dev/null 2>&1 &` if it does not appear

## Development notes

- `metadata.json` uses `Plasma/Applet`
- QML entry is `contents/ui/main.qml`
- If errors do not show up, clearing QML cache may help

```bash
rm -rf ~/.cache/plasmashell/qmlcache
rm -rf ~/.cache/qmlcache
```

## License

Apache-2.0
