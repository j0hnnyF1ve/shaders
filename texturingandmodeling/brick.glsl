// Texturing and Modeling, p.36-37

/*
#define BRICKWIDTH        0.25;
#define BRICKHEIGHT       0.08;
#define MORTARTHICKNESS   0.01;

#define BMWIDTH           (BRICKWIDTH + MORTARTHICKNESS);
#define BMHEIGHT          (BRICKHEIGHT + MORTARTHICKNESS);
#define MWF               (MORTARTHICKNESS*0.5/BMWIDTH);
#define MHF               (MORTARTHICKNESS*0.5/BMHEIGHT);
*/

/*
uniform float Ka;
uniform float Kd;
uniform vec3 Cbrick;
uniform vec3 Cmortar;
*/
void main() {
  float BRICKWIDTH        = 0.25;
  float BRICKHEIGHT       = 0.08;
  float MORTARTHICKNESS   = 0.01;

  float BMWIDTH           = (BRICKWIDTH + MORTARTHICKNESS);
  float BMHEIGHT          = (BRICKHEIGHT + MORTARTHICKNESS);
  float MWF               = (MORTARTHICKNESS*0.5/BMWIDTH);
  float MHF               = (MORTARTHICKNESS*0.5/BMHEIGHT);


  vec3 Ct;
  vec3 Nf;

  float Ka, Kd;
  vec3 Cbrick, Cmortar;

  float ss, tt, sbrick, tbrick, w, h;
  float scoord;
  float tcoord;

  vec2 uv = gl_FragCoord.xy / u_resolution;

  Ka = 1.;
  Kd = 1.;
  Cbrick = vec3(0.5, 0.15, 0.14);
  Cmortar = vec3(0.5, 0.5, 0.5);

  scoord = uv.x;
  tcoord = uv.y;

  ss = scoord / BMWIDTH;
  tt = tcoord / BMHEIGHT;

  if(mod(tt*0.5, 1.) > 0.5) {
    ss += 0.5;
  }

  sbrick = floor(ss);
  tbrick = floor(tt);
  ss -= sbrick;
  tt -= tbrick;

  w = step(MWF, ss) - step(1.-MWF, ss);
  h = step(MHF, tt) - step(1.-MHF, tt);

  Ct = mix(Cmortar, Cbrick, w*h);

  float ambient = 1.;
  float diffuse = 1.;

  gl_FragColor = vec4( Ct * (Ka * ambient + Kd * diffuse), 1.0);
//  gl_FragColor = vec4(1.0, 0.75, 0.5, 1.0);
}
