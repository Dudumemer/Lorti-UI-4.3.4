﻿
  ---------------------------------------
  -- ACTIONS
  ---------------------------------------

  -- REMOVING UGLY PARTS OF UI
	local event_frame = CreateFrame('Frame')
	local errormessage_blocks = {
	  'Способность пока недоступна',
	  'Выполняется другое действие',
	  'Невозможно делать это на ходу',
	  'Предмет пока недоступен',
	  'Недостаточно',
	  'Некого атаковать',
	  'Заклинание пока недоступно',
	  'У вас нет цели',
	  'Вы пока не можете этого сделать',

	  'Ability is not ready yet',
 	  'Another action is in progress',
	  'Can\'t attack while mounted',
	  'Can\'t do that while moving',
	  'Item is not ready yet',
	  'Not enough',
	  'Nothing to attack',
	  'Spell is not ready yet',
	  'You have no target',
	  'You can\'t do that yet',
	}
	local enable
	local onevent
	local uierrorsframe_addmessage
	local old_uierrosframe_addmessage
	function enable ()
  		old_uierrosframe_addmessage = UIErrorsFrame.AddMessage
  		UIErrorsFrame.AddMessage = uierrorsframe_addmessage
	end

	function uierrorsframe_addmessage (frame, text, red, green, blue, id)
  		for i,v in ipairs(errormessage_blocks) do
    			if text and text:match(v) then
      				return
    			end
  		end
  	old_uierrosframe_addmessage(frame, text, red, green, blue, id)
	end

	function onevent (frame, event, ...)
  		if event == 'PLAYER_LOGIN' then
    			enable()
  		end
	end
	event_frame:SetScript('OnEvent', onevent)
	event_frame:RegisterEvent('PLAYER_LOGIN')
	
  -- REWORKING THE MINIMAP
	local CF=CreateFrame("Frame")
	CF:RegisterEvent("PLAYER_ENTERING_WORLD")
	CF:SetScript("OnEvent", function(self, event)
		if not (IsAddOnLoaded("SexyMap")) then
			for i,v in pairs({
				MinimapBorder,
				MiniMapMailBorder,
				QueueStatusMinimapButtonBorder,
				select(1, TimeManagerClockButton:GetRegions()), 
				select(1, GameTimeFrame:GetRegions()),
              		}) do
                 		v:SetVertexColor(.05, .05, .05)
			end    
			MinimapBorderTop:Hide()
			MinimapZoomIn:Hide()
			MinimapZoomOut:Hide()
			MiniMapWorldMapButton:Hide()
			GameTimeFrame:Hide()
			GameTimeFrame:UnregisterAllEvents()
			GameTimeFrame.Show = kill
--			MiniMapTracking:Hide()
			MiniMapTracking.Show = kill
			MiniMapTracking:UnregisterAllEvents()
			Minimap:EnableMouseWheel(true)
			Minimap:SetScript("OnMouseWheel", function(self, z)
				local c = Minimap:GetZoom()
				if(z > 0 and c < 5) then
					Minimap:SetZoom(c + 1)
				elseif(z < 0 and c > 0) then
					Minimap:SetZoom(c - 1)
				end
			end)
			Minimap:SetScript("OnMouseUp", function(self, btn)
				if btn == "RightButton" then
					_G.GameTimeFrame:Click()
				elseif btn == "MiddleButton" then
					_G.ToggleDropDownMenu(1, nil, _G.MiniMapTrackingDropDown, self)
				else
					_G.Minimap_OnClick(self)
				end
			end)
		end
	end)

  -- COLORING FRAMES
	local CF=CreateFrame("Frame")
	CF:RegisterEvent("PLAYER_ENTERING_WORLD")
	CF:SetScript("OnEvent", function(self, event)
		if not (IsAddOnLoaded("Shadowed Unit Frames") or IsAddOnLoaded("PitBull Unit Frames 4.0") or IsAddOnLoaded("X-Perl UnitFrames")) then
                	for i,v in pairs({
				PlayerFrameTexture,
   				TargetFrameTextureFrameTexture,
  				PetFrameTexture,
        PlayerFrameAlternateManaBarBorder,
				PartyMemberFrame1Texture,
				PartyMemberFrame2Texture,
				PartyMemberFrame3Texture,
				PartyMemberFrame4Texture,
				PartyMemberFrame1PetFrameTexture,
				PartyMemberFrame2PetFrameTexture,
				PartyMemberFrame3PetFrameTexture,
				PartyMemberFrame4PetFrameTexture,
   				FocusFrameTextureFrameTexture,
   				TargetFrameToTTextureFrameTexture,
   				FocusFrameToTTextureFrameTexture,
				Boss1TargetFrameTextureFrameTexture,
				Boss2TargetFrameTextureFrameTexture,
				Boss3TargetFrameTextureFrameTexture,
				Boss4TargetFrameTextureFrameTexture,
				Boss5TargetFrameTextureFrameTexture,
				Boss1TargetFrameSpellBarBorder,
				Boss2TargetFrameSpellBarBorder,
				Boss3TargetFrameSpellBarBorder,
				Boss4TargetFrameSpellBarBorder,
				Boss5TargetFrameSpellBarBorder,
				select(5, ShardBarFrameShard1:GetRegions()),
            			select(5, ShardBarFrameShard2:GetRegions()),
            			select(5, ShardBarFrameShard3:GetRegions()),
--				select(5, ShardBarFrameShard4:GetRegions()),
--				select(1, BurningEmbersBarFrame:GetRegions()),
--				select(1, BurningEmbersBarFrameEmber1:GetRegions()),
--            			select(1, BurningEmbersBarFrameEmber2:GetRegions()),
--            			select(1, BurningEmbersBarFrameEmber3:GetRegions()),
--				select(1, BurningEmbersBarFrameEmber4:GetRegions()),
            			select(1, PaladinPowerBar:GetRegions()),
				CastingBarFrameBorder,
				FocusFrameSpellBarBorder,
				TargetFrameSpellBarBorder,
			}) do
                 		v:SetVertexColor(.05, .05, .05)
			end
  
			for i,v in pairs({
				PlayerPVPIcon,
				TargetFrameTextureFramePVPIcon,
				FocusFrameTextureFramePVPIcon,
			}) do
				v:SetAlpha(0)
			end
--			for i=1,4 do 
----				_G["PartyMemberFrame"..i.."PVPIcon"]:SetAlpha(0)
--				_G["PartyMemberFrame"..i.."NotPresentIcon"]:Hide()
--				_G["PartyMemberFrame"..i.."NotPresentIcon"].Show = function() end
--			end
			PlayerFrameGroupIndicator:SetAlpha(0)
			PlayerHitIndicator:SetText(nil) 
			PlayerHitIndicator.SetText = function() end
			PetHitIndicator:SetText(nil) 
			PetHitIndicator.SetText = function() end
		else
			CastingBarFrameBorder:SetVertexColor(.05,.05,.05)    
		end
  
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        	CF:SetScript("OnEvent", nil)
	end)
    
 -- COLORING THE MAIN BAR
	for i,v in pairs({
		SlidingActionBarTexture0,
		
		SlidingActionBarTexture1,
		BonusActionBarFrameTexture1,
    BonusActionBarFrameTexture2,
    BonusActionBarFrameTexture3,
    BonusActionBarFrameTexture4,
        	MainMenuBarTexture0,
		MainMenuBarTexture1,
		MainMenuBarTexture2,
		MainMenuBarTexture3,
        	MainMenuMaxLevelBar0,
        	MainMenuMaxLevelBar1,
		MainMenuMaxLevelBar2,
		MainMenuMaxLevelBar3,
		MainMenuXPBarTextureLeftCap,
		MainMenuXPBarTextureRightCap,
		MainMenuXPBarTextureMid,
		ReputationWatchBarTexture0,
		ReputationWatchBarTexture1,
		ReputationWatchBarTexture2,
		ReputationWatchBarTexture3,
		ReputationXPBarTexture0,
		ReputationXPBarTexture1,
		ReputationXPBarTexture2,
		ReputationXPBarTexture3,	
	}) do

                 v:SetVertexColor(.2, .2, .2)
  
	end 	
	for i=1,19 do _G["MainMenuXPBarDiv"..i]:SetTexture(Empty_Art) end
	ExhaustionTick:SetAlpha(0)
        for i,v in pairs({
		MainMenuBarLeftEndCap,
                MainMenuBarRightEndCap, 
		StanceBarLeft,
		
		StanceBarMiddle,
		
		StanceBarRight, 
    ShapeshiftBarLeft,
    ShapeshiftBarMiddle,
    ShapeshiftBarRight,
	}) do
                v:SetVertexColor(.35, .35, .35)
	end 
 -- COLORING ARENA FRAMES
	local CF = CreateFrame("Frame")
	local _, instanceType = IsInInstance()
	CF:RegisterEvent("ADDON_LOADED")
	CF:RegisterEvent("PLAYER_ENTERING_WORLD")
	CF:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
        CF:SetScript("OnEvent", function(self, event, addon)
             	if addon == "Blizzard_ArenaUI" and not (IsAddOnLoaded("Shadowed Unit Frames")) then
			for i,v in pairs({
 				ArenaEnemyFrame1Texture,
				ArenaEnemyFrame2Texture,
				ArenaEnemyFrame3Texture, 
				ArenaEnemyFrame4Texture,
				ArenaEnemyFrame5Texture,
				ArenaEnemyFrame1SpecBorder,
				ArenaEnemyFrame2SpecBorder,
				ArenaEnemyFrame3SpecBorder,
				ArenaEnemyFrame4SpecBorder,
				ArenaEnemyFrame5SpecBorder,
				ArenaEnemyFrame1PetFrameTexture,
				ArenaEnemyFrame2PetFrameTexture,
				ArenaEnemyFrame3PetFrameTexture,
				ArenaEnemyFrame4PetFrameTexture, 
				ArenaEnemyFrame5PetFrameTexture,
              		}) do
                		v:SetVertexColor(.05, .05, .05)
	      		end 
		elseif event == "ARENA_PREP_OPPONENT_SPECIALIZATIONS" or (event == "PLAYER_ENTERING_WORLD" and instanceType == "arena") then
			for i,v in pairs({
				ArenaPrepFrame1Texture,
				ArenaPrepFrame2Texture,
				ArenaPrepFrame3Texture,
				ArenaPrepFrame4Texture,
				ArenaPrepFrame5Texture,
				ArenaPrepFrame1SpecBorder,
				ArenaPrepFrame2SpecBorder,
				ArenaPrepFrame3SpecBorder,
				ArenaPrepFrame4SpecBorder,
				ArenaPrepFrame5SpecBorder,
			}) do
                		v:SetVertexColor(.05, .05, .05)
	      		end 		
		end 
	end)
  
  ConsolidatedBuffsTooltip:SetScript("OnShow", function(self)
    for i = 1, self:GetNumRegions() do
      local CBTregion = select(i, self:GetRegions())
      CBTregion:SetVertexColor(0, 0, 0, .95)
    end
  end)

  hooksecurefunc("UnitFramePortrait_Update",function(self)
    if self.portrait then
      if UnitIsPlayer(self.unit) then			
        local t = CLASS_ICON_TCOORDS[select(2,UnitClass(self.unit))]
        if t then
          self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
          self.portrait:SetTexCoord(unpack(t))
        end
      else
        self.portrait:SetTexCoord(0,1,0,1)
      end
    end
  end)

_G["PlayerFrame_UpdateStatus"] = function()
	if ( UnitHasVehiclePlayerFrameUI("player") ) then
		PlayerStatusTexture:Hide()
		PlayerRestIcon:Hide()
		PlayerAttackIcon:Hide()
		PlayerRestGlow:Hide()
		PlayerAttackGlow:Hide()
		PlayerStatusGlow:Hide()
		PlayerAttackBackground:Hide()
	elseif ( IsResting() ) then
		PlayerStatusTexture:SetVertexColor(.8, .8, .8, 1.0);
		PlayerStatusTexture:Show();
		PlayerRestIcon:Show();
		PlayerAttackIcon:Hide();
		PlayerRestGlow:Show();
		PlayerAttackGlow:Hide();
		PlayerStatusGlow:Show();
		PlayerStatusGlow:GetRegions():SetVertexColor(.8, .8, .8, 1.0);
		PlayerAttackBackground:Hide();
	elseif ( PlayerFrame.inCombat ) then
		PlayerStatusTexture:SetVertexColor(1.0, 0.0, 0.0, 1.0);
		PlayerStatusTexture:Show();
		PlayerAttackIcon:Show();
		PlayerRestIcon:Hide();
		PlayerAttackGlow:Show();
		PlayerRestGlow:Hide();
		PlayerStatusGlow:Show();
		PlayerAttackBackground:Show();
	elseif ( PlayerFrame.onHateList ) then
		PlayerAttackIcon:Show();
		PlayerRestIcon:Hide();
		PlayerStatusGlow:Hide();
		PlayerAttackBackground:Hide();
	else
		PlayerStatusTexture:Hide();
		PlayerRestIcon:Hide();
		PlayerAttackIcon:Hide();
		PlayerStatusGlow:Hide();
		PlayerAttackBackground:Hide();
	end
end