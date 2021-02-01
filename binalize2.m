function BW = binalize2( img, k )

si = size(img);
BW = zeros( si(1:2) );
h = waitbar(0,'binalize...');
for ix=1:si(2)

	[idx,C] = kmeans( img(:,ix), k, 'MaxIter',1000 );

	[ cmin idmin ] = min( C );

	id = find( idx ~= idmin );
	BW(id,ix) = 1;

	 waitbar( ix / si(2), h )
end
close(h)
