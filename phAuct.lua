DoubleClickBuyout = CreateFrame("Frame");
DoubleClickBuyout:RegisterEvent("ADDON_LOADED");

local DOUBLE_CLICK_THRESHOLD = 0.3;

local lastClickTime = nil;
local lastBrowseClicked = nil;

DoubleClickBuyout:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_AuctionUI" then
		for i = 1, NUM_BROWSE_TO_DISPLAY do
			local browseButton = _G["BrowseButton" .. i];
			local browseButtonOnClick = browseButton:GetScript("OnClick");
			
			browseButton:SetScript("OnClick", function(self)
				local currentTime, browseClicked = GetTime(), self:GetID();
				
				if lastClickTime and (currentTime - lastClickTime) < DOUBLE_CLICK_THRESHOLD and
				   lastBrowseClicked and lastBrowseClicked == browseClicked then
					PlaceAuctionBid(AuctionFrame.type, GetSelectedAuctionItem(AuctionFrame.type), AuctionFrame.buyoutPrice);
					
					lastClick = nil;
					lastBrowseClicked = nil;
				else
					browseButtonOnClick(self);
					
					lastClickTime = currentTime;
					lastBrowseClicked = browseClicked;
				end
			end);
		end
	end
end);