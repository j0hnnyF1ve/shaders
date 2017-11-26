/*
Uniforms:
iResolution/u_resolution
iMouse/u_mouse
iGlobalTime/u_time
*/

void main() {
  vec2 uv = gl_FragCoord.xy / u_resolution;

  float aspect = u_resolution.x / u_resolution.y;
  vec2 mouse = iMouse / aspect;

  float radius = 0.15;
  vec2 center = vec2(u_resolution.x/2.0/u_resolution.x, u_resolution.y/2.0/u_resolution.y);
  vec2 pos = vec2(u_resolution.x/u_resolution.x, u_resolution.y/u_resolution.y);

  pos.x = (pos.x * abs(sin(u_time)) * (1.0 - radius * 2.0)) + radius;
  pos.y = (pos.y * abs(cos(u_time * 5.0)) * (1.0 - radius * 2.0)) + radius;

  float red = uv.x;
  float green = 0.0;
  float blue = uv.y;

  red *= abs(sin(u_time));
//  green *= sin(u_time / 0.25);
  blue *= 1.0 - abs(sin(u_time) );

  vec3 color = vec3(red, green, blue);

//  if( distance(uv, mouse) < radius) {
  if( distance(uv, pos) < radius) {
    color.r = 1.0;
    color.g = 1.0 ;
    color.b = 0.5;
  }

  gl_FragColor = vec4(color, 1.0);
}
