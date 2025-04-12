# Stopgap for Cryptid
Cryptid and Jen's Almanac are great mods. This is especially evident in the fact 
that most runs of these mods don't end because of the blind quota; rather, they
end because the save files get *enormous* and LÖVE starts hard crashing upon
attempting to save.

This mod allows configuring the compression level that Balatro uses to save game 
data, and it also adds some "Fancy Tricks" to scrub redundant data that can be 
reproduced at load time.

# How to install
1. For the love of Godsmarble, **BACK UP YOUR SAVE.** This thing hasn't been
battle tested as of me writing this, so I claim no responsibility for corrupted 
save files as a result of using this mod.

2. At the top of this page, click the green "Code" button and click **Download
ZIP**.

3. Extract the folder in the ZIP into your `%appdata%\Balatro\Mods` folder.
Ensure that `Stopgap.lua` and all surrounding files can be found *directly* 
inside the `Mods\Stopgap` folder, and not inside a folder within that folder.

4. Launch the game. You should now no longer be able to produce a crash with 
your softlocked save.

# FAQ
## Will this make my save file incompatible with vanilla Cryptid?
Nope! This mod does not modify any save loading routines whatsoever. All the
heavy lifting is done by the saving code and the save files themselves.
