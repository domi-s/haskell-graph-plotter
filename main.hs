import Data.List (intercalate)

-- Functions to plot
f x = x
g x = x + 1
h x = x * x
f' x = (x * x / 5) + 2 * x + 1

xMin, xMax :: Int
xMin = -40
xMax = 40

yMin, yMax :: Int
yMin = -10
yMax = 10

charWidth, charHeight :: Double
charWidth = 1.0
charHeight = 0.5

threshold :: Double
threshold = 0.2

samplesPerChar :: Int
samplesPerChar = 5

-- Darkness levels (light to dark)
shades :: String
shades = " .:-=+*#@"

-- Check how close the function passes near (x, y)
graphIntensity :: (Double -> Double) -> Int -> Int -> Int
graphIntensity f x y =
    let sampleXs = [fromIntegral x + (fromIntegral dx / fromIntegral samplesPerChar) | dx <- [0 .. samplesPerChar - 1]] in
    let sampleYs = map f sampleXs in
    let matchCount = length (filter (\yVal -> abs (yVal - (fromIntegral y * charHeight)) < threshold) sampleYs) in
    
    (matchCount * (length shades - 1)) `div` samplesPerChar

plotRow :: (Double -> Double) -> Int -> String
plotRow f y = [shades !! graphIntensity f x y | x <- [xMin .. xMax]]

plot :: (Double -> Double) -> String
plot f = intercalate "\n" [plotRow f y | y <- reverse [yMin .. yMax]]

main :: IO ()
main = putStrLn (plot (\x -> x * x / 100))