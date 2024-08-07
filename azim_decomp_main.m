clear; clc ; close all;

%%
addpath(genpath('/work/home/chandan/Chandan_case_files/FWH_tesselation_interp/slicer_interp_utils'));
addpath(genpath('/work/home/chandan/Chandan_case_files/brescase_FWH_time_series/matlab_files'));
addpath(genpath('/work/home/chandan/Chandan_case_files/SPOD_work_space/scripts/output_function_definitions'));
addpath(genpath('/work/home/chandan/Chandan_case_files/SPOD_work_space/scripts/utils'));
addpath(genpath('/work/home/chandan/Chandan_case_files/brescase/post_processing_scripts/Bres_case_scripts/utils'));
%
wkdir_list = {'/work/home/chandan/chandan_backup_asenag/BRES_SPOD_TIME_SERIES',...
               '/work/home/chandan/chandan_backup_asenmp/BRES_SPOD_TIME_SERIES',...
               '/work/home/chandan/chandan_backup_asenag/brescase/BRES_TIME_SERIES_1122_1203',...
                '/work/home/chandan/chandan_backup_asenmp/brescase_large'};

file_name_prefix_list = {'Bres_geom_prims','Bres_geom_prims','Bres_geomtrip',...
                    'Bres_geom_prims'};
  
%%
centerline_grid_time_series_dir = '/work/home/chandan/Chandan_case_files/SPOD_work_space/inner_cylinder_grid_file/inner_cylinder_time_series';
centerline_grid_name = 'inner_cylinder';
centerline_grid_file_name_prefix = 'Bres_geom_inner_cylinder';

%%
start_idx = 81;
for ii = 1 : length(wkdir_list)
    file_idx_list_unsorted{ii} = get_file_idx_list(wkdir_list{ii},file_name_prefix_list{ii});
    file_idx_list{ii} = sort(file_idx_list_unsorted{ii});
    dir_of_sol_file_idx(file_idx_list{ii}-start_idx+1) = ii;
end

%%
output_dir = '/work/home/chandan/Chandan_case_files/SPOD_work_space/SPOD_DATA/brescase/azi_decomp_time_series';
output_file_name = 'Bres_geomtrip_azi_decomp';
concat_op_file_name = 'Bres_geomtrip_concat';
write_concat_file_flag = 'write_concat_file';
%%
phase_name = 'Bres_geomtrip';
grid_name= 'chamber';
count = 1;
sol_file_start_idx = 81;
number_of_files = 300; %112;
sol_file_end_idx = 81; %sol_file_start_idx + number_of_files -1;

%%
T_inf = 298;
p_inf = 101325;
R = 287;
gamma = 1.4;
c_inf = sqrt(gamma*R*T_inf);
rho_inf = p_inf/(R*T_inf);

%%
field_names = {'F11','F12','F13',...
               'F22','F23','F33',...
               'Q1','Q2','Q3',...
               'density','u_velocity','v_velocity','w_velocity',...
               'Temperature','pressure'};
%  field_names = {'pressure'};
%'Q1','Q2','Q3',...%               'T11','T22','T33',...
%%
azi_mode_start = 0;
azi_mode_end   = 3;
new_src_blk_start_idx = 0;
new_src_blk_end_idx = 7;
%%

for sol_file_idx = sol_file_start_idx : sol_file_end_idx 
  
    fprintf('=========File %d (%d of %d)==========\n',sol_file_idx,count,number_of_files);

    tic;
    h5OutName = sprintf('%s/%s_%d.h5',output_dir,output_file_name,sol_file_idx);
    concat_op_file_name = sprintf('%s/%s.h5',output_dir,concat_op_file_name);
    if exist(h5OutName,'file')==2
        delete(h5OutName);
    end
   
    LES_data_dir = wkdir_list{dir_of_sol_file_idx(sol_file_idx-start_idx+1)};
    LES_output_filename_prefix = file_name_prefix_list{dir_of_sol_file_idx(sol_file_idx-start_idx+1)};
    LES_data_file_name = sprintf('%s/%s_%d.h5',LES_data_dir,LES_output_filename_prefix,sol_file_idx);
    centerline_data_file_name = sprintf('%s/%s_%d.h5',centerline_grid_time_series_dir,centerline_grid_file_name_prefix,sol_file_idx);

    if exist(LES_data_file_name,'file')==2
    
       do_azimuthal_decomposition_given_field_names_func(centerline_data_file_name,centerline_grid_name,LES_data_file_name,new_src_blk_start_idx,new_src_blk_end_idx,phase_name,grid_name,field_names,...
               p_inf,rho_inf,c_inf,azi_mode_start,azi_mode_end,h5OutName,...
                             write_concat_file_flag,concat_op_file_name);

    else 
        fprintf('File %s not found, moving on \n',LES_data_file_name);
    end
    toc;
    count = count + 1;
end


