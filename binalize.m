function BW = binalize( img, lw )

si = size(img);
lwh = lw/2;
BW = zeros( si(1:2) );
h = waitbar(0,'Please wait...');
for ix=1:si(2)
	for iy=1:si(1)
		ys = iy-lwh;
		if ys < 1
			ys=1;
		end

		ye=ys+lw;
		if ye > si(1)
			ye = si(1);
			ys = ye-lw;
		end

		iyl = iy-ys+1;

		BWl = imbinarize( img(ys:ye,ix) );
		
		BW(iy,ix) =BWl(iyl);
	end
	 waitbar( ix / si(2) )
end
close(h)
