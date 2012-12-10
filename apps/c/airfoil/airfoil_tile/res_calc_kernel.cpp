//
// auto-generated by op2.m on 16-Oct-2012 15:15:09
//

// user function

#include "res_calc.h"


// x86 kernel function

void op_x86_res_calc(
  int    blockIdx,
  double *ind_arg0,
  double *ind_arg1,
  double *ind_arg2,
  double *ind_arg3,
  int   *ind_map,
  short *arg_map,
  int   *ind_arg_sizes,
  int   *ind_arg_offs,
  int    block_offset,
  int   *blkmap,
  int   *offset,
  int   *nelems,
  int   *ncolors,
  int   *colors,
  int   set_size) {

  double arg6_l[4];
  double arg7_l[4];

  int   *ind_arg0_map, ind_arg0_size;
  int   *ind_arg1_map, ind_arg1_size;
  int   *ind_arg2_map, ind_arg2_size;
  int   *ind_arg3_map, ind_arg3_size;
  double *ind_arg0_s;
  double *ind_arg1_s;
  double *ind_arg2_s;
  double *ind_arg3_s;
  int    nelem, offset_b;

  char shared[128000];

  if (0==0) {

    // get sizes and shift pointers and direct-mapped data

    int blockId = blkmap[blockIdx + block_offset];
    nelem    = nelems[blockId];
    offset_b = offset[blockId];

    ind_arg0_size = ind_arg_sizes[0+blockId*4];
    ind_arg1_size = ind_arg_sizes[1+blockId*4];
    ind_arg2_size = ind_arg_sizes[2+blockId*4];
    ind_arg3_size = ind_arg_sizes[3+blockId*4];

    ind_arg0_map = &ind_map[0*set_size] + ind_arg_offs[0+blockId*4];
    ind_arg1_map = &ind_map[2*set_size] + ind_arg_offs[1+blockId*4];
    ind_arg2_map = &ind_map[4*set_size] + ind_arg_offs[2+blockId*4];
    ind_arg3_map = &ind_map[6*set_size] + ind_arg_offs[3+blockId*4];

    // set shared memory pointers

    int nbytes = 0;
    ind_arg0_s = (double *) &shared[nbytes];
    nbytes    += ROUND_UP(ind_arg0_size*sizeof(double)*2);
    ind_arg1_s = (double *) &shared[nbytes];
    nbytes    += ROUND_UP(ind_arg1_size*sizeof(double)*4);
    ind_arg2_s = (double *) &shared[nbytes];
    nbytes    += ROUND_UP(ind_arg2_size*sizeof(double)*1);
    ind_arg3_s = (double *) &shared[nbytes];
  }

  // copy indirect datasets into shared memory or zero increment

  for (int n=0; n<ind_arg0_size; n++)
    for (int d=0; d<2; d++)
      ind_arg0_s[d+n*2] = ind_arg0[d+ind_arg0_map[n]*2];

  for (int n=0; n<ind_arg1_size; n++)
    for (int d=0; d<4; d++)
      ind_arg1_s[d+n*4] = ind_arg1[d+ind_arg1_map[n]*4];

  for (int n=0; n<ind_arg2_size; n++)
    for (int d=0; d<1; d++)
      ind_arg2_s[d+n*1] = ind_arg2[d+ind_arg2_map[n]*1];

  for (int n=0; n<ind_arg3_size; n++)
    for (int d=0; d<4; d++)
      ind_arg3_s[d+n*4] = ZERO_double;


  // process set elements

  for (int n=0; n<nelem; n++) {

    // initialise local variables

    for (int d=0; d<4; d++)
      arg6_l[d] = ZERO_double;
    for (int d=0; d<4; d++)
      arg7_l[d] = ZERO_double;




    // user-supplied kernel call


    res_calc(  ind_arg0_s+arg_map[0*set_size+n+offset_b]*2,
               ind_arg0_s+arg_map[1*set_size+n+offset_b]*2,
               ind_arg1_s+arg_map[2*set_size+n+offset_b]*4,
               ind_arg1_s+arg_map[3*set_size+n+offset_b]*4,
               ind_arg2_s+arg_map[4*set_size+n+offset_b]*1,
               ind_arg2_s+arg_map[5*set_size+n+offset_b]*1,
               arg6_l,
               arg7_l );

    // store local variables

    int arg6_map = arg_map[6*set_size+n+offset_b];
    int arg7_map = arg_map[7*set_size+n+offset_b];

    for (int d=0; d<4; d++)
      ind_arg3_s[d+arg6_map*4] += arg6_l[d];

    for (int d=0; d<4; d++)
      ind_arg3_s[d+arg7_map*4] += arg7_l[d];
  }

  // apply pointered write/increment

  for (int n=0; n<ind_arg3_size; n++)
    for (int d=0; d<4; d++)
      ind_arg3[d+ind_arg3_map[n]*4] += ind_arg3_s[d+n*4];

}


// host stub function

void op_par_loop_res_calc(op_kernel_descriptor *desc ){

  char const *name = desc->name;
  op_set set = desc->set;
  op_arg arg0 = desc->args[0];
  op_arg arg1 = desc->args[1];
  op_arg arg2 = desc->args[2];
  op_arg arg3 = desc->args[3];
  op_arg arg4 = desc->args[4];
  op_arg arg5 = desc->args[5];
  op_arg arg6 = desc->args[6];
  op_arg arg7 = desc->args[7];

  int    nargs   = 8;
  op_arg args[8];

  args[0] = arg0;
  args[1] = arg1;
  args[2] = arg2;
  args[3] = arg3;
  args[4] = arg4;
  args[5] = arg5;
  args[6] = arg6;
  args[7] = arg7;

  int    ninds   = 4;
  int    inds[8] = {0,0,1,1,2,2,3,3};

  if (OP_diags>2) {
    printf(" kernel routine with indirection: %s\n", name);
  }

  
  char  *p_a[8] = {0,0,0,0,0,0,0,0};
  
  // initialise timers
  double cpu_t1, cpu_t2, wall_t1, wall_t2;
  op_timers_core(&cpu_t1, &wall_t1);
  
  for (int col = 0; col < desc->subset->ncolors; col++) {
        //printf("kernel %s color %d from %d to %d\n", name, col, desc->subset->color_offsets[2*col], desc->subset->color_offsets[2*col+1]);
    #pragma omp parallel for private(p_a)
    for (int n=desc->subset->color_offsets[2*col]; n<desc->subset->color_offsets[2*col+1]; n++) {
//      op_arg_set(n,args[0], &p_a[0],0);
//      op_arg_set(n,args[1], &p_a[1],0);
//      op_arg_set(n,args[2], &p_a[2],0);
//      op_arg_set(n,args[3], &p_a[3],0);
//      op_arg_set(n,args[4], &p_a[4],0);
//      op_arg_set(n,args[5], &p_a[5],0);
//      op_arg_set(n,args[6], &p_a[6],0);
//      op_arg_set(n,args[7], &p_a[7],0);


      // call kernel function, passing in pointers to data
      //printf("%d\t%d\n", arg6.map->map[arg6.idx+n*arg6.map->dim], arg7.map->map[arg7.idx+n*arg7.map->dim]);
      res_calc( (double *)(arg0.data + arg0.size*arg0.map->map[arg0.idx+n*arg0.map->dim]),
               (double *)(arg1.data + arg1.size*arg1.map->map[arg1.idx+n*arg1.map->dim]),
               (double *)(arg2.data + arg2.size*arg2.map->map[arg2.idx+n*arg2.map->dim]),
               (double *)(arg3.data + arg3.size*arg3.map->map[arg3.idx+n*arg3.map->dim]),
               (double *)(arg4.data + arg4.size*arg4.map->map[arg4.idx+n*arg4.map->dim]),
               (double *)(arg5.data + arg5.size*arg5.map->map[arg5.idx+n*arg5.map->dim]),
               (double *)(arg6.data + arg6.size*arg6.map->map[arg6.idx+n*arg6.map->dim]),
               (double *)(arg7.data + arg7.size*arg7.map->map[arg7.idx+n*arg7.map->dim]) );
    }
  }
  
  // update timer record
  op_timers_core(&cpu_t2, &wall_t2);
  op_timing_realloc(2);
  OP_kernels[2].time     += wall_t2 - wall_t1;

}

void op_par_loop_res_calc_enqueue(char const *name, op_set set,
                                  op_arg arg0,
                                  op_arg arg1,
                                  op_arg arg2,
                                  op_arg arg3,
                                  op_arg arg4,
                                  op_arg arg5,
                                  op_arg arg6,
                                  op_arg arg7) {
  op_kernel_descriptor kern;
  kern.name = name;
  kern.set = set;
  kern.nargs = 8;
  kern.args = (op_arg *)malloc(8*sizeof(op_arg));
  kern.args[0] = arg0;
  kern.args[1] = arg1;
  kern.args[2] = arg2;
  kern.args[3] = arg3;
  kern.args[4] = arg4;
  kern.args[5] = arg5;
  kern.args[6] = arg6;
  kern.args[7] = arg7;
  kern.function = op_par_loop_res_calc;
  kernel_list.push_back(kern);
}