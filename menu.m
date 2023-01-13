clear all; close all;
A = importdata("data.txt",";");
x = A(:,2);
y = A(:,3);
z = A(:,1);
%figure; grid; plot3(x,y,z,'.');

xvar = min(x) : (max(x)-min(x))/50 : max(x);
yvar = min(y) : (max(y)-min(y))/50 : max(y);
[Xi,Yi] = meshgrid( xvar, yvar );
%outc = griddata( x, y, z, Xi,Yi, 'cubic' ); % <-- Does NOT support 3d
%plots
outl = griddata( x, y, z, Xi,Yi, 'linear' ); % only C0 continuity
outv = griddata( x, y, z, Xi,Yi, 'v4' ); % <-- so far the best, C2!
outn = griddata( x, y, z, Xi,Yi, 'nearest' ); % no continuity, but safe
outnn = griddata( x, y, z, Xi,Yi, 'natural' ); % only C1 continuity
%figure; surf( outc ); colorbar; title("Cubic interpolation");
%xlim([1,51]); ylim([1,51]); % hardcoded to the current values
figure; surf( outl ); colorbar; title("Linear interpolation");
xlim([1,51]); ylim([1,51]); % hardcoded to the current values
figure; surf( outv ); colorbar; title("V4 (biharmonic spline) interpolation");
xlim([1,51]); ylim([1,51]); % hardcoded to the current values
figure; surf( outn ); colorbar; title("Nearest interpolation");
xlim([1,51]); ylim([1,51]); % hardcoded to the current values
figure; surf( outnn ); colorbar; title("Natural interpolation");
xlim([1,51]); ylim([1,51]); % hardcoded to the current values
