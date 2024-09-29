return [[
extern float radius;
extern float softness;
extern float opacity;
extern vec4 color;

vec4 effect(vec4 c, Image tex, vec2 tc, vec2 _) {
	float aspect = love_ScreenSize.x / love_ScreenSize.y;
	aspect = max(aspect, 1.0 / aspect);
	float v = 1.0 - smoothstep(radius, radius-softness, length((tc - vec2(0.5)) * aspect));
	return mix(Texel(tex, tc), color, v*opacity);
}]]
