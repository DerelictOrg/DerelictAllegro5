/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/
module derelict.allegro5.ttf;

import derelict.util.loader,
       derelict.util.system;
import derelict.allegro5.font,
       derelict.allegro5.internal,
       derelict.allegro5.types;

private enum libNames = genLibNames("TTF");

extern(C) @nogc nothrow {
    alias da_al_load_ttf_font = ALLEGRO_FONT* function(const(char)*, int, int);
    alias da_al_load_ttf_font_f = ALLEGRO_FONT* function(ALLEGRO_FILE*, const(char)*, int, int);
    alias da_al_load_ttf_font_stretch = ALLEGRO_FONT* function(const(char)*, int, int, int);
    alias da_al_load_ttf_font_stretch_f = ALLEGRO_FONT* function(ALLEGRO_FILE*, const(char)*, int, int, int);
    alias da_al_init_ttf_addon = bool function();
    alias da_al_shutdown_ttf_addon = void function();
    alias da_al_get_allegro_ttf_version = uint function();
}

__gshared {
    da_al_load_ttf_font al_load_ttf_font;
    da_al_load_ttf_font_f al_load_ttf_font_f;
    da_al_load_ttf_font_stretch al_load_ttf_font_stretch;
    da_al_load_ttf_font_stretch_f al_load_ttf_font_stretch_f;
    da_al_init_ttf_addon al_init_ttf_addon;
    da_al_shutdown_ttf_addon al_shutdown_ttf_addon;
    da_al_get_allegro_ttf_version al_get_allegro_ttf_version;
}

class DerelictAllegro5TTFLoader : SharedLibLoader
{
    this() { super(libNames); }

    protected override void loadSymbols()
    {
        bindFunc(cast(void**)&al_load_ttf_font, "al_load_ttf_font");
        bindFunc(cast(void**)&al_load_ttf_font_f, "al_load_ttf_font_f");
        bindFunc(cast(void**)&al_load_ttf_font_stretch, "al_load_ttf_font_stretch");
        bindFunc(cast(void**)&al_load_ttf_font_stretch_f, "al_load_ttf_font_stretch_f");
        bindFunc(cast(void**)&al_init_ttf_addon, "al_init_ttf_addon");
        bindFunc(cast(void**)&al_shutdown_ttf_addon, "al_shutdown_ttf_addon");
        bindFunc(cast(void**)&al_get_allegro_ttf_version, "al_get_allegro_ttf_version");
    }
}

__gshared DerelictAllegro5TTFLoader DerelictAllegro5TTF;

shared static this() {
    DerelictAllegro5TTF = new DerelictAllegro5TTFLoader;
}