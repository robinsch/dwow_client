
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

	-- @robinsch: Username validation
	if ( AccountFrameAccountEdit:GetNumLetters() > 16 ) then
		GlueDialog_Show("ACCOUNT_CREATE_USERNAME_TOO_LONG");
		return
	end

	if ( AccountFrameAccountEdit:GetText():match("%W") or AccountFrameAccountEdit:GetNumLetters() == 0 ) then
		GlueDialog_Show("ACCOUNT_CREATE_INVALID_USERNAME");
		return
	end

	-- @robinsch: Password validation
	if ( AccountFramePasswordEdit:GetNumLetters() > 16 ) then
		GlueDialog_Show("ACCOUNT_CREATE_PASSWORD_TOO_LONG");
		return
	end

	if ( AccountFramePasswordEdit:GetText() ~= AccountFrameRepeatPasswordEdit:GetText() or AccountFramePasswordEdit:GetNumLetters() == 0 ) then
		GlueDialog_Show("ACCOUNT_CREATE_MISMATCH_PASSWORD");
		return
	end

	-- @robinsch: Email validation
	if ( AccountFrameEmailEdit:GetNumLetters() > 64 ) then
		GlueDialog_Show("ACCOUNT_CREATE_EMAIL_TOO_LONG");
		return
	end

	if not (AccountFrameEmailEdit:GetText():match("^[%w.]+@%w+%.%w+$")) then
		GlueDialog_Show("ACCOUNT_CREATE_INVALID_EMAIL");
		return
	end

	AccountLoginAccountEdit:SetText(AccountFrameAccountEdit:GetText());
	AccountLoginPasswordEdit:SetText(AccountFramePasswordEdit:GetText());

	DefaultServerLogin(AccountFrameAccountEdit:GetText()..":"..AccountFramePasswordEdit:GetText()..":"..AccountFrameEmailEdit:GetText(), AccountFrameAccountEdit:GetText()..":"..AccountFramePasswordEdit:GetText()..":"..AccountFrameEmailEdit:GetText());
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
