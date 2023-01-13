clear all; close all;
A = importdata("data.txt",";");
x = A(:,2);
y = A(:,3);
z = A(:,1);
%figure; grid; plot3(x,y,z,'.');

xvar = min(x) : (max(x)-min(x))/50 : max(x);
yvar = min(y) : (max(y)-min(y))/50 : max(y);
[Xi,Yi] = meshgrid( xvar, yvar );
outc = griddata( x, y, z, Xi,Yi, 'cubic' );
outl = griddata( x, y, z, Xi,Yi, 'linear' );
outv = griddata( x, y, z, Xi,Yi, 'v4' ); % <-- so far the best
outn = griddata( x, y, z, Xi,Yi, 'nearest' );
outnn = griddata( x, y, z, Xi,Yi, 'natural' );
figure; surf( outc ); colorbar; 
xlim([1,51]); ylim([1,51]); % hardcoded to the current values
figure; surf( outl ); colorbar; 
xlim([1,51]); ylim([1,51]); % hardcoded to the current values
figure; surf( outv ); colorbar; 
xlim([1,51]); ylim([1,51]); % hardcoded to the current values
figure; surf( outn ); colorbar; 
xlim([1,51]); ylim([1,51]); % hardcoded to the current values
figure; surf( outnn ); colorbar; 
xlim([1,51]); ylim([1,51]); % hardcoded to the current values
