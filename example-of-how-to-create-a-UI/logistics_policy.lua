local M = {}
M.MODE = {
  DELIVER = "deliver",
  REPOSITION = "reposition",
  IDLE = "idle",
}
local SKIP_BONUS = 1.0
local function pair_key(src, dst)
  return src .. "|" .. dst
end
function M.build_transfer_map(stock, routes, itemWeights, itemCategories)
  local to_transfer, details = {}, {}
  for _, route in ipairs(routes or {}) do
    if route.from == nil or route.to == nil then
      details[#details + 1] = { item = route.item, from = route.from, to = route.to, amount = 0, item_weight = nil }
    else
      local fromBucket = stock[route.from]
      local have = (fromBucket and fromBucket[route.item]) or 0
      local keepMin = route.keep_min or 0
      local available = have - keepMin
      local toBucket = stock[route.to]
      local destHave = (toBucket and toBucket[route.item]) or 0
      local room = math.huge
      if route.keep_max ~= nil then
        room = route.keep_max - destHave
      end
      local amount = math.max(math.min(available, room), 0)
      local itemWeight = itemWeights and itemWeights[route.item]
      local itemCategory = itemCategories and itemCategories[route.item]
      if amount > 0 then
        local weight = (itemWeight ~= nil and itemWeight > 0) and (amount * itemWeight) or nil
        to_transfer[route.from] = to_transfer[route.from] or {}
        local bucket = to_transfer[route.from][route.to]
        if bucket == nil then
          bucket = { items = {}, totalWeight = 0 }
          to_transfer[route.from][route.to] = bucket
        end
        bucket.items[#bucket.items + 1] = {
          item = route.item, amount = amount, item_weight = itemWeight, weight = weight, category = itemCategory,
        }
        bucket.totalWeight = bucket.totalWeight + (weight or 0)
      end
      details[#details + 1] = {
        item = route.item, from = route.from, to = route.to,
        amount = amount, item_weight = itemWeight,
      }
    end
  end
  return to_transfer, details
end
local function score(skipped, key, totalWeight)
  local skips = skipped[key] or 0
  return totalWeight * (1 + skips * SKIP_BONUS)
end
local function sorted_keys(t)
  local keys = {}
  for k in pairs(t) do keys[#keys + 1] = k end
  table.sort(keys)
  return keys
end
function M.decide_next_hop(current_base, to_transfer, skipped)
  skipped = skipped or {}
  local outgoing = current_base and to_transfer[current_base]
  if outgoing ~= nil then
    local bestDst, bestScore, bestKey = nil, -1, nil
    for _, dst in ipairs(sorted_keys(outgoing)) do
      local key = pair_key(current_base, dst)
      local s = score(skipped, key, outgoing[dst].totalWeight)
      if s > bestScore then
        bestScore, bestDst, bestKey = s, dst, key
      end
    end
    if bestDst ~= nil then
      return { mode = M.MODE.DELIVER, src = current_base, dst = bestDst, pair = outgoing[bestDst], key = bestKey }
    end
  end
  local bestSrc, bestDst, bestScore, bestKey = nil, nil, -1, nil
  for _, src in ipairs(sorted_keys(to_transfer)) do
    for _, dst in ipairs(sorted_keys(to_transfer[src])) do
      local key = pair_key(src, dst)
      local s = score(skipped, key, to_transfer[src][dst].totalWeight)
      if s > bestScore then
        bestScore, bestSrc, bestDst, bestKey = s, src, dst, key
      end
    end
  end
  if bestSrc ~= nil then
    return { mode = M.MODE.REPOSITION, src = bestSrc, dst = bestDst, pair = to_transfer[bestSrc][bestDst], key = bestKey }
  end
  return { mode = M.MODE.IDLE }
end
function M.update_skipped(to_transfer, skipped, chosenKey)
  skipped = skipped or {}
  local next_skipped = {}
  for src, dsts in pairs(to_transfer) do
    for dst in pairs(dsts) do
      local key = pair_key(src, dst)
      if key == chosenKey then
        next_skipped[key] = 0
      else
        next_skipped[key] = (skipped[key] or 0) + 1
      end
    end
  end
  return next_skipped
end
return M
