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
module derelict.allegro5.primitives;

import core.stdc.stdint;
import derelict.util.loader,
       derelict.util.system;
import derelict.allegro5.internal,
       derelict.allegro5.types;

private enum libNames = genLibNames("Primitives");

alias int ALLEGRO_PRIM_TYPE;
enum {
    ALLEGRO_PRIM_LINE_LIST,
    ALLEGRO_PRIM_LINE_STRIP,
    ALLEGRO_PRIM_LINE_LOOP,
    ALLEGRO_PRIM_TRIANGLE_LIST,
    ALLEGRO_PRIM_TRIANGLE_STRIP,
    ALLEGRO_PRIM_TRIANGLE_FAN,
    ALLEGRO_PRIM_POINT_LIST,
    ALLEGRO_PRIM_NUM_TYPES,
}

enum ALLEGRO_PRIM_MAX_USER_ATTR = _ALLEGRO_PRIM_MAX_USER_ATTR;

alias int ALLEGRO_PRIM_ATTR;
enum {
    ALLEGRO_PRIM_POSITION = 1,
    ALLEGRO_PRIM_COLOR_ATTR,
    ALLEGRO_PRIM_TEX_COORD,
    ALLEGRO_PRIM_TEX_COORD_PIXEL,
    ALLEGRO_PRIM_USER_ATTR,
    ALLEGRO_PRIM_ATTR_NUM = ALLEGRO_PRIM_USER_ATTR + ALLEGRO_PRIM_MAX_USER_ATTR,
}

alias int ALLEGRO_PRIM_STORAGE;
enum {
    ALLEGRO_PRIM_FLOAT_2,
    ALLEGRO_PRIM_FLOAT_3,
    ALLEGRO_PRIM_SHORT_2,
    ALLEGRO_PRIM_FLOAT_1,
    ALLEGRO_PRIM_FLOAT_4,
    ALLEGRO_PRIM_UBYTE_4,
    ALLEGRO_PRIM_SHORT_4,
    ALLEGRO_PRIM_NORMALIZED_UBYTE_4,
    ALLEGRO_PRIM_NORMALIZED_SHORT_2,
    ALLEGRO_PRIM_NORMALIZED_SHORT_4,
    ALLEGRO_PRIM_NORMALIZED_USHORT_2,
    ALLEGRO_PRIM_NORMALIZED_USHORT_4,
    ALLEGRO_PRIM_HALF_FLOAT_2,
    ALLEGRO_PRIM_HALF_FLOAT_4
}

alias ALLEGRO_LINE_JOIN = int;
enum {
    ALLEGRO_LINE_JOIN_NONE,
    ALLEGRO_LINE_JOIN_BEVEL,
    ALLEGRO_LINE_JOIN_ROUND,
    ALLEGRO_LINE_JOIN_MITER,
    ALLEGRO_LINE_JOIN_MITRE = ALLEGRO_LINE_JOIN_MITER
}

alias ALLEGRO_LINE_CAP = int;
enum {
    ALLEGRO_LINE_CAP_NONE,
    ALLEGRO_LINE_CAP_SQUARE,
    ALLEGRO_LINE_CAP_ROUND,
    ALLEGRO_LINE_CAP_TRIANGLE,
    ALLEGRO_LINE_CAP_CLOSED
}

alias ALLEGRO_PRIM_BUFFER_FLAGS = int;
enum {
    ALLEGRO_PRIM_BUFFER_STREAM       = 0x01,
    ALLEGRO_PRIM_BUFFER_STATIC       = 0x02,
    ALLEGRO_PRIM_BUFFER_DYNAMIC      = 0x04,
    ALLEGRO_PRIM_BUFFER_READWRITE    = 0x08
}

enum ALLEGRO_VERTEX_CACHE_SIZE = 256;
enum ALLEGRO_PRIM_QUALITY = 10;

struct ALLEGRO_VERTEX_ELEMENT {
    int attribute;
    int storage;
    int offset;
}

struct ALLEGRO_VERTEX_DECL;

struct ALLEGRO_VERTEX {
    float x, y, z;
    float u, v;
    ALLEGRO_COLOR color;
}

struct ALLEGRO_VERTEX_BUFFER;
struct ALLEGRO_INDEX_BUFFER;

// Callbacks used as arguments in some of the functions below
extern(C) nothrow {
    alias SoftTriInit = void function(uintptr_t,ALLEGRO_VERTEX*,ALLEGRO_VERTEX*,ALLEGRO_VERTEX*);
    alias SoftTriFirst = void function(uintptr_t,int,int,int,int);
    alias SoftTriStep = void function(uintptr_t,int);
    alias SoftTriDraw = void function(uintptr_t,int,int,int);
    alias SoftLineFirst = void function(uintptr_t,int,int,ALLEGRO_VERTEX*,ALLEGRO_VERTEX*);
    alias SoftLineStep = void function(uintptr_t,int);
    alias SoftLineDraw = void function(uintptr_t,int,int);
    alias EmitTriangle = void function(int,int,int,void*);
}

extern(C) @nogc nothrow {
    alias da_al_get_allegro_primitives_version = uint function();

    alias da_al_init_primitives_addon = bool function();
    alias da_al_shutdown_primitives_addon = void function();
    alias da_al_draw_prim = int function(const(void)*,const(ALLEGRO_VERTEX_DECL)*,ALLEGRO_BITMAP*,int,int,int);
    alias da_al_draw_indexed_prim = int function(const(void)*,const(ALLEGRO_VERTEX_DECL)*,ALLEGRO_BITMAP*,const(int)*,int,int);
    alias da_al_draw_vertex_buffer = int function(ALLEGRO_VERTEX_BUFFER*,ALLEGRO_BITMAP*,int,int,int);
    alias da_al_draw_indexed_buffer = int function(ALLEGRO_VERTEX_BUFFER*,ALLEGRO_BITMAP*,int,int,int);

    alias da_al_create_vertex_decl = ALLEGRO_VERTEX_DECL* function(const(ALLEGRO_VERTEX_ELEMENT)*,int);
    alias da_al_destroy_vertex_decl = void function(ALLEGRO_VERTEX_DECL*);

    alias da_al_create_vertex_buffer = ALLEGRO_VERTEX_BUFFER* function(ALLEGRO_VERTEX_DECL*,const(void*),int,int);
    alias da_al_destroy_vertex_buffer = void function(ALLEGRO_VERTEX_BUFFER*);
    alias da_al_lock_vertex_buffer = void* function(ALLEGRO_VERTEX_BUFFER*,int,int,int);
    alias da_al_unlock_vertex_buffer = void function(ALLEGRO_VERTEX_BUFFER*);
    alias da_al_get_vertex_buffer_size = int function(ALLEGRO_VERTEX_BUFFER*);

    alias da_al_create_index_buffer = ALLEGRO_INDEX_BUFFER* function(int,const(void)*,int,int);
    alias da_al_destroy_index_buffer = void function(ALLEGRO_INDEX_BUFFER*);
    alias da_al_lock_index_buffer = void* function(ALLEGRO_INDEX_BUFFER*,int,int,int);
    alias da_al_unlock_index_buffer = void function(ALLEGRO_INDEX_BUFFER*);
    alias da_al_get_index_buffer_size = int function(ALLEGRO_INDEX_BUFFER*);

    alias da_al_triangulate_polygon = bool function(const(float)*,size_t,const(int)*,EmitTriangle,void*);

    alias da_al_draw_soft_triangle = void function(ALLEGRO_VERTEX*,ALLEGRO_VERTEX*,ALLEGRO_VERTEX*,uintptr_t,
            SoftTriInit,SoftTriFirst,SoftTriStep,SoftTriDraw);
    alias da_al_draw_soft_line = void function(ALLEGRO_VERTEX*,ALLEGRO_VERTEX*,uintptr_t,
        SoftLineFirst,SoftLineStep,SoftLineDraw);

    alias da_al_draw_line = void function(float,float,float,float,ALLEGRO_COLOR,float);
    alias da_al_draw_triangle = void function(float,float,float,float,float,float,ALLEGRO_COLOR,float);
    alias da_al_draw_rectangle = void function(float,float,float,float,ALLEGRO_COLOR,float);
    alias da_al_draw_rounded_rectangle = void function(float,float,float,float,float,float,ALLEGRO_COLOR,float);

    alias da_al_calculate_arc = void function(float*,int,float,float,float,float,float,float,float,int);
    alias da_al_draw_circle = void function(float,float,float,ALLEGRO_COLOR,float);
    alias da_al_draw_ellipse = void function(float,float,float,float,ALLEGRO_COLOR,float);
    alias da_al_draw_arc = void function(float,float,float,float,float,ALLEGRO_COLOR,float);
    alias da_al_draw_elliptical_arc = void function(float,float,float,float,float,float,ALLEGRO_COLOR,float);
    alias da_al_draw_pieslice = void function(float,float,float,float,float,ALLEGRO_COLOR,float);

    alias da_al_calculate_spline = void function(float*,int,float*,float,int);
    alias da_al_draw_spline = void function(float*,ALLEGRO_COLOR,float);

    alias da_al_calculate_ribbon = void function(float*,int,const(float*),int,float,int);
    alias da_al_draw_ribbon = void function(const(float)*,int,ALLEGRO_COLOR,float,int);

    alias da_al_draw_filled_triangle = void function(float,float,float,float,float,float,ALLEGRO_COLOR);
    alias da_al_draw_filled_rectangle = void function(float,float,float,float,ALLEGRO_COLOR);
    alias da_al_draw_filled_ellipse = void function(float,float,float,float,ALLEGRO_COLOR);
    alias da_al_draw_filled_circle = void function(float,float,float,ALLEGRO_COLOR);
    alias da_al_draw_filled_pieslice = void function(float,float,float,float,float,ALLEGRO_COLOR);
    alias da_al_draw_filled_rounded_rectangle = void function(float,float,float,float,float,float,ALLEGRO_COLOR);

    alias da_al_draw_polyline = void function(const(float)*,int,int,int,int,ALLEGRO_COLOR,float,float);

    alias da_al_draw_polygon = void function(const(float)*,int,int,ALLEGRO_COLOR,float,float);
    alias da_al_draw_filled_polygon = void function(const(float)*,int,ALLEGRO_COLOR);
    alias da_al_draw_filled_polygon_with_holes = void function(const(float)*,const(int)*,ALLEGRO_COLOR);
}

__gshared {
    da_al_get_allegro_primitives_version al_get_allegro_primitives_version;
    da_al_init_primitives_addon al_init_primitives_addon;
    da_al_shutdown_primitives_addon al_shutdown_primitives_addon;
    da_al_draw_prim al_draw_prim;
    da_al_draw_indexed_prim al_draw_indexed_prim;
    da_al_draw_vertex_buffer al_draw_vertex_buffer;
    da_al_draw_indexed_buffer al_draw_indexed_buffer;
    da_al_create_vertex_decl al_create_vertex_decl;
    da_al_destroy_vertex_decl al_destroy_vertex_decl;
    da_al_create_vertex_buffer al_create_vertex_buffer;
    da_al_destroy_vertex_buffer al_destroy_vertex_buffer;
    da_al_lock_vertex_buffer al_lock_vertex_buffer;
    da_al_unlock_vertex_buffer al_unlock_vertex_buffer;
    da_al_get_vertex_buffer_size al_get_vertex_buffer_size;
    da_al_create_index_buffer al_create_index_buffer;
    da_al_destroy_index_buffer al_destroy_index_buffer;
    da_al_lock_index_buffer al_lock_index_buffer;
    da_al_unlock_index_buffer al_unlock_index_buffer;
    da_al_get_index_buffer_size al_get_index_buffer_size;
    da_al_triangulate_polygon al_triangulate_polygon;
    da_al_draw_soft_triangle al_draw_soft_triangle;
    da_al_draw_soft_line al_draw_soft_line;
    da_al_draw_line al_draw_line;
    da_al_draw_triangle al_draw_triangle;
    da_al_draw_rectangle al_draw_rectangle;
    da_al_draw_rounded_rectangle al_draw_rounded_rectangle;
    da_al_calculate_arc al_calculate_arc;
    da_al_draw_circle al_draw_circle;
    da_al_draw_ellipse al_draw_ellipse;
    da_al_draw_arc al_draw_arc;
    da_al_draw_elliptical_arc al_draw_elliptical_arc;
    da_al_draw_pieslice al_draw_pieslice;
    da_al_calculate_spline al_calculate_spline;
    da_al_draw_spline al_draw_spline;
    da_al_calculate_ribbon al_calculate_ribbon;
    da_al_draw_ribbon al_draw_ribbon;
    da_al_draw_filled_triangle al_draw_filled_triangle;
    da_al_draw_filled_rectangle al_draw_filled_rectangle;
    da_al_draw_filled_ellipse al_draw_filled_ellipse;
    da_al_draw_filled_circle al_draw_filled_circle;
    da_al_draw_filled_pieslice al_draw_filled_pieslice;
    da_al_draw_filled_rounded_rectangle al_draw_filled_rounded_rectangle;
    da_al_draw_polyline al_draw_polyline;
    da_al_draw_polygon al_draw_polygon;
    da_al_draw_filled_polygon al_draw_filled_polygon;
    da_al_draw_filled_polygon_with_holes al_draw_filled_polygon_with_holes;
}

class DerelictAllegro5PrimitivesLoader : SharedLibLoader
{
    this() { super(libNames); }

    protected override void loadSymbols()
    {
        bindFunc(cast(void**)&al_get_allegro_primitives_version, "al_get_allegro_primitives_version");
        bindFunc(cast(void**)&al_init_primitives_addon, "al_init_primitives_addon");
        bindFunc(cast(void**)&al_shutdown_primitives_addon, "al_shutdown_primitives_addon");
        bindFunc(cast(void**)&al_draw_prim, "al_draw_prim");
        bindFunc(cast(void**)&al_draw_indexed_prim, "al_draw_indexed_prim");
        bindFunc(cast(void**)&al_draw_vertex_buffer, "al_draw_vertex_buffer");
        bindFunc(cast(void**)&al_draw_indexed_buffer, "al_draw_indexed_buffer");
        bindFunc(cast(void**)&al_create_vertex_decl, "al_create_vertex_decl");
        bindFunc(cast(void**)&al_destroy_vertex_decl, "al_destroy_vertex_decl");
        bindFunc(cast(void**)&al_create_vertex_buffer, "al_create_vertex_buffer");
        bindFunc(cast(void**)&al_destroy_vertex_buffer, "al_destroy_vertex_buffer");
        bindFunc(cast(void**)&al_lock_vertex_buffer, "al_lock_vertex_buffer");
        bindFunc(cast(void**)&al_unlock_vertex_buffer, "al_unlock_vertex_buffer");
        bindFunc(cast(void**)&al_get_vertex_buffer_size, "al_get_vertex_buffer_size");
        bindFunc(cast(void**)&al_create_index_buffer, "al_create_index_buffer");
        bindFunc(cast(void**)&al_lock_index_buffer, "al_lock_index_buffer");
        bindFunc(cast(void**)&al_destroy_index_buffer, "al_destroy_index_buffer");
        bindFunc(cast(void**)&al_unlock_index_buffer, "al_unlock_index_buffer");
        bindFunc(cast(void**)&al_get_index_buffer_size, "al_get_index_buffer_size");
        bindFunc(cast(void**)&al_destroy_index_buffer, "al_destroy_index_buffer");
        bindFunc(cast(void**)&al_triangulate_polygon, "al_triangulate_polygon");
        bindFunc(cast(void**)&al_draw_soft_triangle, "al_draw_soft_triangle");
        bindFunc(cast(void**)&al_draw_soft_line, "al_draw_soft_line");
        bindFunc(cast(void**)&al_draw_line, "al_draw_line");
        bindFunc(cast(void**)&al_draw_triangle, "al_draw_triangle");
        bindFunc(cast(void**)&al_draw_rectangle, "al_draw_rectangle");
        bindFunc(cast(void**)&al_draw_rounded_rectangle, "al_draw_rounded_rectangle");
        bindFunc(cast(void**)&al_draw_circle, "al_draw_circle");
        bindFunc(cast(void**)&al_draw_ellipse, "al_draw_ellipse");
        bindFunc(cast(void**)&al_draw_arc, "al_draw_arc");
        bindFunc(cast(void**)&al_draw_elliptical_arc, "al_draw_elliptical_arc");
        bindFunc(cast(void**)&al_draw_pieslice, "al_draw_pieslice");
        bindFunc(cast(void**)&al_calculate_spline, "al_calculate_spline");
        bindFunc(cast(void**)&al_draw_spline, "al_draw_spline");
        bindFunc(cast(void**)&al_calculate_ribbon, "al_calculate_ribbon");
        bindFunc(cast(void**)&al_draw_ribbon, "al_draw_ribbon");
        bindFunc(cast(void**)&al_draw_filled_triangle, "al_draw_filled_triangle");
        bindFunc(cast(void**)&al_draw_filled_rectangle, "al_draw_filled_rectangle");
        bindFunc(cast(void**)&al_draw_filled_ellipse, "al_draw_filled_ellipse");
        bindFunc(cast(void**)&al_draw_filled_circle, "al_draw_filled_circle");
        bindFunc(cast(void**)&al_draw_filled_pieslice, "al_draw_filled_pieslice");
        bindFunc(cast(void**)&al_draw_filled_rounded_rectangle, "al_draw_filled_rounded_rectangle");

        bindFunc(cast(void**)&al_draw_polyline, "al_draw_polyline");
        bindFunc(cast(void**)&al_draw_polygon, "al_draw_polygon");
        bindFunc(cast(void**)&al_draw_filled_polygon, "al_draw_filled_polygon");
        bindFunc(cast(void**)&al_draw_filled_polygon_with_holes, "al_draw_filled_polygon_with_holes");

    }
}

__gshared DerelictAllegro5PrimitivesLoader DerelictAllegro5Primitives;

shared static this() {
    DerelictAllegro5Primitives = new DerelictAllegro5PrimitivesLoader;
}