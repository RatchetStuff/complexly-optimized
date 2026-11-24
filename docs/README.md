<div align="center">
<h1>Complexly Optimized</h1>
Yet another optimization modpack based on my own philosophy. It's FOSS!
<br />
<br />
<a href="https://github.com/RatchetStuff/complexly-optimized">GitHub</a>
|
<a href="https://modrinth.com/project/C5YzQQgW">Modrinth</a>
|
<a href="https://discord.gg/bV3wRykjbg">Discord</a>
</div>

What's This?
------------

This is a _(complex)_ optimization modpack based on my own philosophy! It's free, open-source, and mostly suckless! Inspired by [Simply Optimized](https://modrinth.com/modpack/sop), which is under public domain too.

Features
--------

- Tested performance mods with vanilla compatibility.
- Handpicked configs.
- Curated wiki pages.
- Distributions for different platforms.
- Minimal extra features, including:
  - Config Manager, to provide configs that will not replace user-made configs on update. Supports updating configs to the latest provided by the modpack.
  - Crash Assistant (without annoyances), to make crashes easier to understand and debug.
  - Dynamic FPS, to reduce usage in the background and uncap menu FPS.
  - No chat signing, without adding extra mods.

Development
-----------

### Shell-based

Various shell scripts written in `bash` are provided in the repository with `-?|--help` included. Do install `bash` and `git`, then clone the repository through `git` before developing.

### Container-based

A `Dockerfile` is included in the repository which builds an image based on Alpine Linux, containing `packwiz` and other dependencies. Do mount the repository to `/root/src` before developing.
