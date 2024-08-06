function dataset = read_prim_data_for_physical_domain(LES_data_file_name,phase_name,grid_name,field_name,src_blk)

axial_extent_nozzle_downstream = 565;
axial_extent_nozzle_sides = 26;
radial_extent = 184;
dataset_path = sprintf('/%s/%s/fields/%d/%s',phase_name,grid_name,src_blk,field_name);
dataset = h5read(LES_data_file_name,dataset_path);
dataset = permute(dataset, [3, 2, 1]);


[Nx,Nr,N_theta] = size(dataset);

if ismember(src_blk,8:11)
    dataset = dataset(:,:,1:N_theta);
elseif ismember(src_blk,12:15)
    dataset = dataset(:,:,1:N_theta);
elseif ismember(src_blk, 16:19)
    dataset = dataset(1:axial_extent_nozzle_downstream,:,1:N_theta);
elseif ismember(src_blk, 20:23)
    dataset = dataset(1:axial_extent_nozzle_downstream,:,1:N_theta);
elseif ismember(src_blk, 24:27)
    dataset = dataset(1:axial_extent_nozzle_downstream,1: radial_extent,1:N_theta);
elseif ismember(src_blk, 28:31)
    dataset = dataset(:,1: radial_extent,1:N_theta);
elseif ismember(src_blk, 32:35)
    dataset = dataset(axial_extent_nozzle_sides:end,1:radial_extent,1:N_theta);
end

end