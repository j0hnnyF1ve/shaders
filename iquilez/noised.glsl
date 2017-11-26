// http://www.iquilezles.org/www/articles/gradientnoise/gradientnoise.htm
// https://www.shadertoy.com/view/XdXBRH

vec2 hash( in vec2 x ) {
  const vec2 k = vec2( 0.3183099, 0.3678794 );
  x = x*k + k.yx;
  return -1.0 + 2.0 * fract(16.0 * k*fract(x.x*x.y*(x.x+x.y)) );
}
/*
vec4 noised( in vec3 x ) {
  vec3 p = floor(x);
  vec3 w = fract(x);

  vec3 u = w*w*w*(w*(w*6.0-15.0)+10.0);
  vec3 du = 30.0*w*w*(w*(w-2.0)+1.0);

  // gradients
  vec3 ga = hash( p+vec3(0.0,0.0,0.0) );
  vec3 gb = hash( p+vec3(1.0,0.0,0.0) );
  vec3 gc = hash( p+vec3(0.0,1.0,0.0) );
  vec3 gd = hash( p+vec3(1.0,1.0,0.0) );
  vec3 ge = hash( p+vec3(0.0,0.0,1.0) );
  vec3 gf = hash( p+vec3(1.0,0.0,1.0) );
  vec3 gg = hash( p+vec3(0.0,1.0,1.0) );
  vec3 gh = hash( p+vec3(1.0,1.0,1.0) );

  // projections
  float va = dot(ga, w-vec3(0.0,0.0,0.0) );
  float vb = dot(ga, w-vec3(1.0,0.0,0.0) );
  float vc = dot(ga, w-vec3(0.0,1.0,0.0) );
  float vd = dot(ga, w-vec3(1.0,1.0,0.0) );
  float ve = dot(ga, w-vec3(0.0,0.0,1.0) );
  float vf = dot(ga, w-vec3(1.0,0.0,1.0) );
  float vg = dot(ga, w-vec3(0.0,1.0,1.0) );
  float vh = dot(ga, w-vec3(1.0,1.0,1.0) );

  // interpolation
  float v = va +
            u.x*(vb-va) +
            u.y*(vc-va) +
            u.z*(ve-va) +
            u.x*u.y*(va-vb-vc+vd) +
            u.y*u.z*(va-vc-ve+vg) +
            u.z*u.x*(va-vb-ve+vf) +
            u.x*u.y*u.z*(-va+vb+vc-vd+ve-vf-vg+vh);

  vec3 d = ga +
            u.x*(gb-ga) +
            u.y*(gc-ga) +
            u.z*(ge-ga) +
            u.x*u.y*(ga-gb-gc+gd) +
            u.y*u.z*(ga-gc-ge+gg) +
            u.z*u.x*(ga-gb-ge+gf) +
            u.x*u.y*u.z*(-ga+gb+gc-gd+ge-gf-gg+gh) +

            du * (vec3(vb-va, vc-va, ve-va) +
              u.yzx*vec3(va-vb-vc+vd, va-vc-ve+vg, va-vb-ve+vf) +
              u.zxy*vec3(va-vb-ve+vf, va-vb-vc+vd, va-vc-ve+vg) +
              u.yzx*u.zxy*vec3(-va+vb+vc-vd+ve-vf-vg+vh) );

  return vec4(v, d);
}
*/
vec3 noised( in vec2 x ) {
  vec2 i = floor(x);
  vec2 f = fract(x);

  vec2 u = f*f*f*(f*(f*6.0-15.0)+10.0);
  vec2 du = 30.0*f*f*(f*(f-2.0)+1.0);

  vec2 ga = hash( i + vec2(0.0, 0.0) );
  vec2 gb = hash( i + vec2(1.0, 0.0) );
  vec2 gc = hash( i + vec2(0.0, 1.0) );
  vec2 gd = hash( i + vec2(1.0, 1.0) );

  float va = dot( ga, f - vec2(0.0, 0.0) );
  float vb = dot( gb, f - vec2(1.0, 0.0) );
  float vc = dot( gc, f - vec2(0.0, 1.0) );
  float vd = dot( gd, f - vec2(1.0, 1.0) );

  return vec3(va + u.x*(vb-va) + u.y*(vc-va) + u.x*u.y*(va-vb-vc+vd),
              ga + u.x*(gb-ga) + u.y*(gc-ga) + u.x*u.y*(ga-gb-gc+gd) +
              du * (u.yx*(va-vb-vc+vd) + vec2(vb, vc) - va));
}

void main() {
//void mainImage( out vec4 fragColor, in vec2 fragCoord) {
  vec2 fragCoord = gl_FragCoord.xy;
  vec4 fragColor;

  vec2 p = (-iResolution.xy + 2.0*fragCoord)/iResolution.y;
  vec3 n = noised(8.0*p);
  vec3 col = 0.5 + 0.5*n.xxx;

//  vec3 col = 0.5 + 0.5*( (p.x>0.0) ? n.yzx : n.xxx);
  fragColor = vec4(col, 1.0);

  gl_FragColor = fragColor;
}
