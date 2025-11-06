-- File: 56-a2dp-only.lua
-- Цель: Блокирует профили HSP/HFP (низкое качество/микрофон) для всех устройств Bluetooth.
-- Это предотвращает переключение на "унитазный" звук.

rule = {
  matches = {
    {
      -- Применить ко всем устройствам Bluetooth
      { "device.bus", "equals", "bluetooth" },
    },
  },
  actions = {
    [ "update-props" ] = {
      -- Разрешаем только A2DP (Sink) и LDAC, явно блокируя HFP/HSP.
      ["bluez5.profiles"] = "[ a2dp_sink a2dp_source ldac_sink ]", 
      
      -- Делаем A2DP профилем по умолчанию
      ["bluez5.default.profile"] = "a2dp_sink",
      
      -- Запрещаем автоматическое переключение на HFP/HSP
      ["bluez5.auto-connect-profiles"] = [ "a2dp_sink" ],
    },
  }
}
