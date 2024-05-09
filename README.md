99ify makes addictive websites load at 1999 internet speed.

## What's the point?
The goal is to give you more control over your attention.

You can use 99ify to slow down websites that you find distracting or addictive. It encourages you to disconnect and take a deep breath while the page loads.

## How do I use 99ify?
99ify currently supports macOS.

Note: you may have to enter your password after starting up 99ify, because it uses [pfctl](https://www.unix.com/man-page/osx/8/pfctl/) and [dnctl](https://www.unix.com/man-page/mojave/8/dnctl) which require superuser permissions. 
    
1. Clone the repo.
2. Add addictive websites to `addictive_sites.txt`. They can be comma or newline separated. For example, your file can look like this:

```
instagram.com
youtube.com
```

3. Open a terminal, navigate to the directory where the repo is, and run `./99ify.sh`.
4. Addictive websites have now been 99ified. 

To undo 99ify, run `./stop_99ify.sh`

To change the network speed, edit the `100Kbits/s` option of `99ify.sh` before starting 99ify.
