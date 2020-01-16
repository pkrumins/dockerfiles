1) setup 32 bit wine environment

WINEARCH=win32 winecfg

2) install winetricks packages

WINEARCH=win32 winetricks msxml6 corefonts riched20 usp10

3) disable docker networking --network none

4) unpack office 2013 iso

7z x office2013.iso

5) run 32 bit install

WINEARCH=win32 wine x86/setup.exe

