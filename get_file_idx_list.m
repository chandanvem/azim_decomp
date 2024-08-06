
function file_idx_list = get_file_idx_list(LES_dir,LES_output_filename_prefix)

file_struct = dir(LES_dir);
% file_list_start = 3;
count = 1;
for ii = 1: length(file_struct)
%     if ii >= file_list_start
        FileNames{ii} = file_struct(ii).name;
        number_string{ii} = regexp(FileNames{ii},'\d*','Match');
        if contains(FileNames{ii},LES_output_filename_prefix) 
           file_idx_list(count) = str2double(number_string{ii}(1));
           count = count + 1;
        end
%     end
end

end