shader_type canvas_item;

uniform vec3 color = vec3(0.33, 0.15, 0.82);
uniform int OCTAVES = 4;

float rand(vec2 coord)
{
	return fract(sin(dot(coord, vec2(56, 78)) * 1000.0) * 1000.0);
}

float noise(vec2 coord)
{
	vec2 i = floor(coord);
	vec2 f = fract(coord);
	
	float a = rand(i);
	float b = rand(i + vec2(1.0, 0.0));
	float c = rand(i + vec2(0.0, 1.0));
	float d = rand(i + vec2(1.0, 1.0));
	
	vec2 cubic = f * f * (3.0 - 2.0 * f);
	
	return mix(a, b, cubic.x) + (c - a) * cubic.y * (1.0 - cubic.x) + (d - b) * cubic.x * cubic.y;
}

float fbm(vec2 coord)
{
	float value = 0.0;
	float scale = 0.5;
	
	for(int i = 0; i < OCTAVES; i++)
	{
		value += noise(coord) * scale;
		coord *= 2.0;
		scale *= 0.5;
	}
	return value;
}

void fragment()
{
	vec2 coord = UV * 10.0;
	vec2 motion = vec2(fbm(coord + TIME * 0.5));
	float final = fbm(coord + motion);
	COLOR = vec4(color, final * 0.5);
}