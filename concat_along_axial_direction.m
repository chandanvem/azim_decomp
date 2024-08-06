function dataset_concatenated = concat_along_axial_direction(LES_data_file_name,field_name,phase_name,grid_name,src_blks,prims_metrics_flag)

Nx_concatenated = 0;

for ii = 1: length(src_blks)

    if strcmp(prims_metrics_flag,'primitives')
       dataset{ii} = read_prim_data_for_physical_domain(LES_data_file_name,phase_name,grid_name,field_name,src_blks(ii));
    elseif strcmp(prims_metrics_flag,'metrics')   
        dataset{ii} = read_grid_data_for_physical_domain(LES_data_file_name,phase_name,grid_name,field_name,src_blks(ii));
    end
    [Nx{ii},Nr{ii},N_theta{ii}] = size(dataset{ii});
    Nx_concatenated = Nx_concatenated + Nx{ii};
end

Nx_concatenated = Nx_concatenated - length(src_blks) + 1;

dataset_concatenated = zeros(Nx_concatenated,Nr{1},N_theta{1});

for ii = 1 : length(src_blks)

    if ii == 1
        dataset_concatenated(1:Nx{1},:,:) = dataset{1};
        start_idx = Nx{1};
    else
        dataset_concatenated(start_idx:start_idx  + Nx{ii} -1,:,:) = dataset{ii};
        start_idx = start_idx + Nx{ii}-1;
    end
end


end