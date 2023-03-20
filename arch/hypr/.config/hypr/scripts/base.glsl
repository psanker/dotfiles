// vim: set ft=glsl:
// blue light filter shader -- corrects for Macbook excessive blue
// Also a hack fix for Wayland not supporting color profiles yet lmao

precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {

    vec4 pixColor = texture2D(tex, v_texcoord);

    // green
    /* pixColor[1] *= 0.725; */

    // blue
    pixColor[2] *= 0.9;

    gl_FragColor = pixColor;
}

