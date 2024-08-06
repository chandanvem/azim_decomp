function reconstructed_dataset = azimuthal_reconstruction(input_file_name_path,...
                         src_blk,first_azi_mode,last_azi_mode,field_name,theta)

        for azi_mode = first_azi_mode : last_azi_mode

            dataset_path =   sprintf('/%s/azi_mode_%d/%d',field_name,abs(azi_mode),src_blk);
            azi_mode_slice = read_hdf5_2D_slice_from_file(input_file_name_path,dataset_path,'complex');

            if azi_mode < 0
               azi_mode_slice = conj(azi_mode_slice);
            end
            
            if azi_mode == first_azi_mode
               
               [Nx,Nr]  = size(azi_mode_slice);
               Ntheta = length(theta);
               reconstructed_dataset = zeros(Nx,Nr,Ntheta);
             
            end
            
            for theta_idx = 1 : Ntheta
                reconstructed_dataset(:,:,theta_idx) = reconstructed_dataset(:,:,theta_idx) + ...
                               squeeze(azi_mode_slice * exp(1i * azi_mode*theta(theta_idx)));
            end
        end    
        reconstructed_dataset = real(reconstructed_dataset);       
end