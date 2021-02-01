function [ B Xrange Yrange ] = slope_LS( BW, lmin )

%{
calculate slope by least square method.
(y = ax + b)

B(N,D) : 
	B(:,1): b (intercept)
	B(:,2): a (slope)

Xrange : x range of line
Yrange : y range of line
%}


%Black-and-white inverted
BW = not(BW);

%labeling
L = bwlabel(BW);

num_region = max(L(:));

nr = 0;
for ic=1:num_region
	[y x] = find(L==ic);

	xmin = min(x);	xmax = max(x);
	ymin = min(y);	ymax = max(y);

	dx = xmax-xmin;
	dy = ymax-ymin;
	l = sqrt( dx*dx + dy*dy );
	%fprintf( '%3d l=%f', ic, l );
	if l < lmin
		continue
	end

	%least square regression (1st order)
	X1 = [ ones(length(x),1) x ];
	Y = y;
	try
		b = (X1'*X1)\(X1'*Y);
	catch
		continue
	end

	xr = [ xmin xmax ]';
	xx = [ ones(length(xr),1) xr ];
	yr = xx*b;


	dx = xr(2) - xr(1);
	dy = yr(2) - yr(1);
	l = sqrt( dx*dx + dy*dy );
	if l < lmin
		continue
	end

	nr = nr+1;

	B(nr,:) = b;
	Xrange(nr,:) = xr;
	Yrange(nr,:) = yr;


	%debug
	%{
	BW2 = zeros( size(BW) );
	for ii=1:length(x)
		BW2(y(ii), x(ii)) = 255;
	end
	figure
	imshow( uint8(BW2) );
	hold on
	plot( xr, yr, '-r');
	pause
	%}


end


