/*
Uniforms:
iResolution/u_resolution
iMouse/u_mouse
iGlobalTime/u_time
*/

#define r iResolution.xy;
#define t iGlobalTime;

float getColor(vec2 normal, float curTime) {
  float pointLength;

  // aspect ratio
  vec2 uv = normal;
  normal -= 0.5;
//  normal.x *= r.x/r.y;
  curTime += 0.7;
  pointLength = length(normal);

  uv += normal/pointLength * sin(curTime) + 1. * abs(sin(pointLength * 9. - curTime * 2.));

  return .01 / length( abs(mod(uv,1.)-.5));
}

void main() {
  vec3 color = vec3(0.75);
  vec2 normal = gl_FragCoord.xy/iResolution.xy;

  color = vec3(
    getColor(normal, iGlobalTime),
    getColor(normal, iGlobalTime),
    getColor(normal, iGlobalTime) );

  gl_FragColor = vec4(color, 1.0);
}
