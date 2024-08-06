function dataset = read_prim_data_for_centerline_mesh_physical_domain(LES_data_file_name,...
                                                   phase_name,grid_name,field_name,src_blk)

axial_extent_nozzle_downstream = 565;
dataset_path = sprintf('/%s/%s/fields/%d/%s',phase_name,grid_name,src_blk,field_name);
dataset = h5read(LES_data_file_name,dataset_path);
dataset = permute(dataset, [3, 2, 1]);


[Nx,Nr,N_theta] = size(dataset);

if src_blk == 3
   dataset = dataset(1:axial_extent_nozzle_downstream,:,:);  
end

end