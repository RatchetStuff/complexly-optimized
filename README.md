# Complexly Optimized

## What?
This is a (complex) optimization modpack based on my own philosophy! It's free, open-source, and whatever problems you have with it, we will certainly not judge you! Based on [Simply Optimized](https://modrinth.com/modpack/sop), which (I think) is based on the same philosophy. Licensed under Unlicense.

## How?
Optimization mods and configs, and also some minimal polish (like Crash Assistant, no chat signing). Vanilla parity is maintained, but if it doesn't, don't hesitate to open an issue!

## Loaders
There are a few loaders:
- Fabric (🧶), shortened to `fab`.
- Forge (🔨), shortened to `frg`.
- NeoForge (🦊), shortened to `neo`.

### Presets
There are two main presets:
1. Anarchy (🧨), shortened to `ana`, which is stable and contains all optimizations at the cost of some compatibility. Sometimes incompatible!
2. Lawful (📜), shortened to `law`, which is stable and contains most optimizations for compatibility with a majority of mods. Major optimizations that are incompatible (such as ModernFix's dynamic resources) will be kept. Rarely incompatible!

Some additional presets may be created, including but not limited to:
- VulkanMod (🌋), shortened to `vkn`.

Due to the limitations of the current system, these presets are not decoupled from the main presets, and will be assigned the anarchy preset by default.

### Distribution
There are currently two distributions. When making a modpack, only distribute the specified distributions (e.g. CurseForge-only for CurseForge-distributed modpacks):
1. CurseForge-only, which contains most of the optimizations, which will be distributed on CurseForge. This was made because some of the good mods (like Accelerated Rendering) are only on CF. This may contain Modrinth mods subject to the [Approved Non-CurseForge Mods list](https://docs.google.com/spreadsheets/d/176Wv-PZUo9hFxy6oC6N8tWdquBLPRtSuLbNK-r0_byM/edit#gid=0).
2. Modrinth-only, which contains most of the optimizations, which will be distributed on Modrinth. Treat this the same as the CurseForge distribution! The only exception is in the older versions, in which case you should use CurseForge for the optimizations.

## Which?

### Version?
- Versions follow this format: {YEAR}.{MONTH}.{PATCH}+mc{MC_VERSION}.{LOADER}.{PRESET}
- Year uses the short format (omitting the first two digits)
- Patch starts from 0 every month.
- Minecraft version emits the "1." prefix (if it exists)
- Loader and preset are limited to three characters.
- Distribution is already included in the file extension.
- Example: 26.1.0+mc12.2.frg.ana.mrpack

### To choose?
Choose what you need! The difference between these presets are compatibility sacrifices, not instability. You may also manually mix the presets together.

## Why?
Because some optimization modpacks as of right now:

### Are not technically free.
Most of them are licensed under MIT, which is fair, but it prevents commercial modpacks from closing their source. This I personally dislike because I want to be able to do anything with my modpack without facing licensing issues.

### Don't have a clear sense of direction.
There are modpacks which knows what they're doing, but they center their modpack around everyone (vanilla players and modpack makers, which cannot be mixed together), which creates a frankenstein-sort of mod set.

### Are judgmental.
Few refuse to help players that have a problem just because of unrelated reasons (e.g. for using a specific launcher). This is unprofessional practice in my opinion, and prevents a fraction of the player base from receiving support. These barriers are stripped from this modpack.

## Who?
Made by me and other contributors (if there are).
