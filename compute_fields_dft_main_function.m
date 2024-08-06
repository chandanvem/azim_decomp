function [] = compute_fields_dft_main_function(azi_decomp_data_dir,azi_decomp_filename_prefix,src_blk_list,field_names,...
    time_series_start_idx,time_series_end_idx,azi_mode_start_idx,azi_mode_end_idx,window_type,h5OutName)


nfft = time_series_end_idx - time_series_start_idx + 1;


for src_blk_id_idx = 1 : length(src_blk_list)
    src_blk_id = src_blk_id(src_blk_id_idx);

    for azi_mod_idx = azi_mode_start_idx : azi_mode_end_idx

        for field_name_idx = 1 : length(field_names)

            for time_stamp_idx = time_series_start_idx : time_series_end_idx

                time_series_file_name = sprintf('%s/%s_%d',azi_decomp_data_dir,azi_decomp_filename_prefix,time_stamp_idx);

                dataset_path = sprintf('/%s/azi_mode_idx_%d/%d',field_names{field_name_idx},azi_mod_idx,src_blk_id);
                dataset_for_time_stamp_idx = read_hdf5_2D_data_from_file(time_series_file_name,dataset_path,'complex');

                if time_stamp_idx == time_series_start_idx

                   [Nx,Nr]   = size(dataset_for_time_stamp_idx);
                   time_series_data = zeros(nfft,Nx,Nr);  

                end
                
                time_series_data(time_stamp_idx - time_series_start_idx + 1,Nx,Nr) = dataset_for_time_stamp_idx;
                

            end

            time_series_data_dft_subset_of_interest = perform_fourier_transform_on_2D_time_series_data(time_series_data,window_type,freq_end_index);

            clear time_series_data;

            for freq_index = 1 : freq_end_index 

                
                output_dataset_path  = sprintf('/%s/freq_idx_%d/azi_mode_idx_%d/%d',field_names{field_name_idx},freq_index,azi_mod_idx,src_blk_id);
                write_2D_slice_to_file(h5OutName,output_dataset_path,squeeze(time_series_data_dft_subset_of_interest(freq_index,:,:)),'complex');          


            end

            clear time_series_data_dft_subset_of_interest;

            fprintf('DFT computed and written for azi mode %d of source block %d for field %s\n',azi_mod_idx,src_blk_id,field_names{field_name_idx});

        end

    end

end

end






