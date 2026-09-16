### What this gives you

Boot:

```text
BIOS/UEFI
   ↓
NixOS
   ↓
LightDM
   ↓
IceWM
   ↓
Alacritty
   ↓
PCManFM
```

That's about it.

There is intentionally **no**:

```text
GNOME
KDE
XFCE
Wayland
PipeWire
PulseAudio configuration
Network applets
notification daemons
polkit agents
desktop portals
compositors
dock
launcher
terminal multiplexers
editors
browsers
```

NixOS itself will still pull in whatever dependencies are genuinely required by Xorg, LightDM, IceWM, GTK, etc. The point is that you aren't installing an entire desktop environment on top of it.

### One important Pentium check

Before using the flake, run:

```bash
uname -m
```

If you get:

```text
x86_64
```

the flake above is correct.

If you get:

```text
i686
```

then the machine is 32-bit and this needs to be changed to:

```nix
system = "i686-linux";
```

I'd specifically check this because "Pentium" covers a huge range of CPUs.

### Installing it

Start from the NixOS installer, generate the hardware configuration:

```bash
sudo nixos-generate-config --root /mnt
```

NixOS recommends generating `hardware-configuration.nix` this way because it detects things such as filesystems and required hardware modules.

Then put the three files above into:

```text
/mnt/etc/nixos/
```

For an already-installed system, put them in:

```text
/etc/nixos/
```

Then:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#pentium
```

NixOS's flake workflow uses the `nixosConfigurations.<name>` attribute, so `#pentium` corresponds to the name in `flake.nix`.

One thing I would **not** enable initially is LightDM autologin. Get the machine booting, measure how much RAM/X startup time it uses, then we can strip it even further. NixOS also supports running X without a display manager at all, which would let us make an even more minimal IceWM setup later.

If your Pentium is particularly weak, the first thing I'd test after this is **Alacritty itself**—the terminal is likely to be a more interesting performance variable than IceWM.
