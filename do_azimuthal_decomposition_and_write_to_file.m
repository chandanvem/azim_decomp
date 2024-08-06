function []  = do_azimuthal_decomposition_and_write_to_file(dataset,...
                        azi_mode_start,azi_mode_end,field_name,new_src_blk_id,h5OutName)


[N_axial,N_r,N_theta] = size(dataset);

nfft_theta = N_theta - 1;
dataset_fft = fft(dataset, nfft_theta, 3)/nfft_theta;

for n_azi = azi_mode_start : azi_mode_end
%     if(n_azi == 0) 
       dataset_azi_mode = squeeze(dataset_fft(:,:,(n_azi+1)));
       dataset_path = sprintf('/%s/azi_mode_%d/%d', field_name, n_azi,new_src_blk_id);
       write_2D_slice_to_file(h5OutName,dataset_path,dataset_azi_mode,'complex');
% 
%     else 
%        
% %        azi_mode_idx = 2*n_azi; 
%        dataset_azi_mode = squeeze(dataset_fft(:,:,(n_azi+1)));
%        dataset_path = sprintf('/%s/azi_mode_%d/%d', field_name, n_azi,new_src_blk_id);
%        write_2D_slice_to_file(h5OutName,dataset_path,dataset_azi_mode,'complex'); 
      
%        azi_mode_idx = 2*n_azi+1;   % negative frequencies
%        dataset_azi_mode = squeeze(dataset_fft(:,:,nfft_theta-(n_azi-1)));
%        dataset_path = sprintf('/%s/azi_mode_idx_%d/%d', field_name, azi_mode_idx,new_src_blk_id);
%        write_2D_slice_to_file(h5OutName,dataset_path,dataset_azi_mode,'complex');

%     end


end

end