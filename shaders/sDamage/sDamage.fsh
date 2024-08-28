//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float utimer;

void main() {
	vec4 final_color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	final_color.r *= 3.0*utimer+1;
	final_color.b *= 3.0*utimer+1;
	


	
    gl_FragColor = final_color;
}
