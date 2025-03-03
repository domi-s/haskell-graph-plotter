-- Method 1: Each character represents an individual block. See how many points of the function, given a precision, are in the block. The more points, the darker the block.
-- This is a previous version that does not look good on some graphs. It is kept here for reference.

f x = x
g x = x + 1
h x = x * x
f' x = (x * x / 5) + 2 * x + 1

pointsPerUnit = 100 :: Int -- Points per unit
precision :: Double
precision = 1 / fromIntegral pointsPerUnit -- Precision of points
rangeX = 20 :: Int -- Range of points (width and height)
rangeY = 10 :: Int

-- Stroke widths
strokeWidths = reverse "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/\\|()1{}[]?-_+~<>i!lI;:,\"^`'. "

matchesInPoint :: Double -> Double -> (Double -> Double) -> Int
matchesInPoint x y f =
    sum $
    map (\b -> if b then 1 else 0) $
    -- Check if the function f matches the point (x, y)
    map (\dx -> y <= f (x + dx) && f (x + dx) < y + 1) $
    -- Generate points in the range of the point
    map (\i -> i * precision) $
    map fromIntegral [0..pointsPerUnit - 1]

matchesInPointSmooth :: Double -> Double -> (Double -> Double) -> Int
matchesInPointSmooth x y f =
    let deltas = [-1, 0, 1] in
    let p00 = matchesInPoint x y f in
    let deltaPoints = [(dx, dy) | dx <- deltas, dy <- deltas] in
    let neighbours = map (\(dx, dy) -> matchesInPoint (x + dx) (y + dy) f) deltaPoints in

    sum neighbours * 10 `div` (length strokeWidths) `div` 9 + p00

weightedMatchesInPoint :: Double -> Double -> (Double -> Double) -> Double
weightedMatchesInPoint x y f =
    sum $
    map (\dx -> let fy = f (x + dx)
                in max 0 (1 - abs (fy - (y + 0.5)))) $
    map (\i -> fromIntegral i * precision) [0..pointsPerUnit - 1]

-- charAtPoint :: Double -> Double -> (Double -> Double) -> Char
-- charAtPoint x y f = strokeWidths !! min (length strokeWidths - 1) ((matchesInPointSmooth x y f) * (length strokeWidths) `div` pointsPerUnit)

charAtPoint :: Double -> Double -> (Double -> Double) -> Char
charAtPoint x y f =
    let maxWeight = fromIntegral pointsPerUnit -- Normalization factor
        weight = weightedMatchesInPoint x y f / maxWeight
        intensity = round (weight * fromIntegral (length strokeWidths - 1))
    in strokeWidths !! max 0 (min (length strokeWidths - 1) intensity)

plotLine :: Int -> (Double -> Double) -> String
plotLine y f = 
    -- concat $ map (\c -> replicate 2 c) $
    map (\x -> charAtPoint (fromIntegral x) (fromIntegral (-y)) f) [- (rangeX `div` 4) .. (rangeX `div` 4)]

plot :: (Double -> Double) -> String
plot f = unlines $ map (\y -> plotLine y f) [- (rangeY `div` 2) .. (rangeY `div` 2)]
