function dataset = read_grid_data_for_centerline_mesh_physical_domain...
                   (LES_data_file_name,phase_name,grid_name,field_name,src_blk)

if contains(field_name,'x')
    field_name_updated = 'x';
elseif contains(field_name,'y')
    field_name_updated = 'y';
elseif contains(field_name,'z')
    field_name_updated = 'z';
end    


axial_extent_nozzle_downstream = 565;
dataset_path = sprintf('/%s//source_blocks/%d/%s',grid_name,src_blk,field_name_updated);
dataset = h5read(LES_data_file_name,dataset_path);
dataset = permute(dataset, [3, 2, 1]);


[Nx,Nr,N_theta] = size(dataset);

if src_blk == 2
    dataset = dataset(1:axial_extent_nozzle_downstream,:,:);  
end

end