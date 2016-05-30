module derelict.allegro5.internal;

// Helper for generating library names at compile time.
private import derelict.util.system;

package string genLibNames( string prefix ) {
    import std.string : toLower;

    static if( Derelict_OS_Windows ) {
        enum MonolithNames = "allegro_monolith-5.2.dll,allegro_monolith-5.2.0-mt.dll";

        auto s = prefix.toLower();
        if( s != "allegro" ) {
            s = "allegro_" ~ s;
        }
        s ~= "-5.2.dll," ~ s ~ "-5.2.0-mt.dll";
    }
    else static if( Derelict_OS_Mac ) {
        // TODO Do they build a monolith target on Mac?
        enum MonolithNames = "";

        auto lwr = prefix.toLower;
        auto name = "Allegro";
        if( lwr != "allegro" ) {
            name ~= prefix;
            lwr = "_" ~ lwr;
        }
        else {
            lwr = "";
        }
        auto s = "../Frameworks/"~name~"-5.2.framework,/Library/Frameworks/"~name~"-5.2.0.framework,liballegro"~lwr~".5.2.0.dylib,liballegro"~lwr~".5.2.dylib,/usr/local/lib/liballegro"~lwr~".5.2.0.dylib,/usr/local/lib/liballegro"~lwr~".5.2.dylib";
    }
    else static if( Derelict_OS_Posix ) {
        // TODO What is the monolith name format on other Posix platforms?
        enum MonolithNames = "";
        auto lwr = prefix.toLower;
        if( lwr != "allegro" ) {
            lwr = "_" ~ lwr;
        }
        else {
            lwr = "";
        }
        auto s = "liballegro"~lwr~".so.5.2.0,liballegro"~lwr~".so.5.2";
    }
    else {
        static assert( 0, "Allegro library names not yet implemented on this platform." );
    }

    return MonolithNames ~ s;
}
