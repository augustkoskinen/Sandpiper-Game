varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float uHeight;
uniform vec2 texture_Pixel;
uniform vec4 u_uv;

void main()
{
	vec4 Color = v_vColour*texture2D( gm_BaseTexture, v_vTexcoord );
	
	float endy = 0.0;
	for(float j = v_vTexcoord.y; j <= 1.0; j+=texture_Pixel.y) {
		bool allblank = true;
		for(float i = u_uv[0]; i < u_uv[2]; i+=texture_Pixel.x) {
			if(texture2D(gm_BaseTexture,vec2(i,j)).a!=0.0)
				allblank = false;
		}
		
		if(allblank) {
			endy = j;
			break;
		}
	}

	if(v_vTexcoord.y>=endy-uHeight*texture_Pixel.y&&v_vTexcoord.y<endy) {
		float Red = Color.r;
		float Green = Color.g;
		float Blue = Color.b;
		float Alpha = Color.a;
		
		float buffer = 0.625;
  
		float RDistance = (Red - 0.18823529411)*buffer;
		float GDistance = (Green - 0.78823529411)*buffer;
		float BDistance = (Blue - 0.95294117647)*buffer;
		
		Color = vec4(Red - RDistance, Green - GDistance, Blue - BDistance, Alpha);
	}	
	
	gl_FragColor = Color;
}
