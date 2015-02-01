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
module derelict.allegro5.audio;

private {
    import derelict.util.loader;

    import derelict.allegro5.internal,
           derelict.allegro5.types;

    enum libNames = genLibNames( "Audio" );
}

enum _KCM_STREAM_FEEDER_QUIT_EVENT_TYPE = 512;
enum ALLEGRO_EVENT_AUDIO_STREAM_FRAGMENT = 513;
enum ALLEGRO_EVENT_AUDIO_STREAM_FINISHED = 514;

alias ALLEGRO_AUDIO_DEPTH = int;
enum {
    ALLEGRO_AUDIO_DEPTH_INT8 = 0x00,
    ALLEGRO_AUDIO_DEPTH_INT16 = 0x01,
    ALLEGRO_AUDIO_DEPTH_INT24 = 0x02,
    ALLEGRO_AUDIO_DEPTH_FLOAT32 = 0x03,
    ALLEGRO_AUDIO_DEPTH_UNSIGNED = 0x08,
    ALLEGRO_AUDIO_DEPTH_UINT8 = ALLEGRO_AUDIO_DEPTH_INT8 | ALLEGRO_AUDIO_DEPTH_UNSIGNED,
    ALLEGRO_AUDIO_DEPTH_UINT16 = ALLEGRO_AUDIO_DEPTH_INT16 | ALLEGRO_AUDIO_DEPTH_UNSIGNED,
    ALLEGRO_AUDIO_DEPTH_UINT24 = ALLEGRO_AUDIO_DEPTH_INT24 | ALLEGRO_AUDIO_DEPTH_UNSIGNED,
}

alias ALLEGRO_CHANNEL_CONF = int;
enum {
    ALLEGRO_CHANNEL_CONF_1 = 0x10,
    ALLEGRO_CHANNEL_CONF_2 = 0x20,
    ALLEGRO_CHANNEL_CONF_3 = 0x30,
    ALLEGRO_CHANNEL_CONF_4 = 0x40,
    ALLEGRO_CHANNEL_CONF_5_1 = 0x51,
    ALLEGRO_CHANNEL_CONF_6_1 = 0x61,
    ALLEGRO_CHANNEL_CONF_7_1 = 0x71,
}

alias ALLEGRO_PLAYMODE = int;
enum {
    ALLEGRO_PLAYMODE_ONCE = 0x100,
    ALLEGRO_PLAYMODE_LOOP = 0x101,
    ALLEGRO_PLAYMODE_BIDIR = 0x102,
}

alias ALLEGRO_MIXER_QUALITY = int;
enum {
    ALLEGRO_MIXER_QUALITY_POINT = 0x110,
    ALLEGRO_MIXER_QUALITY_LINEAR = 0x111,
    ALLEGRO_MIXER_QUALITY_CUBIC = 0x112,
}

enum ALLEGRO_AUDIO_PAN_NONE = -1000.0f;

struct ALLEGRO_SAMPLE;

struct ALLEGRO_SAMPLE_ID {
    int _index;
    int _id;
}

struct ALLEGRO_SAMPLE_INSTANCE;
struct ALLEGRO_AUDIO_STREAM;
struct ALLEGRO_MIXER;
struct ALLEGRO_VOICE;

extern( C ) nothrow {
    alias da_al_create_sample = ALLEGRO_SAMPLE* function( void*, uint, uint, ALLEGRO_AUDIO_DEPTH, ALLEGRO_CHANNEL_CONF, bool );
    alias da_al_destroy_sample = void function( ALLEGRO_SAMPLE* );
    alias da_al_create_sample_instance = ALLEGRO_SAMPLE_INSTANCE* function( ALLEGRO_SAMPLE* );
    alias da_al_destroy_sample_instance = void function( ALLEGRO_SAMPLE_INSTANCE* );
    alias da_al_get_sample_frequency = uint function( const( ALLEGRO_SAMPLE )* );
    alias da_al_get_sample_length = uint function( const( ALLEGRO_SAMPLE )* );
    alias da_al_get_sample_depth = ALLEGRO_AUDIO_DEPTH function( const( ALLEGRO_SAMPLE )* );
    alias da_al_get_sample_channels = ALLEGRO_CHANNEL_CONF function( const( ALLEGRO_SAMPLE )* );
    alias da_al_get_sample_data = void* function( const( ALLEGRO_SAMPLE )* );
    alias da_al_get_sample_instance_frequency = uint function( const( ALLEGRO_SAMPLE_INSTANCE )* );
    alias da_al_get_sample_instance_length = uint function( const( ALLEGRO_SAMPLE_INSTANCE )* );
    alias da_al_get_sample_instance_position = uint function( const( ALLEGRO_SAMPLE_INSTANCE )* );
    alias da_al_get_sample_instance_speed = float function( const( ALLEGRO_SAMPLE_INSTANCE )* );
    alias da_al_get_sample_instance_gain = float function( const( ALLEGRO_SAMPLE_INSTANCE )* );
    alias da_al_get_sample_instance_pan = float function( const( ALLEGRO_SAMPLE_INSTANCE )* );
    alias da_al_get_sample_instance_time = float function( const( ALLEGRO_SAMPLE_INSTANCE )* );
    alias da_al_get_sample_instance_depth = ALLEGRO_AUDIO_DEPTH function( const( ALLEGRO_SAMPLE_INSTANCE )* );
    alias da_al_get_sample_instance_channels = ALLEGRO_CHANNEL_CONF function( const( ALLEGRO_SAMPLE_INSTANCE )* );
    alias da_al_get_sample_instance_playmode = ALLEGRO_PLAYMODE function( const( ALLEGRO_SAMPLE_INSTANCE )* );
    alias da_al_get_sample_instance_playing = bool function( const( ALLEGRO_SAMPLE_INSTANCE )* );
    alias da_al_get_sample_instance_attached = bool function( const( ALLEGRO_SAMPLE_INSTANCE )* );
    alias da_al_set_sample_instance_position = bool function( ALLEGRO_SAMPLE_INSTANCE*, uint );
    alias da_al_set_sample_instance_length = bool function( ALLEGRO_SAMPLE_INSTANCE*, uint );
    alias da_al_set_sample_instance_speed = bool function( ALLEGRO_SAMPLE_INSTANCE*, float );
    alias da_al_set_sample_instance_gain = bool function( ALLEGRO_SAMPLE_INSTANCE*, float );
    alias da_al_set_sample_instance_pan = bool function( ALLEGRO_SAMPLE_INSTANCE*, float );
    alias da_al_set_sample_instance_playmode = bool function( ALLEGRO_SAMPLE_INSTANCE*, ALLEGRO_PLAYMODE );
    alias da_al_set_sample_instance_playing = bool function( ALLEGRO_SAMPLE_INSTANCE*, bool );
    alias da_al_detach_sample_instance = bool function( ALLEGRO_SAMPLE_INSTANCE* );
    alias da_al_set_sample = bool function( ALLEGRO_SAMPLE_INSTANCE*, ALLEGRO_SAMPLE* );
    alias da_al_get_sample = ALLEGRO_SAMPLE* function( ALLEGRO_SAMPLE_INSTANCE* );
    alias da_al_play_sample_instance = bool function( ALLEGRO_SAMPLE_INSTANCE* );
    alias da_al_stop_sample_instance = bool function( ALLEGRO_SAMPLE_INSTANCE* );
    alias da_al_create_audio_stream = ALLEGRO_AUDIO_STREAM* function( size_t, uint, uint, ALLEGRO_AUDIO_DEPTH, ALLEGRO_CHANNEL_CONF );
    alias da_al_destroy_audio_stream = void function( ALLEGRO_AUDIO_STREAM* );
    alias da_al_drain_audio_stream = void function( ALLEGRO_AUDIO_STREAM* );
    alias da_al_get_audio_stream_frequency = uint function( const( ALLEGRO_AUDIO_STREAM )* );
    alias da_al_get_audio_stream_length = uint function( const( ALLEGRO_AUDIO_STREAM )* );
    alias da_al_get_audio_stream_fragments = uint function( const( ALLEGRO_AUDIO_STREAM )* );
    alias da_al_get_available_audio_stream_fragments = uint function( const( ALLEGRO_AUDIO_STREAM )* );
    alias da_al_get_audio_stream_speed = float function( const( ALLEGRO_AUDIO_STREAM )* );
    alias da_al_get_audio_stream_gain = float function( const( ALLEGRO_AUDIO_STREAM )* );
    alias da_al_get_audio_stream_pan = float function( const( ALLEGRO_AUDIO_STREAM )* );
    alias da_al_get_audio_stream_channels = ALLEGRO_CHANNEL_CONF function( const( ALLEGRO_AUDIO_STREAM )* );
    alias da_al_get_audio_stream_depth = ALLEGRO_AUDIO_DEPTH function( const( ALLEGRO_AUDIO_STREAM )* );
    alias da_al_get_audio_stream_playmode = ALLEGRO_PLAYMODE function( const( ALLEGRO_AUDIO_STREAM )* );
    alias da_al_get_audio_stream_playing = bool function( const( ALLEGRO_AUDIO_STREAM )* );
    alias da_al_get_audio_stream_attached = bool function( const( ALLEGRO_AUDIO_STREAM )* );
    alias da_al_get_audio_stream_fragment = void* function( const( ALLEGRO_AUDIO_STREAM )* );
    alias da_al_set_audio_stream_speed = bool function( ALLEGRO_AUDIO_STREAM*, float );
    alias da_al_set_audio_stream_gain = bool function( ALLEGRO_AUDIO_STREAM*, float );
    alias da_al_set_audio_stream_pan = bool function( ALLEGRO_AUDIO_STREAM*, float );
    alias da_al_set_audio_stream_playmode = bool function( ALLEGRO_AUDIO_STREAM*, ALLEGRO_PLAYMODE );
    alias da_al_set_audio_stream_playing = bool function( ALLEGRO_AUDIO_STREAM*, bool );
    alias da_al_detach_audio_stream = bool function( ALLEGRO_AUDIO_STREAM * );
    alias da_al_set_audio_stream_fragment = bool function( ALLEGRO_AUDIO_STREAM*, void* );
    alias da_al_rewind_audio_stream = bool function( ALLEGRO_AUDIO_STREAM* );
    alias da_al_seek_audio_stream_secs = bool function( ALLEGRO_AUDIO_STREAM*, double );
    alias da_al_get_audio_stream_position_secs = double function( ALLEGRO_AUDIO_STREAM* );
    alias da_al_get_audio_stream_length_secs = double function( ALLEGRO_AUDIO_STREAM* );
    alias da_al_set_audio_stream_loop_secs = bool function( ALLEGRO_AUDIO_STREAM*, double, double );
    alias da_al_get_audio_stream_event_source = ALLEGRO_EVENT_SOURCE* function( ALLEGRO_AUDIO_STREAM* );
    alias da_al_create_mixer = ALLEGRO_MIXER* function( uint, ALLEGRO_AUDIO_DEPTH, ALLEGRO_CHANNEL_CONF );
    alias da_al_destroy_mixer = void function( ALLEGRO_MIXER* );
    alias da_al_attach_sample_instance_to_mixer = bool function( ALLEGRO_SAMPLE_INSTANCE*, ALLEGRO_MIXER* );
    alias da_al_attach_audio_stream_to_mixer = bool function( ALLEGRO_AUDIO_STREAM*, ALLEGRO_MIXER* );
    alias da_al_attach_mixer_to_mixer = bool function( ALLEGRO_MIXER*, ALLEGRO_MIXER* );
    alias PostProcessCallback = void function( void*, uint, void* );
    alias da_al_set_mixer_postprocess_callback = bool function( ALLEGRO_MIXER*, PostProcessCallback, void* );
    alias da_al_get_mixer_frequency = uint function( const( ALLEGRO_MIXER )* );
    alias da_al_get_mixer_channels = ALLEGRO_CHANNEL_CONF function( const( ALLEGRO_MIXER )* );
    alias da_al_get_mixer_depth = ALLEGRO_AUDIO_DEPTH function( const( ALLEGRO_MIXER )* );
    alias da_al_get_mixer_quality = ALLEGRO_MIXER_QUALITY function( const( ALLEGRO_MIXER )* );
    alias da_al_get_mixer_gain = float function( const( ALLEGRO_MIXER )* );
    alias da_al_get_mixer_playing = bool function( const( ALLEGRO_MIXER )* );
    alias da_al_get_mixer_attached = bool function( const( ALLEGRO_MIXER )* );
    alias da_al_set_mixer_frequency = bool function( ALLEGRO_MIXER*, uint );
    alias da_al_set_mixer_quality = bool function( ALLEGRO_MIXER*, ALLEGRO_MIXER_QUALITY );
    alias da_al_set_mixer_gain = bool function( ALLEGRO_MIXER*, float );
    alias da_al_set_mixer_playing = bool function( ALLEGRO_MIXER*, bool );
    alias da_al_detach_mixer = bool function( ALLEGRO_MIXER* );
    alias da_al_create_voice = ALLEGRO_VOICE* function( uint, ALLEGRO_AUDIO_DEPTH, ALLEGRO_CHANNEL_CONF );
    alias da_al_destroy_voice = void function( ALLEGRO_VOICE* );
    alias da_al_attach_sample_instance_to_voice = bool function( ALLEGRO_SAMPLE_INSTANCE*, ALLEGRO_VOICE* );
    alias da_al_attach_audio_stream_to_voice = bool function( ALLEGRO_AUDIO_STREAM*, ALLEGRO_VOICE* );
    alias da_al_attach_mixer_to_voice = bool function( ALLEGRO_MIXER*, ALLEGRO_VOICE* );
    alias da_al_detach_voice = void function( ALLEGRO_VOICE* );
    alias da_al_get_voice_frequency = uint function( const( ALLEGRO_VOICE )* );
    alias da_al_get_voice_position = uint function( const( ALLEGRO_VOICE )* );
    alias da_al_get_voice_channels = ALLEGRO_CHANNEL_CONF function( const( ALLEGRO_VOICE )* );
    alias da_al_get_voice_depth = ALLEGRO_AUDIO_DEPTH function( const( ALLEGRO_VOICE )* );
    alias da_al_get_voice_playing = bool function( const( ALLEGRO_VOICE )* );
    alias da_al_set_voice_position = bool function( ALLEGRO_VOICE*, uint );
    alias da_al_set_voice_playing = bool function( ALLEGRO_VOICE*, bool );
    alias da_al_install_audio = bool function();
    alias da_al_uninstall_audio = void function();
    alias da_al_is_audio_installed = bool function();
    alias da_al_get_allegro_audio_version = uint function();
    alias da_al_get_channel_count = size_t function( ALLEGRO_CHANNEL_CONF );
    alias da_al_get_audio_depth_size = size_t function( ALLEGRO_AUDIO_DEPTH );
    alias da_al_reserve_samples = bool function( int );
    alias da_al_get_default_mixer = ALLEGRO_MIXER* function();
    alias da_al_set_default_mixer = bool function( ALLEGRO_MIXER* );
    alias da_al_restore_default_mixer = bool function();
    alias da_al_play_sample = bool function( ALLEGRO_SAMPLE*, float, float, float, ALLEGRO_PLAYMODE, ALLEGRO_SAMPLE_ID* );
    alias da_al_stop_sample = void function( ALLEGRO_SAMPLE_ID* );
    alias da_al_stop_samples = void function();
    alias SampleLoader = ALLEGRO_SAMPLE* function( const( char )* );
    alias da_al_register_sample_loader = bool function( const( char )*, SampleLoader );
    alias SampleSaver = bool function( const( char )*, ALLEGRO_SAMPLE* );
    alias da_al_register_sample_saver = bool function( const( char )*, SampleSaver );
    alias StreamLoader = ALLEGRO_AUDIO_STREAM* function( const( char )*, size_t, uint );
    alias da_al_register_audio_stream_loader = bool function( const( char )*, StreamLoader );
    alias SampleLoaderF = ALLEGRO_SAMPLE* function( ALLEGRO_FILE* );
    alias da_al_register_sample_loader_f = bool function( const( char )*, SampleLoaderF );
    alias SampleSaverF = bool function( ALLEGRO_FILE*, ALLEGRO_SAMPLE* );
    alias da_al_register_sample_saver_f = bool function( const( char )*, SampleSaverF );
    alias StreamLoaderF = ALLEGRO_AUDIO_STREAM* function( ALLEGRO_FILE*, size_t, uint );
    alias da_al_register_audio_stream_loader_f = bool function( const( char )*, StreamLoaderF );
    alias da_al_load_sample = ALLEGRO_SAMPLE* function( const( char )* );
    alias da_al_save_sample = bool function( const( char )*, ALLEGRO_SAMPLE * );
    alias da_al_load_audio_stream = ALLEGRO_AUDIO_STREAM* function( const( char )*, size_t, uint );
    alias da_al_load_sample_f = ALLEGRO_SAMPLE* function( ALLEGRO_FILE*, const( char )* );
    alias da_al_save_sample_f = bool function( ALLEGRO_FILE*, const( char )*, ALLEGRO_SAMPLE* );
    alias da_al_load_audio_stream_f = ALLEGRO_AUDIO_STREAM* function( ALLEGRO_FILE*, const( char )*, size_t, uint );
}

__gshared {
    da_al_create_sample al_create_sample;
    da_al_destroy_sample al_destroy_sample;
    da_al_create_sample_instance al_create_sample_instance;
    da_al_destroy_sample_instance al_destroy_sample_instance;
    da_al_get_sample_frequency al_get_sample_frequency;
    da_al_get_sample_length al_get_sample_length;
    da_al_get_sample_depth al_get_sample_depth;
    da_al_get_sample_channels al_get_sample_channels;
    da_al_get_sample_data al_get_sample_data;
    da_al_get_sample_instance_frequency al_get_sample_instance_frequency;
    da_al_get_sample_instance_length al_get_sample_instance_length;
    da_al_get_sample_instance_position al_get_sample_instance_position;
    da_al_get_sample_instance_speed al_get_sample_instance_speed;
    da_al_get_sample_instance_gain al_get_sample_instance_gain;
    da_al_get_sample_instance_pan al_get_sample_instance_pan;
    da_al_get_sample_instance_time al_get_sample_instance_time;
    da_al_get_sample_instance_depth al_get_sample_instance_depth;
    da_al_get_sample_instance_channels al_get_sample_instance_channels;
    da_al_get_sample_instance_playmode al_get_sample_instance_playmode;
    da_al_get_sample_instance_playing al_get_sample_instance_playing;
    da_al_get_sample_instance_attached al_get_sample_instance_attached;
    da_al_set_sample_instance_position al_set_sample_instance_position;
    da_al_set_sample_instance_length al_set_sample_instance_length;
    da_al_set_sample_instance_speed al_set_sample_instance_speed;
    da_al_set_sample_instance_gain al_set_sample_instance_gain;
    da_al_set_sample_instance_pan al_set_sample_instance_pan;
    da_al_set_sample_instance_playmode al_set_sample_instance_playmode;
    da_al_set_sample_instance_playing al_set_sample_instance_playing;
    da_al_detach_sample_instance al_detach_sample_instance;
    da_al_set_sample al_set_sample;
    da_al_get_sample al_get_sample;
    da_al_play_sample_instance al_play_sample_instance;
    da_al_stop_sample_instance al_stop_sample_instance;
    da_al_create_audio_stream al_create_audio_stream;
    da_al_destroy_audio_stream al_destroy_audio_stream;
    da_al_drain_audio_stream al_drain_audio_stream;
    da_al_get_audio_stream_frequency al_get_audio_stream_frequency;
    da_al_get_audio_stream_length al_get_audio_stream_length;
    da_al_get_audio_stream_fragments al_get_audio_stream_fragments;
    da_al_get_available_audio_stream_fragments al_get_available_audio_stream_fragments;
    da_al_get_audio_stream_speed al_get_audio_stream_speed;
    da_al_get_audio_stream_gain al_get_audio_stream_gain;
    da_al_get_audio_stream_pan al_get_audio_stream_pan;
    da_al_get_audio_stream_channels al_get_audio_stream_channels;
    da_al_get_audio_stream_depth al_get_audio_stream_depth;
    da_al_get_audio_stream_playmode al_get_audio_stream_playmode;
    da_al_get_audio_stream_playing al_get_audio_stream_playing;
    da_al_get_audio_stream_attached al_get_audio_stream_attached;
    da_al_get_audio_stream_fragment al_get_audio_stream_fragment;
    da_al_set_audio_stream_speed al_set_audio_stream_speed;
    da_al_set_audio_stream_gain al_set_audio_stream_gain;
    da_al_set_audio_stream_pan al_set_audio_stream_pan;
    da_al_set_audio_stream_playmode al_set_audio_stream_playmode;
    da_al_set_audio_stream_playing al_set_audio_stream_playing;
    da_al_detach_audio_stream al_detach_audio_stream;
    da_al_set_audio_stream_fragment al_set_audio_stream_fragment;
    da_al_rewind_audio_stream al_rewind_audio_stream;
    da_al_seek_audio_stream_secs al_seek_audio_stream_secs;
    da_al_get_audio_stream_position_secs al_get_audio_stream_position_secs;
    da_al_get_audio_stream_length_secs al_get_audio_stream_length_secs;
    da_al_set_audio_stream_loop_secs al_set_audio_stream_loop_secs;
    da_al_get_audio_stream_event_source al_get_audio_stream_event_source;
    da_al_create_mixer al_create_mixer;
    da_al_destroy_mixer al_destroy_mixer;
    da_al_attach_sample_instance_to_mixer al_attach_sample_instance_to_mixer;
    da_al_attach_audio_stream_to_mixer al_attach_audio_stream_to_mixer;
    da_al_attach_mixer_to_mixer al_attach_mixer_to_mixer;
    da_al_set_mixer_postprocess_callback al_set_mixer_postprocess_callback;
    da_al_get_mixer_frequency al_get_mixer_frequency;
    da_al_get_mixer_channels al_get_mixer_channels;
    da_al_get_mixer_depth al_get_mixer_depth;
    da_al_get_mixer_quality al_get_mixer_quality;
    da_al_get_mixer_gain al_get_mixer_gain;
    da_al_get_mixer_playing al_get_mixer_playing;
    da_al_get_mixer_attached al_get_mixer_attached;
    da_al_set_mixer_frequency al_set_mixer_frequency;
    da_al_set_mixer_quality al_set_mixer_quality;
    da_al_set_mixer_gain al_set_mixer_gain;
    da_al_set_mixer_playing al_set_mixer_playing;
    da_al_detach_mixer al_detach_mixer;
    da_al_create_voice al_create_voice;
    da_al_destroy_voice al_destroy_voice;
    da_al_attach_sample_instance_to_voice al_attach_sample_instance_to_voice;
    da_al_attach_audio_stream_to_voice al_attach_audio_stream_to_voice;
    da_al_attach_mixer_to_voice al_attach_mixer_to_voice;
    da_al_detach_voice al_detach_voice;
    da_al_get_voice_frequency al_get_voice_frequency;
    da_al_get_voice_position al_get_voice_position;
    da_al_get_voice_channels al_get_voice_channels;
    da_al_get_voice_depth al_get_voice_depth;
    da_al_get_voice_playing al_get_voice_playing;
    da_al_set_voice_position al_set_voice_position;
    da_al_set_voice_playing al_set_voice_playing;
    da_al_install_audio al_install_audio;
    da_al_uninstall_audio al_uninstall_audio;
    da_al_is_audio_installed al_is_audio_installed;
    da_al_get_allegro_audio_version al_get_allegro_audio_version;
    da_al_get_channel_count al_get_channel_count;
    da_al_get_audio_depth_size al_get_audio_depth_size;
    da_al_reserve_samples al_reserve_samples;
    da_al_get_default_mixer al_get_default_mixer;
    da_al_set_default_mixer al_set_default_mixer;
    da_al_restore_default_mixer al_restore_default_mixer;
    da_al_play_sample al_play_sample;
    da_al_stop_sample al_stop_sample;
    da_al_stop_samples al_stop_samples;
    da_al_register_sample_loader al_register_sample_loader;
    da_al_register_sample_saver al_register_sample_saver;
    da_al_register_audio_stream_loader al_register_audio_stream_loader;
    da_al_register_sample_loader_f al_register_sample_loader_f;
    da_al_register_sample_saver_f al_register_sample_saver_f;
    da_al_register_audio_stream_loader_f al_register_audio_stream_loader_f;
    da_al_load_sample al_load_sample;
    da_al_save_sample al_save_sample;
    da_al_load_audio_stream al_load_audio_stream;
    da_al_load_sample_f al_load_sample_f;
    da_al_save_sample_f al_save_sample_f;
    da_al_load_audio_stream_f al_load_audio_stream_f;
}

class DerelictAllegro5AudioLoader : SharedLibLoader {
    public this() {
        super( libNames );
    }

    protected override void loadSymbols() {
        bindFunc( cast( void** )&al_create_sample, "al_create_sample" );
        bindFunc( cast( void** )&al_destroy_sample, "al_destroy_sample" );
        bindFunc( cast( void** )&al_create_sample_instance, "al_create_sample_instance" );
        bindFunc( cast( void** )&al_destroy_sample_instance, "al_destroy_sample_instance" );
        bindFunc( cast( void** )&al_get_sample_frequency, "al_get_sample_frequency" );
        bindFunc( cast( void** )&al_get_sample_length, "al_get_sample_length" );
        bindFunc( cast( void** )&al_get_sample_depth, "al_get_sample_depth" );
        bindFunc( cast( void** )&al_get_sample_channels, "al_get_sample_channels" );
        bindFunc( cast( void** )&al_get_sample_data, "al_get_sample_data" );
        bindFunc( cast( void** )&al_get_sample_instance_frequency, "al_get_sample_instance_frequency" );
        bindFunc( cast( void** )&al_get_sample_instance_length, "al_get_sample_instance_length" );
        bindFunc( cast( void** )&al_get_sample_instance_position, "al_get_sample_instance_position" );
        bindFunc( cast( void** )&al_get_sample_instance_speed, "al_get_sample_instance_speed" );
        bindFunc( cast( void** )&al_get_sample_instance_gain, "al_get_sample_instance_gain" );
        bindFunc( cast( void** )&al_get_sample_instance_pan, "al_get_sample_instance_pan" );
        bindFunc( cast( void** )&al_get_sample_instance_time, "al_get_sample_instance_time" );
        bindFunc( cast( void** )&al_get_sample_instance_depth, "al_get_sample_instance_depth" );
        bindFunc( cast( void** )&al_get_sample_instance_channels, "al_get_sample_instance_channels" );
        bindFunc( cast( void** )&al_get_sample_instance_playmode, "al_get_sample_instance_playmode" );
        bindFunc( cast( void** )&al_get_sample_instance_playing, "al_get_sample_instance_playing" );
        bindFunc( cast( void** )&al_get_sample_instance_attached, "al_get_sample_instance_attached" );
        bindFunc( cast( void** )&al_set_sample_instance_position, "al_set_sample_instance_position" );
        bindFunc( cast( void** )&al_set_sample_instance_length, "al_set_sample_instance_length" );
        bindFunc( cast( void** )&al_set_sample_instance_speed, "al_set_sample_instance_speed" );
        bindFunc( cast( void** )&al_set_sample_instance_gain, "al_set_sample_instance_gain" );
        bindFunc( cast( void** )&al_set_sample_instance_pan, "al_set_sample_instance_pan" );
        bindFunc( cast( void** )&al_set_sample_instance_playmode, "al_set_sample_instance_playmode" );
        bindFunc( cast( void** )&al_set_sample_instance_playing, "al_set_sample_instance_playing" );
        bindFunc( cast( void** )&al_detach_sample_instance, "al_detach_sample_instance" );
        bindFunc( cast( void** )&al_set_sample, "al_set_sample" );
        bindFunc( cast( void** )&al_get_sample, "al_get_sample" );
        bindFunc( cast( void** )&al_play_sample_instance, "al_play_sample_instance" );
        bindFunc( cast( void** )&al_stop_sample_instance, "al_stop_sample_instance" );
        bindFunc( cast( void** )&al_create_audio_stream, "al_create_audio_stream" );
        bindFunc( cast( void** )&al_destroy_audio_stream, "al_destroy_audio_stream" );
        bindFunc( cast( void** )&al_drain_audio_stream, "al_drain_audio_stream" );
        bindFunc( cast( void** )&al_get_audio_stream_frequency, "al_get_audio_stream_frequency" );
        bindFunc( cast( void** )&al_get_audio_stream_length, "al_get_audio_stream_length" );
        bindFunc( cast( void** )&al_get_audio_stream_fragments, "al_get_audio_stream_fragments" );
        bindFunc( cast( void** )&al_get_available_audio_stream_fragments, "al_get_available_audio_stream_fragments" );
        bindFunc( cast( void** )&al_get_audio_stream_speed, "al_get_audio_stream_speed" );
        bindFunc( cast( void** )&al_get_audio_stream_gain, "al_get_audio_stream_gain" );
        bindFunc( cast( void** )&al_get_audio_stream_pan, "al_get_audio_stream_pan" );
        bindFunc( cast( void** )&al_get_audio_stream_channels, "al_get_audio_stream_channels" );
        bindFunc( cast( void** )&al_get_audio_stream_depth, "al_get_audio_stream_depth" );
        bindFunc( cast( void** )&al_get_audio_stream_playmode, "al_get_audio_stream_playmode" );
        bindFunc( cast( void** )&al_get_audio_stream_playing, "al_get_audio_stream_playing" );
        bindFunc( cast( void** )&al_get_audio_stream_attached, "al_get_audio_stream_attached" );
        bindFunc( cast( void** )&al_get_audio_stream_fragment, "al_get_audio_stream_fragment" );
        bindFunc( cast( void** )&al_set_audio_stream_speed, "al_set_audio_stream_speed" );
        bindFunc( cast( void** )&al_set_audio_stream_gain, "al_set_audio_stream_gain" );
        bindFunc( cast( void** )&al_set_audio_stream_pan, "al_set_audio_stream_pan" );
        bindFunc( cast( void** )&al_set_audio_stream_playmode, "al_set_audio_stream_playmode" );
        bindFunc( cast( void** )&al_set_audio_stream_playing, "al_set_audio_stream_playing" );
        bindFunc( cast( void** )&al_detach_audio_stream, "al_detach_audio_stream" );
        bindFunc( cast( void** )&al_set_audio_stream_fragment, "al_set_audio_stream_fragment" );
        bindFunc( cast( void** )&al_rewind_audio_stream, "al_rewind_audio_stream" );
        bindFunc( cast( void** )&al_seek_audio_stream_secs, "al_seek_audio_stream_secs" );
        bindFunc( cast( void** )&al_get_audio_stream_position_secs, "al_get_audio_stream_position_secs" );
        bindFunc( cast( void** )&al_get_audio_stream_length_secs, "al_get_audio_stream_length_secs" );
        bindFunc( cast( void** )&al_set_audio_stream_loop_secs, "al_set_audio_stream_loop_secs" );
        bindFunc( cast( void** )&al_get_audio_stream_event_source, "al_get_audio_stream_event_source" );
        bindFunc( cast( void** )&al_create_mixer, "al_create_mixer" );
        bindFunc( cast( void** )&al_destroy_mixer, "al_destroy_mixer" );
        bindFunc( cast( void** )&al_attach_sample_instance_to_mixer, "al_attach_sample_instance_to_mixer" );
        bindFunc( cast( void** )&al_attach_audio_stream_to_mixer, "al_attach_audio_stream_to_mixer" );
        bindFunc( cast( void** )&al_attach_mixer_to_mixer, "al_attach_mixer_to_mixer" );
        bindFunc( cast( void** )&al_set_mixer_postprocess_callback, "al_set_mixer_postprocess_callback" );
        bindFunc( cast( void** )&al_get_mixer_frequency, "al_get_mixer_frequency" );
        bindFunc( cast( void** )&al_get_mixer_channels, "al_get_mixer_channels" );
        bindFunc( cast( void** )&al_get_mixer_depth, "al_get_mixer_depth" );
        bindFunc( cast( void** )&al_get_mixer_quality, "al_get_mixer_quality" );
        bindFunc( cast( void** )&al_get_mixer_gain, "al_get_mixer_gain" );
        bindFunc( cast( void** )&al_get_mixer_playing, "al_get_mixer_playing" );
        bindFunc( cast( void** )&al_get_mixer_attached, "al_get_mixer_attached" );
        bindFunc( cast( void** )&al_set_mixer_frequency, "al_set_mixer_frequency" );
        bindFunc( cast( void** )&al_set_mixer_quality, "al_set_mixer_quality" );
        bindFunc( cast( void** )&al_set_mixer_gain, "al_set_mixer_gain" );
        bindFunc( cast( void** )&al_set_mixer_playing, "al_set_mixer_playing" );
        bindFunc( cast( void** )&al_detach_mixer, "al_detach_mixer" );
        bindFunc( cast( void** )&al_create_voice, "al_create_voice" );
        bindFunc( cast( void** )&al_destroy_voice, "al_destroy_voice" );
        bindFunc( cast( void** )&al_attach_sample_instance_to_voice, "al_attach_sample_instance_to_voice" );
        bindFunc( cast( void** )&al_attach_audio_stream_to_voice, "al_attach_audio_stream_to_voice" );
        bindFunc( cast( void** )&al_attach_mixer_to_voice, "al_attach_mixer_to_voice" );
        bindFunc( cast( void** )&al_detach_voice, "al_detach_voice" );
        bindFunc( cast( void** )&al_get_voice_frequency, "al_get_voice_frequency" );
        bindFunc( cast( void** )&al_get_voice_position, "al_get_voice_position" );
        bindFunc( cast( void** )&al_get_voice_channels, "al_get_voice_channels" );
        bindFunc( cast( void** )&al_get_voice_depth, "al_get_voice_depth" );
        bindFunc( cast( void** )&al_get_voice_playing, "al_get_voice_playing" );
        bindFunc( cast( void** )&al_set_voice_position, "al_set_voice_position" );
        bindFunc( cast( void** )&al_set_voice_playing, "al_set_voice_playing" );
        bindFunc( cast( void** )&al_install_audio, "al_install_audio" );
        bindFunc( cast( void** )&al_uninstall_audio, "al_uninstall_audio" );
        bindFunc( cast( void** )&al_is_audio_installed, "al_is_audio_installed" );
        bindFunc( cast( void** )&al_get_allegro_audio_version, "al_get_allegro_audio_version" );
        bindFunc( cast( void** )&al_get_audio_depth_size, "al_get_audio_depth_size" );
        bindFunc( cast( void** )&al_reserve_samples, "al_reserve_samples" );
        bindFunc( cast( void** )&al_get_default_mixer, "al_get_default_mixer" );
        bindFunc( cast( void** )&al_set_default_mixer, "al_set_default_mixer" );
        bindFunc( cast( void** )&al_restore_default_mixer, "al_restore_default_mixer" );
        bindFunc( cast( void** )&al_play_sample, "al_play_sample" );
        bindFunc( cast( void** )&al_stop_sample, "al_stop_sample" );
        bindFunc( cast( void** )&al_stop_samples, "al_stop_samples" );
        bindFunc( cast( void** )&al_register_audio_stream_loader, "al_register_audio_stream_loader" );
        bindFunc( cast( void** )&al_register_sample_saver, "al_register_sample_saver" );
        bindFunc( cast( void** )&al_register_sample_loader_f, "al_register_sample_loader_f" );
        bindFunc( cast( void** )&al_register_sample_saver_f, "al_register_sample_saver_f" );
        bindFunc( cast( void** )&al_register_audio_stream_loader_f, "al_register_audio_stream_loader_f" );
        bindFunc( cast( void** )&al_load_sample, "al_load_sample" );
        bindFunc( cast( void** )&al_save_sample, "al_save_sample" );
        bindFunc( cast( void** )&al_load_audio_stream, "al_load_audio_stream" );
        bindFunc( cast( void** )&al_load_sample_f, "al_load_sample_f" );
        bindFunc( cast( void** )&al_save_sample_f, "al_save_sample_f" );
        bindFunc( cast( void** )&al_load_audio_stream_f, "al_load_audio_stream_f" );
    }
}

__gshared DerelictAllegro5AudioLoader DerelictAllegro5Audio;

shared static this() {
    DerelictAllegro5Audio = new DerelictAllegro5AudioLoader;
}