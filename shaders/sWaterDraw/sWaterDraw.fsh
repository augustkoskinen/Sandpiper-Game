//
// Simple passthrough fragment shader
//

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float uPercent;
uniform vec2 texture_Pixel;
uniform vec4 u_uv;
uniform float utopedge;

void main()
{
	vec4 Color = v_vColour*texture2D( gm_BaseTexture, v_vTexcoord );
	
	/*
	vec2 pos = vec2(
		(v_vTexcoord.x - u_uv[0]) / (u_uv[2] - u_uv[0]),
		(v_vTexcoord.y - u_uv[1]) / (u_uv[3] - u_uv[1])
	);
	*/
	float starty = 0;
	
	if(utopedge==-1) {
		for(float j = v_vTexcoord.y; j >= 0; j-=texture_Pixel.y) {
			bool allblank = true;
			for(float i = u_uv[0]; i < u_uv[2]; i+=texture_Pixel.x) {
				if(texture2D(gm_BaseTexture,vec2(i,j)).a!=0)
					allblank = false;
			}
		
			if(allblank) {
				starty = j+texture_Pixel.y;
				break;
			}
		}
	} else starty=utopedge;
	
	float endy = 0;
	for(float j = v_vTexcoord.y; j <= 1; j+=texture_Pixel.y) {
		bool allblank = true;
		for(float i = u_uv[0]; i < u_uv[2]; i+=texture_Pixel.x) {
			if(texture2D(gm_BaseTexture,vec2(i,j)).a!=0)
				allblank = false;
		}
		
		if(allblank) {
			endy = j;//-texture_Pixel.y;
			break;
		}
	}
	
	float topthreshhold = endy-((endy-starty)*uPercent);

	if(v_vTexcoord.y>=topthreshhold&&v_vTexcoord.y<endy) {
		float Red = Color.r;
		float Green = Color.g;
		float Blue = Color.b;
		float Alpha = Color.a;
		
		float buffer = 0.625;
  
		float RDistance = (Red - 0.18823529411)*buffer;
		float GDistance = (Green - 0.78823529411)*buffer;
		float BDistance = (Blue - 0.95294117647)*buffer;
		
		//Color = vec4(1.0);
		Color = vec4(Red - RDistance, Green - GDistance, Blue - BDistance, Alpha);
	}	
	
	gl_FragColor = Color;
}
