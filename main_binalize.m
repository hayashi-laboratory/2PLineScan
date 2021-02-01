clear all;

addpath('Bilateral Filtering')

global qext_list

ii=1;
qext_list(ii).ext = '.bmp'; ii=ii+1;
qext_list(ii).ext = '.jpg'; ii=ii+1;
qext_list(ii).ext = '.jpeg'; ii=ii+1;
qext_list(ii).ext = '.png'; ii=ii+1;
qext_list(ii).ext = '.tif'; ii=ii+1;

GUI_binalize;

