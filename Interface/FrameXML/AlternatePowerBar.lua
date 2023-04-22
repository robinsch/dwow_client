ADDITIONAL_POWER_BAR_NAME = "MANA";
ADDITIONAL_POWER_BAR_INDEX = 0;

function AlternatePowerBar_OnLoad(self)
	self.textLockable = 1;
	self.cvar = "playerStatusText";
	self.cvarLabel = "STATUS_TEXT_PLAYER";
	AlternatePowerBar_Initialize(self);
	TextStatusBar_Initialize(self);
end

function AlternatePowerBar_Initialize(self)
	if ( not self.powerName ) then
		self.powerName = ADDITIONAL_POWER_BAR_NAME;
		self.powerIndex = ADDITIONAL_POWER_BAR_INDEX;
	end

	local secondaryClass = UnitClassSecondary("player");
	-- Warrior (Rage)
	if ( secondaryClass == 1 ) then
		self.powerName = "RAGE";
		self.powerIndex = 1;
	-- Rogue (Energy)
	elseif ( secondaryClass == 4 ) then
		self.powerName = "ENERGY";
		self.powerIndex = 3;
	end
	
	self:RegisterEvent("UNIT_"..self.powerName);
	self:RegisterEvent("UNIT_MAX"..self.powerName);
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("UNIT_DISPLAYPOWER");
	
	SetTextStatusBarText(self, _G[self:GetName().."Text"])
	
	local info = PowerBarColor[self.powerName];
	self:SetStatusBarColor(info.r, info.g, info.b);
end

function AlternatePowerBar_OnEvent(self, event, arg1)
	local parent = self:GetParent();
	if ( event == "UNIT_DISPLAYPOWER" ) then
		AlternatePowerBar_UpdatePowerType(self);
	elseif ( event=="PLAYER_ENTERING_WORLD" ) then
		AlternatePowerBar_Initialize(self);
		AlternatePowerBar_UpdatePowerType(self);
		AlternatePowerBar_UpdateMaxValues(self);
		AlternatePowerBar_UpdateValue(self);
	elseif( (event == "UNIT_MAXMANA" or event == "UNIT_MAXRAGE" or event == "UNIT_MAXENERGY") and (arg1 == parent.unit) ) then
		AlternatePowerBar_UpdateMaxValues(self);
	elseif ( self:IsShown() ) then
		if ( (event == "UNIT_MANA" or event == "UNIT_RAGE" or event == "UNIT_ENERGY") and (arg1 == parent.unit) ) then
			AlternatePowerBar_UpdateValue(self);
		end
	end
end

function AlternatePowerBar_OnUpdate(self, elapsed)
	AlternatePowerBar_UpdateValue(self);
end

function AlternatePowerBar_UpdateValue(self)
	local currmana = UnitPower(self:GetParent().unit,self.powerIndex);
	self:SetValue(currmana);
	self.value = currmana
end

function AlternatePowerBar_UpdateMaxValues(self)
	local maxmana = UnitPowerMax(self:GetParent().unit,self.powerIndex);
	self:SetMinMaxValues(0,maxmana);
end

function AlternatePowerBar_UpdatePowerType(self)
	if ( (UnitPowerType(self:GetParent().unit) ~= self.powerIndex) and (UnitPowerMax(self:GetParent().unit,self.powerIndex) ~= 0) ) then
		self.pauseUpdates = false;
		self:Show();
	else
		self.pauseUpdates = true;
		self:Hide();
	end
end
