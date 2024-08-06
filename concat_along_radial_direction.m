function dataset_concatenated = concat_along_radial_direction(LES_data_file_name,field_name,phase_name,grid_name,src_blks,prims_metrics_flag)

      N_r_concatenated = 0;

      for ii = 1: length(src_blks)
        
          if strcmp('primitives',prims_metrics_flag)
                dataset{ii} = read_prim_data_for_physical_domain(LES_data_file_name,phase_name,grid_name,field_name,src_blks(ii));
          elseif strcmp('metrics',prims_metrics_flag)
                dataset{ii} = read_grid_data_for_physical_domain(LES_data_file_name,phase_name,grid_name,field_name,src_blks(ii));
          end
          [Nx{ii},Nr{ii},N_theta{ii}] = size(dataset{ii});
          N_r_concatenated = N_r_concatenated + Nr{ii};
      end

      N_r_concatenated = N_r_concatenated - length(src_blks) + 1;

      dataset_concatenated = zeros(Nx{1},N_r_concatenated,N_theta{1});
%       size(dataset_concatenated)
      
      for ii = 1 : length(src_blks)

         if ii == 1
           dataset_concatenated(:,1:Nr{1},:) = dataset{1};
           start_idx = Nr{1};
         else 
           dataset_concatenated(:,start_idx:start_idx  + Nr{ii} -1,:) = dataset{ii}; 
           start_idx = start_idx + Nr{ii}-1;
         end
      end

      
end