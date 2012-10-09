void EvolveValuesRK2_2(float *dT, float *outConservative, //OP_RW, discard
            float *inConservative, //OP_READ, discard
            float *MidPointConservative, //OP_READ, discard
            float *out) //OP_WRITE

{
  outConservative[0] = 0.5*(outConservative[0] * *dT + MidPointConservative[0] + inConservative[0]);
  outConservative[1] = 0.5*(outConservative[1] * *dT + MidPointConservative[1] + inConservative[1]);
  outConservative[2] = 0.5*(outConservative[2] * *dT + MidPointConservative[2] + inConservative[2]);

  outConservative[0] = outConservative[0] <= EPS ? EPS : outConservative[0];
  outConservative[3] = inConservative[3];

  //call to ToPhysicalVariables inlined
  float TruncatedH = outConservative[0] < EPS ? EPS : outConservative[0];
  out[0] = outConservative[0];
  out[1] = outConservative[1] / TruncatedH;
  out[2] = outConservative[2] / TruncatedH;
  out[3] = outConservative[3];
}
