function prims_dataset = ...
    get_concat_data_cyl_grid_from_LES_data(centerline_data_file_name,...
       centerline_grid_name,LES_data_file_name,phase_name,grid_name,new_src_blk_id,prims_metrics_flag)


if strcmp(prims_metrics_flag,'primitives')
    prim_names = {'density','u_velocity','v_velocity','w_velocity','pressure'};

elseif strcmp('metrics',prims_metrics_flag)
    prim_names = {'xcoord','ycoord','zcoord'};

end

for prims_dataset_idx = 1 : length(prim_names)

    if ismember(new_src_blk_id,[0,1,2,3])
        
        if strcmp(prims_metrics_flag,'primitives')
           prims_dataset{prims_dataset_idx} = ...
           read_prim_data_for_centerline_mesh_physical_domain(centerline_data_file_name,...
                         phase_name,centerline_grid_name,prim_names{prims_dataset_idx},new_src_blk_id);
        elseif strcmp(prims_metrics_flag,'metrics')
           prims_dataset{prims_dataset_idx} = ...
                read_grid_data_for_centerline_mesh_physical_domain(centerline_data_file_name,...
                          phase_name,centerline_grid_name,prim_names{prims_dataset_idx},new_src_blk_id);
        end

    elseif new_src_blk_id == 4

        prims_dataset{prims_dataset_idx} = concat_chamber_grid(LES_data_file_name,...
                        phase_name,grid_name,prim_names{prims_dataset_idx},prims_metrics_flag);

% 
        %         if strcmp(prim_names{ii},'density')
        %             assignin('base','density_orig',prims_dataset{ii});
        %         end

    elseif new_src_blk_id == 5

        prims_dataset{prims_dataset_idx} = concat_nozzle_sides_grid(LES_data_file_name,...
                  phase_name,grid_name,prim_names{prims_dataset_idx},28,prims_metrics_flag);

    elseif new_src_blk_id == 6

        prims_dataset{prims_dataset_idx} = concat_nozzle_sides_grid(LES_data_file_name,...
                 phase_name,grid_name,prim_names{prims_dataset_idx},32,prims_metrics_flag);

    elseif new_src_blk_id == 7

        prims_dataset{prims_dataset_idx} = concat_nozzle_interior_grid(LES_data_file_name,...
                   phase_name,grid_name,prim_names{prims_dataset_idx},prims_metrics_flag);

    end


end
















