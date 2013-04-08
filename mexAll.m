fprintf('Compiling files...\n');

dirName = fileparts(mfilename('fullpath'));
addpath(genpath(dirName));
cd(dirName);

compName = computer;



delete(['kernel/gcc/*',mexext]);
delete(['kernel/other/*',mexext]);
delete(['kernel/*',mexext]);

if ~strcmp(compName(1:2),'PC')
    fprintf('Compiling with g++-4.2 - If it is not installed please change mexAll.m \n');
    mex CXX=g++-4.2 -Ikernel/gcc kernel/gcc/icdChi2.cpp -outdir kernel
else
    fprintf('The optimized version of this code has been made to compile with g++ - If g++ is installed please change mexAll.m \n');
    mex -Ikernel/other kernel/other/icd_chi2.c -outdir kernel
end
mex -ILaplacianMatrix LaplacianMatrix/graphLap.cpp -outdir LaplacianMatrix


mex -IconvexQuadratic/Optim_on_the_elliptope_modified/mex_sources ...
    convexQuadratic/Optim_on_the_elliptope_modified/mex_sources/normalize_rows_new.cpp ...
    -outdir convexQuadratic/Optim_on_the_elliptope_modified/mex_sources


mex -IconvexQuadratic/Optim_on_the_elliptope_modified/mex_sources ...
    convexQuadratic/Optim_on_the_elliptope_modified/mex_sources/aux_fct_new.cpp ...
    -outdir convexQuadratic/Optim_on_the_elliptope_modified/mex_sources


