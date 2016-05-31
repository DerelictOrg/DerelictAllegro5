/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license ( the "Software" ) to use, reproduce, display, distribute,
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
module derelict.allegro5.video;

private {
    import derelict.util.loader,
           derelict.util.system;

    import derelict.allegro5.internal,
           derelict.allegro5.audio,
           derelict.allegro5.types;

    enum libNames = genLibNames( "Video" );
}

alias ALLEGRO_VIDEO_EVENT_TYPE = int;
enum {
    ALLEGRO_EVENT_VIDEO_FRAME_SHOW   = 550,
    ALLEGRO_EVENT_VIDEO_FINISHED     = 551,
}

alias ALLEGRO_VIDEO_POSITION_TYPE = int;
enum {
    ALLEGRO_VIDEO_POSITION_ACTUAL,
    ALLEGRO_VIDEO_POSITION_VIDEO_DECODE,
    ALLEGRO_VIDEO_POSITION_AUDIO_DECODE,
}

struct ALLEGRO_VIDEO;

extern( C ) @nogc nothrow {
    alias da_al_open_video = ALLEGRO_VIDEO* function(const(char)*);
    alias da_al_close_video = void function(ALLEGRO_VIDEO*);
    alias da_al_start_video = void function(ALLEGRO_VIDEO*,ALLEGRO_MIXER*);
    alias da_al_start_video_with_voice = void function(ALLEGRO_VIDEO*,ALLEGRO_VOICE*);
    alias da_al_get_video_event_source = ALLEGRO_EVENT_SOURCE* function(ALLEGRO_VIDEO*);
    alias da_al_set_video_playing = void function(ALLEGRO_VIDEO*,bool);
    alias da_al_is_video_playing = bool function(ALLEGRO_VIDEO*);
    alias da_al_get_video_audio_rate = double function(ALLEGRO_VIDEO*);
    alias da_al_get_video_fps = double function(ALLEGRO_VIDEO*);
    alias da_al_get_video_scaled_width = float function(ALLEGRO_VIDEO*);
    alias da_al_get_video_scaled_height = float function(ALLEGRO_VIDEO*);
    alias da_al_get_video_frame = ALLEGRO_BITMAP* function(ALLEGRO_VIDEO*);
    alias da_al_get_video_position = double function(ALLEGRO_VIDEO*);
    alias da_al_seek_video = bool function(ALLEGRO_VIDEO*,double);
    alias da_al_init_video_addon = bool function();
    alias da_al_shutdown_video_addon = void function();
    alias da_al_get_allegro_video_version = uint function();
}

__gshared {
    da_al_open_video al_open_video;
    da_al_close_video al_close_video;
    da_al_start_video al_start_video;
    da_al_start_video_with_voice al_start_video_with_voice;
    da_al_get_video_event_source al_get_video_event_source;
    da_al_set_video_playing al_set_video_playing;
    da_al_is_video_playing al_is_video_playing;
    da_al_get_video_audio_rate al_get_video_audio_rate;
    da_al_get_video_fps al_get_video_fps;
    da_al_get_video_scaled_width al_get_video_scaled_width;
    da_al_get_video_scaled_height al_get_video_scaled_height;
    da_al_get_video_frame al_get_video_frame;
    da_al_get_video_position al_get_video_position;
    da_al_seek_video al_seek_video;
    da_al_init_video_addon al_init_video_addon;
    da_al_shutdown_video_addon al_shutdown_video_addon;
    da_al_get_allegro_video_version al_get_allegro_video_version;
}

class DerelictAllegro5VideoLoader : SharedLibLoader {
    public this() {
        super( libNames );
    }

    protected override void loadSymbols() {
        bindFunc( cast( void** )&al_open_video, "al_open_video" );
        bindFunc( cast( void** )&al_close_video, "al_close_video" );
        bindFunc( cast( void** )&al_start_video, "al_start_video" );
        bindFunc( cast( void** )&al_start_video_with_voice, "al_start_video_with_voice" );
        bindFunc( cast( void** )&al_get_video_event_source, "al_get_video_event_source" );
        bindFunc( cast( void** )&al_set_video_playing, "al_set_video_playing" );
        bindFunc( cast( void** )&al_is_video_playing, "al_is_video_playing" );
        bindFunc( cast( void** )&al_get_video_audio_rate, "al_get_video_audio_rate" );
        bindFunc( cast( void** )&al_get_video_fps, "al_get_video_fps" );
        bindFunc( cast( void** )&al_get_video_scaled_width, "al_get_video_scaled_width" );
        bindFunc( cast( void** )&al_get_video_scaled_height, "al_get_video_scaled_height" );
        bindFunc( cast( void** )&al_get_video_frame, "al_get_video_frame" );
        bindFunc( cast( void** )&al_get_video_position, "al_get_video_position" );
        bindFunc( cast( void** )&al_seek_video, "al_seek_video" );
        bindFunc( cast( void** )&al_init_video_addon, "al_init_video_addon" );
        bindFunc( cast( void** )&al_shutdown_video_addon, "al_shutdown_video_addon" );
        bindFunc( cast( void** )&al_get_allegro_video_version, "al_get_allegro_video_version" );
    }
}

__gshared DerelictAllegro5VideoLoader DerelictAllegro5Video;

shared static this() {
    DerelictAllegro5Video = new DerelictAllegro5VideoLoader;
}