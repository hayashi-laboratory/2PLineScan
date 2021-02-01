function data_list = get_data_list( indir, qext_list )


data_list = [];

%指定ﾌｫﾙﾀﾞ内をサーチ
num_data = 0;
flist = dir( indir );
for ii = 1: length( flist )
    
    if strcmp( flist(ii).name, '.')==1 || strcmp( flist(ii).name, '..')==1
        
    else
	    [PATH, NAME, EXT] = fileparts( flist(ii).name );

	for iq = 1:length( qext_list )
	        if strcmpi( EXT, qext_list(iq).ext ) == 1
    			num_data = num_data + 1;
        		data_list(num_data).file_base = NAME;
			data_list(num_data).dir = indir;
    			data_list(num_data).file_name = [ indir '/'  flist(ii).name ];
			break;
	        end
	end
    end
    
end


