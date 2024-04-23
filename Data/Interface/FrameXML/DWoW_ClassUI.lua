StaticPopupDialogs["POPUP_EXTENSIONS"] = {
    text = "Couldn\'t load |cffFF8800Extensions.dll|r.\n\nPlease visit |cffFF8800https://github.com/robinsch/dwow_client|r for more details.",
    button1 = "Exit Game",
    OnAccept = function()
        ForceQuit();
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

PickClassFrame:RegisterEvent("ADDON_LOADED")

-- @robinsch: check if DLL lua API is injected
function CheckDLL(self)
    return SetClassSecondary and UnitClassSecondary and UnitHasManaSecondary;
end

PickClassFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        if not CheckDLL() then
            return StaticPopup_Show("POPUP_EXTENSIONS")
        end
    end
end)

local function OnTextChangedHandler(self, leftText, rightText)
   local level, race, class, unitType = string.match(leftText, "Level (%d+) (%w+) (%w+) %(Player%)")
   if level and race and class then
      return string.format("Level %d %s %s / %s (Player)", level, race, class, UnitClassSecondaryName(self:GetUnit()))
   end
end

GameTooltip:OnTextChanged(OnTextChangedHandler)
