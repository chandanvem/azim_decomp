function dataset_concatenated_to_single_cylindrical_grid = concat_nozzle_sides_grid(LES_data_file_name,...
                                        phase_name,grid_name,prims_name,first_src_blk,prims_metrics_flag)

count = 1;
for ii = first_src_blk: first_src_blk + 3 
    
    if strcmp(prims_metrics_flag,'primitives')
       dataset_quadrant{count} = read_prim_data_for_physical_domain(LES_data_file_name,phase_name,grid_name,prims_name,ii);
    elseif strcmp(prims_metrics_flag,'metrics')
       dataset_quadrant{count} = read_grid_data_for_physical_domain(LES_data_file_name,phase_name,grid_name,prims_name,ii); 
    end
    count = count +1 ; 

end

dataset_concatenated_to_single_cylindrical_grid = concat_along_theta(dataset_quadrant);



end








