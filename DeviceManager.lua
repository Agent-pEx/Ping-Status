-- Ping Status

-- Author: Fenyvesi István from Kineneta Studio

-- Version: 2.0

-- License: Creative Commons BY-NC-SA 3.0



function Initialize()

    deviceFile = SKIN:GetVariable('CURRENTPATH') .. 'Devices.inc'

end



local function is_empty(value)

    return value == nil or value == ''

end



local function normalize_name(name)

    if name == nil then return '' end

    if #name > 10 then

        return name:sub(1, 10)

    end

    return name

end



function AddDeviceWithVars()

    local name = SKIN:GetVariable('TempDeviceName')

    local ip = SKIN:GetVariable('TempDeviceIP')

    name = normalize_name(name)

    SKIN:Bang('!SetVariable', 'TempDeviceName', name)

    return AddDevice(name, ip)

end



function AddDevice(name, ip)

    name = normalize_name(name)

    if is_empty(name) or is_empty(ip) then return false end

    -- Read current file

    local file = io.open(deviceFile, 'r')

    if not file then return false end

    

    local content = file:read('*all')

    file:close()

    

    -- Get current device count

    local count = tonumber(content:match('DeviceCount=(%d+)'))

    if not count then return false end

    

    -- Increment count

    local newCount = count + 1

    content = content:gsub('DeviceCount=%d+', 'DeviceCount=' .. newCount)

    

    -- Add new device at the end (before PingTimeout line)

    local newDevice = string.format('\nDevice%d_Name=%s\nDevice%d_IP=%s\n', newCount, name, newCount, ip)

    content = content:gsub('(PingTimeout=)', newDevice .. '\n%1')

    

    -- Write back

    file = io.open(deviceFile, 'w')

    if not file then return false end

    file:write(content)

    file:close()

    

    return true

end



function DeleteDevice(index)

    -- Read current file

    local file = io.open(deviceFile, 'r')

    if not file then return false end

    

    local content = file:read('*all')

    file:close()

    

    -- Get current device count

    local count = tonumber(content:match('DeviceCount=(%d+)'))

    if not count or index > count then return false end

    

    -- Remove the device

    local pattern = string.format('Device%d_Name=[^\n]*\nDevice%d_IP=[^\n]*\n', index, index)

    content = content:gsub(pattern, '')

    

    -- Renumber devices after the deleted one

    for i = index + 1, count do

        local oldPrefix = 'Device' .. i

        local newPrefix = 'Device' .. (i - 1)

        content = content:gsub(oldPrefix, newPrefix)

    end

    

    -- Decrement count

    content = content:gsub('DeviceCount=%d+', 'DeviceCount=' .. (count - 1))

    

    -- Write back

    file = io.open(deviceFile, 'w')

    if not file then return false end

    file:write(content)

    file:close()

    

    return true

end



function UpdateDevice(index, name, ip)

    name = normalize_name(name)

    -- Read current file

    local file = io.open(deviceFile, 'r')

    if not file then return false end

    

    local content = file:read('*all')

    file:close()

    

    -- Update device name and IP

    content = content:gsub('Device' .. index .. '_Name=[^\n]*', 'Device' .. index .. '_Name=' .. name)

    content = content:gsub('Device' .. index .. '_IP=[^\n]*', 'Device' .. index .. '_IP=' .. ip)

    

    -- Write back

    file = io.open(deviceFile, 'w')

    if not file then return false end

    file:write(content)

    file:close()

    

    return true

end



function ClampTempName()

    local name = SKIN:GetVariable('TempDeviceName')

    name = normalize_name(name)

    SKIN:Bang('!SetVariable', 'TempDeviceName', name)

end



local function set_option(name, option, value)

    SKIN:Bang('!SetOption', name, option, value)

end



local function set_hidden(name, hidden)

    set_option(name, 'Hidden', hidden)

end



function UpdateMainLayout()

    local max = tonumber(SKIN:GetVariable('MaxDevices')) or 10

    local startY = tonumber(SKIN:GetVariable('MainRowStartY')) or 35

    local rowHeight = tonumber(SKIN:GetVariable('MainRowHeight')) or 20

    local visible = 0



    for i = 1, max do

        local name = SKIN:GetVariable('Device' .. i .. '_Name')

        local ip = SKIN:GetVariable('Device' .. i .. '_IP')

        local hidden = is_empty(name) and 1 or 0

        local labelY = startY

        local indicatorY = startY + 3



        if hidden == 0 then

            visible = visible + 1

            labelY = startY + (visible - 1) * rowHeight

            indicatorY = labelY + 3

        end



        set_hidden('Device' .. i .. 'Indicator', hidden)

        set_hidden('Device' .. i .. 'Label', hidden)

        set_hidden('Device' .. i .. 'Separator', hidden)

        set_hidden('Device' .. i .. 'IP', hidden)

        if hidden == 1 or is_empty(ip) then

            set_option('MeasurePing' .. i, 'Disabled', 1)

            set_option('MeasurePing' .. i, 'DestAddress', '')

        else

            set_option('MeasurePing' .. i, 'DestAddress', ip)

            set_option('MeasurePing' .. i, 'Disabled', 0)

        end



        set_option('Device' .. i .. 'Indicator', 'Y', indicatorY)

        set_option('Device' .. i .. 'Label', 'Y', labelY)

        set_option('Device' .. i .. 'Separator', 'Y', labelY)

        set_option('Device' .. i .. 'IP', 'Y', labelY)



        SKIN:Bang('!UpdateMeter', 'Device' .. i .. 'Indicator')

        SKIN:Bang('!UpdateMeter', 'Device' .. i .. 'Label')

        SKIN:Bang('!UpdateMeter', 'Device' .. i .. 'Separator')

        SKIN:Bang('!UpdateMeter', 'Device' .. i .. 'IP')

        SKIN:Bang('!UpdateMeasure', 'MeasurePing' .. i)

    end



    local bottomY = startY + (visible * rowHeight) + 10

    local panelW = 254

    local panelH = bottomY + 9

    SKIN:Bang('!SetVariable', 'PanelW', tostring(panelW))

    SKIN:Bang('!SetVariable', 'PanelH', tostring(panelH))

    set_option('BackgroundPanel', 'Shape', string.format('Rectangle 0,0,%d,%d,8,8 | Fill Color 16,16,16,217 | StrokeWidth 0', panelW, panelH))

    SKIN:Bang('!UpdateMeter', 'BackgroundPanel')

    set_option('LayoutBottom', 'Y', bottomY)

    SKIN:Bang('!UpdateMeter', 'LayoutBottom')

    SKIN:Bang('!Redraw')

end



function UpdateSettingsLayout()

    local max = tonumber(SKIN:GetVariable('MaxDevices')) or 10

    local startY = tonumber(SKIN:GetVariable('SettingsRowStartY')) or 180

    local rowHeight = tonumber(SKIN:GetVariable('SettingsRowHeight')) or 25

    local visible = 0



    for i = 1, max do

        local name = SKIN:GetVariable('Device' .. i .. '_Name')

        local hidden = is_empty(name) and 1 or 0

        local rowY = startY



        if hidden == 0 then

            visible = visible + 1

            rowY = startY + (visible - 1) * rowHeight

        end



        set_hidden('Device' .. i .. 'Number', hidden)

        set_hidden('Device' .. i .. 'NameDisplay', hidden)

        set_hidden('Device' .. i .. 'IPDisplay', hidden)

        set_hidden('Device' .. i .. 'DeleteButton', hidden)



        set_option('Device' .. i .. 'Number', 'Y', rowY + 2)

        set_option('Device' .. i .. 'NameDisplay', 'Y', rowY)

        set_option('Device' .. i .. 'IPDisplay', 'Y', rowY)

        set_option('Device' .. i .. 'DeleteButton', 'Y', rowY)



        set_option('MeasureInputDevice' .. i .. 'Name', 'Y', rowY)

        set_option('MeasureInputDevice' .. i .. 'IP', 'Y', rowY)



        SKIN:Bang('!UpdateMeter', 'Device' .. i .. 'Number')

        SKIN:Bang('!UpdateMeter', 'Device' .. i .. 'NameDisplay')

        SKIN:Bang('!UpdateMeter', 'Device' .. i .. 'IPDisplay')

        SKIN:Bang('!UpdateMeter', 'Device' .. i .. 'DeleteButton')

    end



    local footerY = startY + (visible * rowHeight) + 20

    set_option('Separator3', 'Y', footerY)

    set_option('InfoText', 'Y', footerY + 8)

    local rowY = footerY + 24

    set_option('KoFiPrefix', 'Y', rowY)

    set_option('KoFiKave', 'Y', rowY)

    set_option('KoFiSuffix', 'Y', rowY)

    set_option('CloseButton', 'Y', rowY)

    local panelW = 382

    local panelH = (rowY + 22) + 14

    SKIN:Bang('!SetVariable', 'PanelW', tostring(panelW))

    SKIN:Bang('!SetVariable', 'PanelH', tostring(panelH))

    set_option('BackgroundPanel', 'Shape', string.format('Rectangle 0,0,%d,%d,8,8 | Fill Color 16,16,16,217 | StrokeWidth 0', panelW, panelH))

    SKIN:Bang('!UpdateMeter', 'BackgroundPanel')

    set_option('LayoutBottomSettings', 'Y', rowY + 22)



    SKIN:Bang('!UpdateMeter', 'Separator3')

    SKIN:Bang('!UpdateMeter', 'InfoText')

    SKIN:Bang('!UpdateMeter', 'KoFiPrefix')

    SKIN:Bang('!UpdateMeter', 'KoFiKave')

    SKIN:Bang('!UpdateMeter', 'KoFiSuffix')

    SKIN:Bang('!UpdateMeter', 'CloseButton')

    SKIN:Bang('!UpdateMeter', 'LayoutBottomSettings')

    SKIN:Bang('!Redraw')

end

