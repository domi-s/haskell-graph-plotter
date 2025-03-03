# Graph plotter in Haskell

**By Dominic Satnoianu**

This is a simple graph plotter written in Haskell. It uses the basic Prelude functions to generate a string that represents the graph. The graph is then printed to the console.

## Usage

To use the graph plotter, you need to call the `plot` function with a function to plot. The function should take a single argument of type `Double` and return a `Double`; more precisely, the function should represent the y value of the graph at a given x value.

Here is an example of how to use the graph plotter (`main.hs`):

```bash
$ ghci -i main.hs
ghci> putStrLn $ plot (\x -> x*x / 100)
 *.                                           @                  
  =-                                        .*                   
   -=                                      -=                    
    .@                                    *-                     
      *-                                .@                       
       -@                              *=                        
         *=                          -@                          
           @=                      -@.                           
             *@.                 @@                              
               .@@=          -@@-                                
                   -@@@@@@@@=
```

Other cool graphs (sometimes scaling is needed):

```bash
putStrLn $ plot (\x -> sin (x / 2))
putStrLn $ plot (\x -> 1 / (x / 10))
```

## How it works

The code itself is not too complicated. Each character can be seen as a range around a point, where we count how many points are close to the character's y-coordinate.

Based on this value, we have an shade for the character — darker when there are more points close to it, and lighter when there are fewer points (or even blank when there are no points).

I chose a functional approach to this problem, as it seemed to be the most natural way to solve it. The code is simple and easy to understand, and it is also easy to modify and extend.

The previous version of the code, `method1.hs`, is the initial draft that can be used as reference. It tried to count the exact points inside a block (character) and then print the character based on the count. It meant that some functions that change quickly would not be plotted nicely.

## License and issues

This code is licensed under the MIT license. The code was written by Dominic Satnoianu in 2025.

If you have any issues with the code, please open an issue on the GitHub repository. You can also contribute to the code by opening a pull request.