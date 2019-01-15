local Seller = Seller or {};

Seller.frame = CreateFrame("Frame", "Seller", UIParent);
Seller.frame:SetFrameStrata("BACKGROUND");

function Seller:sellItem (bag, slot, item)
  local price    = select(11, GetItemInfo(item));
  local quantity, _, _, _, _, _, _, noValue = select(2, GetContainerItemInfo(bag, slot));

  if (not noValue) then
    UseContainerItem(bag, slot);
  end
  
  return price * quantity;
end

function Seller:sellAllGrays(event, ...)
  local sum = 0;

  for bag = 0, 4 do
    for slot = 1, GetContainerNumSlots(bag) do
      local item = GetContainerItemID(bag, slot);

      if (item and 0 == select(3, GetItemInfo(item))) then
        sum = sum + Seller:sellItem(bag, slot, item);
      end
    end
  end

  if (sum ~= 0) then
    print("Selling gray items for", GetCoinTextureString(sum));
  end
end

Seller.frame:SetScript("OnEvent", Seller.sellAllGrays);

Seller.frame:RegisterEvent("MERCHANT_SHOW");