clear all; close all;

%import data
A = importdata("data.txt",";");

%sort it out
x = A(:,2);
y = A(:,3);
i = A(:,1);
dBm = A(:,4);

%fix dBm since 0 is wayyy to high when values are in -80 to -60 range
replacement_const = -100;
dBm(dBm==0)=replacement_const;

%variance for sorta "grid" between minimum and max x and y vals
x_variance = min(x) : (max(x)-min(x))/50 : max(x);
y_variance = min(y) : (max(y)-min(y))/50 : max(y);

%meshgrid for usage in interp functions
[x_meshgrid,y_meshgrid] = meshgrid( x_variance, y_variance );

%actual interping, this one is for internet speeds
ioutlin = griddata( x, y, i, x_meshgrid,y_meshgrid, 'linear' ); % only C0 continuity
ioutv4 = griddata( x, y, i, x_meshgrid,y_meshgrid, 'v4' ); % <-- so far the best, C2!
ioutnea = griddata( x, y, i, x_meshgrid,y_meshgrid, 'nearest' ); % no continuity, but safe
ioutnat = griddata( x, y, i, x_meshgrid,y_meshgrid, 'natural' ); % only C1 continuity

%and one for dBm
doutlin = griddata( x, y, dBm, x_meshgrid,y_meshgrid, 'linear' );
doutv4 = griddata( x, y, dBm, x_meshgrid,y_meshgrid, 'v4' );
doutnea = griddata( x, y, dBm, x_meshgrid,y_meshgrid, 'nearest' );
doutnat = griddata( x, y, dBm, x_meshgrid,y_meshgrid, 'natural' );

%first set of plots
ti=tiledlayout(2,2);
title(ti,"Wartości szybkości internetu")

%plotting each one to a seperate tile
nexttile; 
hold on; 
surf( x_variance,y_variance,ioutlin,FaceAlpha=0.8 ); plot3(x,y,i,"r.",MarkerSize=16);
hold off;
colorbar; title("Interpolacja Liniowa");
xlim([min(x),max(x)]); ylim([min(y),max(y)]);

nexttile;
hold on;
surf( x_variance,y_variance,ioutv4,FaceAlpha=0.8 ); plot3(x,y,i,"r.",MarkerSize=16);
hold off; 
colorbar; title("Interpolacja V4 (biharmonic spline)");
xlim([min(x),max(x)]); ylim([min(y),max(y)]);

nexttile;
hold on;
surf( x_variance,y_variance,ioutnea,FaceAlpha=0.8 ); plot3(x,y,i,"r.",MarkerSize=16); 
hold off;
colorbar; title("Interpolacja po najbliższym");
xlim([min(x),max(x)]); ylim([min(y),max(y)]);

nexttile;
hold on;
surf( x_variance,y_variance,ioutnat,FaceAlpha=0.8 ); plot3(x,y,i,"r.",MarkerSize=16);
hold off;
colorbar; title("Interpolacja Naturalna");
xlim([min(x),max(x)]); ylim([min(y),max(y)]);

% Now let's do the same, but for dBm
figure;
td = tiledlayout(2,2);
title(td,"Wartości dBm");

%plotting each one to a seperate tile
nexttile; 
hold on; 
surf( x_variance,y_variance,doutlin,FaceAlpha=0.8 ); plot3(x,y,dBm,"r.",MarkerSize=16);
hold off;
colorbar; title("Interpolacja Liniowa");
xlim([min(x),max(x)]); ylim([min(y),max(y)]);

nexttile;
hold on;
surf( x_variance,y_variance,doutv4,FaceAlpha=0.8 ); plot3(x,y,dBm,"r.",MarkerSize=16);
hold off; 
colorbar; title("Interpolacja V4 (biharmonic spline)");
xlim([min(x),max(x)]); ylim([min(y),max(y)]);

nexttile;
hold on;
surf( x_variance,y_variance,doutnea,FaceAlpha=0.8 ); plot3(x,y,dBm,"r.",MarkerSize=16); 
hold off;
colorbar; title("Interpolacja po najbliższym");
xlim([min(x),max(x)]); ylim([min(y),max(y)]);

nexttile;
hold on;
surf( x_variance,y_variance,doutnat,FaceAlpha=0.8 ); plot3(x,y,dBm,"r.",MarkerSize=16);
hold off;
colorbar; title("Interpolacja Naturalna");
xlim([min(x),max(x)]); ylim([min(y),max(y)]);
