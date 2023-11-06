---
title: "Making Pong with Go and WebAssembly"
date: "2020-06-30"
author: "dstoiko"
tags: [personal, software, gaming, go, webassembly]
---

# TL;DR

For those of you in a hurry: I made a version of the classic Pong game using Go and WebAssembly. I then embedded that game on my website. Warning: it __works only on desktop now (no handling of touch)__. Here is the game, enjoy:

{{< ebiten src="/pong/index.html" >}}

# Why WebAssembly

WebAssembly is a relatively new standard on web browsers. From the [Wikipedia page](https://en.wikipedia.org/wiki/WebAssembly):

> The main goal of WebAssembly is to enable high-performance applications on web pages, but the format is designed to be executed and integrated in other environments as well. (...) WebAssembly (i.e. WebAssembly Core Specification and WebAssembly JavaScript Interface) became World Wide Web Consortium recommendations on 5 December 2019 and, alongside HTML, CSS, and JavaScript, is the fourth language to run natively in browsers.

Although it can be used on other interfaces, the WebAssembly standard basically allows to run code written in another language than HTML or JavaScript, so long as it can be compiled into WebAssembly language, which can be seen as the equivalent of assembly code for web browsers. The output _.wasm_ file of any WebAssembly project can be read and interpreted directly by major web browsers. The project was kicked off and first maintained by the Mozilla foundation. The documentation can be found on the [official website](https://webassembly.org/).

# Why Go

At [Moona](https://en.getmoona.com), our backend API server runs on go. I really like this language as it is simple to write, yet feature-rich and performant, with a large community and adoption by tech companies working on large-scale infrastructure and systems (Google, Amazon, Netflix, Docker, Cloudflare...). There should always be one "canonic" way to do one thing, which makes reasoning about code easier, freeing up some mental load. It's a compiled, statically-typed language so it catches more potential errors upstream, it's garbage-collected so no need to manage memory, it handles concurrency natively and it's fast.

# Why Pong

[Pong](https://en.wikipedia.org/wiki/Pong) is a classic game made popular by Atari systems, and was one of the first home video games ever commercialized. I wanted to try out WebAssembly with Go on a simple and classic game which can be played against an AI or another human to make it more fun.

# Coding the game

At first I had written this game using the [Go port of the SDL2 library](https://github.com/veandco/go-sdl2), originally written in C, which allows to access audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D, in order to code native user interfaces (including games) easily. Credit goes to [Jack Mott](https://github.com/jackmott) for his tutorial series [Games with Go](https://gameswithgo.org/) for the initial version, which was inspired from his videos and modified to fit my needs.

But while porting the game to WebAssembly, I looked for ways to simplify development. So I found this 2D gaming library named [Ebiten](https://ebiten.org) by [Hajime Hoshi](https://github.com/hajimehoshi) which was perfectly suited for the job, as it handles game loop, 60FPS graphics, inputs, text, audio, sprites etc. and can compile to WebAssembly (!!!). I refactored the code to fit the new library.

The code is organized into:

- `package pong` which contains all the game objects and structures (paddles, ball, text, colors, enums), as well as logic specific to these objects. The two paddles and the ball can be `Update`d and `Draw`n on the screen.
- `package main` which contains the game loop and logic dependent on the game states
- `package server` which is a super simple HTTP server for the WebAssembly version

The game has several states which are simple and grouped into a go struct as follows:

```go
// there can be only up to 256 game states ¯\_(ツ)_/¯
type GameState byte

const (
	StartState GameState = iota
	ControlsState
	PlayState
	InterState
	PauseState
	GameOverState
)
```

The game logic is pretty straightforward. There are still some small glitches but overall it's an easy piece of code, just for demo purposes. You can find it [on my github here](https://github.com/dstoiko/go-pong-wasm).

# Compiling for WebAssembly

I first ran the code in a native binary executable, because the compilation was straightforward and it allowed me to test the game logic easily on my machine. I created a _Makefile_ with the target `native` which should perform the simple command:

```makefile
go build -o ./build/pong .
```

Then, I wanted to port the code to WebAssembly. But first I needed to figure out a few things...

## How to compile the go code to output a _.wasm_ WebAssembly file?

Fortunately, the [Golang wiki](https://github.com/golang/go/wiki/WebAssembly#getting-started) has an entry on how to build programs for WebAssembly. It goes straight to the point with a "hello world" example and simple steps to achieve a port of any program to WebAssembly. I recommend this resource as a must-read for anyone wanting to compile go code into WebAssembly. So I tested their example code and it seemed to work, so I started checking the documentation for it on the [Ebiten website](https://ebiten.org/documents/webassembly.html). So I created the `wasm` target in my _Makefile_ which basically does this:

```makefile
cp $$(go env GOROOT)/misc/wasm/wasm_exec.js ./html/wasm_exec.js
GOOS=js GOARCH=wasm go build -o ./html/main.wasm .
```

The _wasm\_exec.js_ file is a JavaScript support file which enables the use of system calls to the JS engine in the web browser.

I also adapted the main code so that it runs at fullscreen instead of fixed window size when running in a browser:

```go
func main() {
	if runtime.GOARCH == "js" || runtime.GOOS == "js" {
		ebiten.SetFullscreen(true)
	}
	...
}
```

## How (and what exactly) to serve to the web browser in order to properly run the game?

We need to serve three files ultimately:

- The _main.wasm_ file with WebAssembly compiled code
- The _wasm\_exec.js_ JavaScript support file
- The _index.html_ which just streams the WebAssembly file into the browser with a simple JS script:

```js
// Polyfill
if (!WebAssembly.instantiateStreaming) {
    WebAssembly.instantiateStreaming = async (resp, importObject) => {
        const source = await (await resp).arrayBuffer();
        return await WebAssembly.instantiate(source, importObject);
    };
}

const go = new Go();
WebAssembly.instantiateStreaming(fetch("main.wasm"), go.importObject).then(
    result => {
        go.run(result.instance);
    }
);
```

So the _server/server.go_ file will do just that. Once we compile the _main.wasm_ from our go code, it will be served at http://localhost:8080 and we're set.

## How to make the executable lightweight when embedding it into a static website?

The main issue with "just" compiling to WebAssembly is that the executable was around 10MB in size:

```bash
-rw-r--r--@  1 vultur  staff       661 Jul 12 22:26 index.html
-rwxr-xr-x@  1 vultur  staff  10147815 Jul 12 22:53 main.wasm
-rw-r--r--@  1 vultur  staff     13077 Jul 12 22:53 wasm_exec.js
```

So I needed a way to make the file a bit lighter in order to serve it on my blog. Thankfully there is `gzip` for that. Before writing any code or going deep into documentation, I checked out the examples on the Ebiten website, as the author was already embedding his demos on his website. I dug through the source code and found out that he's using the [pako JS library](https://github.com/nodeca/pako) to inflate the gzip-compressed files when streaming them in the browser. So I decided to do the same and:

...first, gzip the _main.wasm_ file:

```bash
gzip -9 -v -c main.wasm > main.wasm.gz
```

...which gave me a file size of about 2MB:

```bash
-rw-r--r--@  1 vultur  staff   2296872 Jul 12 23:53 main.wasm.gz
```

...then, modify the _index.html_ accordingly:

```js
window.addEventListener("DOMContentLoaded", async () => {
    const go = new Go();
    const url = "main.wasm.gz"; // the gzip-compressed wasm file
    const pako = window.pako;
    let wasm = pako.ungzip(await (await fetch(url)).arrayBuffer());
    // A fetched response might be decompressed twice on Firefox.
    // See https://bugzilla.mozilla.org/show_bug.cgi?id=610679
    if (wasm[0] === 0x1f && wasm[1] === 0x8b) {
        wasm = pako.ungzip(wasm);
    }
    const result = await WebAssembly.instantiate(wasm, go.importObject)
        .catch((err) => {
            console.error(err);
        });
    // Loading text before the wasm loads
    document.getElementById("loading").remove();
    go.run(result.instance);
});
```

## How to embed the game into my Hugo blog?

The last thing I needed to do was to embed the three files into my blog. I'm using the Hugo framework so all articles I write are in markdown. I created a [custom shortcode](https://gohugo.io/templates/shortcode-templates/) in order to embed the webassembly content as an iframe, as suggested by the Ebiten documentation. I first wrote a template for the shortcode, laying out the HTML that will be rendered when calling it from within the article:

```html
{{ if .Get "src" }}
    <div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden;">
        <iframe
            sandbox="allow-same-origin allow-scripts"
            src="{{ .Get `src` }}"
            style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border:0;"
        ></iframe>
    </div>
{{ end }}
```

Then I just added the files for serving the game in a new page folder inside my blog directory and referenced to it as the `src` tag of my shortcode:

```
{{ < ebiten src="/pong/index.html" > }}
```

# Closing words

In this little project, I learned how to build Go code into WebAssembly and learned how to program a game using the Ebiten library, which offers a range of great tools to develop any 2D game. It gave me a few ideas of things I want to try next with it. I hope you found this post interesting as an intro to WebAssembly!
