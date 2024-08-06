function dataset_concatenated  = concat_along_theta(dataset_quadrant)

number_of_quadrants = length(dataset_quadrant);
[Nx,Nr,N_theta] = size(dataset_quadrant{1});
dataset_concatenated = zeros(Nx,Nr,number_of_quadrants*N_theta - (number_of_quadrants -1));
for ii = 1 : number_of_quadrants
%ii
    if ii == 1
        dataset_concatenated(:,:,1:N_theta) = dataset_quadrant{1};
    else
        dataset_concatenated(:,:,(ii-1)*N_theta:(ii*N_theta) -1) = dataset_quadrant{ii};
    end

end

end