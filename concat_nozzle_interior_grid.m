function dataset_concatenated_to_single_cylindrical_grid = concat_nozzle_interior_grid(LES_data_file_name,...
             phase_name,grid_name,prims_name,prims_metrics_flag)

count = 1;

% src_blks = [0,4,8,11];
% for ii = 8 : 11 % we are ignoring source blocks upstream of the trip
% 
%     dataset_quadrant{count} = concat_along_axial_direction(LES_data_file_name,prims_name,...
%                            phase_name,grid_name,[ii,ii+4],prims_metrics_flag);
%     count = count +1 ; 
% 
% end

for ii = 0 : 3 % we are ignoring source blocks upstream of the trip

    dataset_quadrant{count} = concat_along_axial_direction(LES_data_file_name,prims_name,...
                           phase_name,grid_name,[ii,ii+8,ii+12],prims_metrics_flag);
    count = count +1 ; 

end


dataset_concatenated_to_single_cylindrical_grid = concat_along_theta(dataset_quadrant);
% size(dataset_concatenated_to_single_cylindrical_grid);

end