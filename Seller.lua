local Seller = Seller or {};

Seller.frame = CreateFrame("Frame", "Seller", UIParent);
Seller.frame:SetFrameStrata("BACKGROUND");

Seller.frame:SetScript("OnEvent",
  function (self, event, ...)
    local sum = 0;

    for bag = 0, 4 do
      for slot = 1, GetContainerNumSlots(bag) do
        local item = GetContainerItemID(bag, slot);

        if (item and 0 == select(3, GetItemInfo(item))) then
          local price    = select(11, GetItemInfo(item));
          local quantity = select(2, GetContainerItemInfo(bag, slot));

          sum = sum + price * quantity;
          UseContainerItem(bag, slot);
        end
      end
    end

    if (sum ~= 0) then
      print("Selling gray items for", GetCoinTextureString(sum));
    end
  end
);

Seller.frame:RegisterEvent("MERCHANT_SHOW");