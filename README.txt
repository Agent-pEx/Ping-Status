Ping Status

Author: Kineneta Studio
Version: 2.0
License: Creative Commons BY-NC-SA 3.0

If you'd like, buy me a coffee! https://ko-fi.com/kineneta

===============================================================================

OVERVIEW

Ping Status is a universal ICMP ping monitor Rainmeter skin. 
Devices are managed by name and IP, and the status is shown with a colored indicator. 
Settings are edited in a separate panel.

===============================================================================

MAIN FEATURES

- ICMP ping based availability check
- Dynamic list: only configured devices are shown
- Quick setup in Settings panel
- Help panel in multiple languages (HU/EN/DE/ES/PT/FR/IT)

===============================================================================

INSTALLATION

1. Copy the Ping Status folder to the Rainmeter Skins folder
2. Load the PingStatus.ini skin
3. The gear icon (SET) opens settings, the question mark opens Help

===============================================================================

USAGE

1. Open the Settings panel
2. Fill in Name and IP fields (name maximum 10 characters)
3. Click the Add Device button
4. Edit: click name or IP field and press Enter
5. Delete: click the Delete button

===============================================================================

SETTINGS

Set the refresh interval and timeout in the Devices.inc file:

- UpdateInterval (seconds)
- PingTimeout (milliseconds)

IMPORTANT: If you manually edit Devices.inc or any translation file, ensure 
you save it with UTF-8 with BOM encoding to preserve special characters.

===============================================================================

LIMITATIONS

- Uses ICMP ping; firewall or permissions may block it
- UI is prepared for 10 devices by default
- Name field is limited to 10 characters

===============================================================================

TROUBLESHOOTING

- If everything is offline: check firewall and ICMP permissions
- If not updating: refresh the skin in Rainmeter
- If you don't see a new device: check Devices.inc content

===============================================================================

EXPANSION

For more than 10 devices:

1. Open PingStatus.ini and Settings.ini files
2. Change the MaxDevices value (e.g. 10 -> 12)
3. Open the Devices.inc file and add new lines:
   - Device11_Name=
   - Device11_IP=
4. In PingStatus.ini copy the last MeasurePing block and rename it to MeasurePing11
5. Copy the last device meter block and rename to Device11
6. In Settings.ini copy the last device row and rename to Device11

Tip: if unsure, copy the device 10 section and only change the numbers.

===============================================================================

TRANSLATIONS

Full description available in multiple languages in the Readme folder:

- README_hu.txt - Magyar
- README_en.txt - English
- README_de.txt - Deutsch
- README_es.txt - Espanol
- README_pt.txt - Portugues
- README_fr.txt - Francais
- README_it.txt - Italiano

===============================================================================

CREDITS

- Concept & Design: Kineneta Studio
- Development Assistant: Created with the support of AI (Cursor) based on the author's instructions and logic.

===============================================================================

Happy pinging!