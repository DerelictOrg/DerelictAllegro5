DerelictAllegro5
================

A dynamic binding to version 5.0 of the [Allegro][1] library and its associated addons for the D Programming Language.

Please see the pages [Building and Linking Derelict][2] and [Using Derelict][3], in the Derelict documentation, for information on how to build DerelictAllegro5 and load the Allegro 5 libraries at run time. In the meantime, here's some sample code.

```D
// For the core Allegro library
import derelict.allegro5.allegro;

// Add additional imports for each addon package intended to be used
import derelict.allegro5.image;         // For the Image addon
import derelict.allegro5.font;          // For the Font addon
import derelict.allegro5.primitives;    // For the Primitives addon
// etc...

// Alternatively, import core Allegro and all addons
import derelict.allegro5;

void main() {
    // Load the core Allegro library.
    DerelictAllegro5.load();

    // Now Allegro5 functions can be called.
    ...

    // Any addons can be loaded as needed.
    DerelictAllegro5Image.load();
    DerelictAllegro5Font.load();
    DerelictAllegro5Primitives.load();
    // etc...
}
```

This binding is a bit different from most other Derelict packages, especially when building on Mac OSX. Please refer to this [blog post about DerelictAllegro5 at The One With D][4] for more information until the Derelict documentation is complete.


[1]: http://alleg.sourceforge.net/
[2]: http://derelictorg.github.io/compiling.html
[3]: http://derelictorg.github.io/using.html
[4]: http://dblog.aldacron.net/derelictallegro5/