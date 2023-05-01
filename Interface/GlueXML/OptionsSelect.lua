
function OptionsSelectFrame_Hide()
	PlaySound("gsLoginChangeRealmCancel");
	OptionsSelectFrame:Hide();
end

function OptionsSelectResetSettingsButton_OnClick_Reset(self)
	PlaySound("igMainMenuOptionCheckBoxOn");
	GlueDialog_Show("RESET_SERVER_SETTINGS");
end

function OptionsSelectResetSettingsButton_OnClick_Cancel(self)
	PlaySound("igMainMenuOptionCheckBoxOn");
	GlueDialog_Show("CANCEL_RESET_SETTINGS");
end

function AccountCreateFrame_Hide()
	PlaySound("gsLoginChangeRealmCancel");
	AccountCreateFrame:Hide();
end

function AccountCreate_Exit()
	PlaySound("gsLoginChangeRealmCancel");
	AccountCreateFrame:Hide();
	AccountLoginUI:Show();
end

function AccountCreate_FocusAccountName()
	AccountFrameAccountEdit:SetFocus();
end

function AccountCreate_FocusPassword()
	AccountFramePasswordEdit:SetFocus();
end

function AccountCreate_Create()
	PlaySound("gsLogin");
	DefaultServerLogin(AccountFrameAccountEdit:GetText()..":"..AccountFramePasswordEdit:GetText()..":"..AccountFrameEmailEdit:GetText(), "$cmd:create_account");
end

function AccountCreate_FocusRepeatPassword()
	AccountFrameRepeatPasswordEdit:SetFocus();
end

function AccountCreate_FocusEmail()
	AccountFrameEmailEdit:SetFocus();
end

function AccountCreate_OnLoad()
	-- Color edit box backdrops
	local backdropColor = DEFAULT_TOOLTIP_COLOR;
	AccountFrameAccountEdit:SetBackdropBorderColor(backdropColor[1], backdropColor[2], backdropColor[3]);
	AccountFrameAccountEdit:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6]);
	AccountFramePasswordEdit:SetBackdropBorderColor(backdropColor[1], backdropColor[2], backdropColor[3]);
	AccountFramePasswordEdit:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6]);
	AccountFrameRepeatPasswordEdit:SetBackdropBorderColor(backdropColor[1], backdropColor[2], backdropColor[3]);
	AccountFrameRepeatPasswordEdit:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6]);
	AccountFrameEmailEdit:SetBackdropBorderColor(backdropColor[1], backdropColor[2], backdropColor[3]);
	AccountFrameEmailEdit:SetBackdropColor(backdropColor[4], backdropColor[5], backdropColor[6]);
end
