function [] =  do_azimuthal_decomposition_given_field_names_func(centerline_data_file_name,...
               centerline_grid_name,LES_data_file_name,new_src_blk_start_idx,...
               new_src_blk_end_idx,phase_name,grid_name,field_names,...
               p_inf,rho_inf,c_inf,azi_mode_start,azi_mode_end,h5OutName,...
                write_concat_file_flag,concat_op_file_name)


if strcmp(write_concat_file_flag,'write_concat_file')
   
    if exist(concat_op_file_name,'file')
       delete(concat_op_file_name);
    end

end

for new_src_blk_id = new_src_blk_start_idx : new_src_blk_end_idx
    
    fprintf('Reading primitive data to be written to src blk %d\n',new_src_blk_id);
    prims_dataset = get_concat_data_cyl_grid_from_LES_data(centerline_data_file_name,...
             centerline_grid_name,LES_data_file_name,phase_name,grid_name,new_src_blk_id,'primitives');
    rho = prims_dataset{1}; u = prims_dataset{2};
    v =   prims_dataset{3}; w = prims_dataset{4};
    p = prims_dataset{5};
    fprintf('Primitive data to be written to src blk %d read \n',new_src_blk_id);
    [Nx,Nr,Ntheta] = size(p);    

    if strcmp(write_concat_file_flag,'write_concat_file')
        write_concat_fields_to_file(concat_op_file_name,rho,u,v,w,p,phase_name,new_src_blk_id);        
        fprintf('Concatenated data written for %d \n',new_src_blk_id);
    end

    for field_name_idx = 1 : length(field_names)

        dataset = get_derived_quantity_from_prims(field_names{field_name_idx},rho,u,v,w,p,p_inf,rho_inf,c_inf);
        do_azimuthal_decomposition_and_write_to_file(dataset,...
                     azi_mode_start,azi_mode_end,field_names{field_name_idx},new_src_blk_id,h5OutName);

    end
    

end

end








