function results = run_LSDCF(seq,res_path, bSaveImage, parameters)

% Feature specific parameters
hog_params.cell_size = 6;
hog_params.nDim = 31;
hog_params.learning_rate = 0.6;
hog_params.feature_is_deep = false;

cn_params.tablename = 'CNnorm';
cn_params.useForGray = false;
cn_params.cell_size = 4;
cn_params.nDim = 10;
cn_params.learning_rate = 0.6;
cn_params.feature_is_deep = false;

grayscale_params.colorspace='gray';
grayscale_params.cell_size = 4;
grayscale_params.useForColor = false;
grayscale_params.learning_rate = 0.6;
grayscale_params.feature_is_deep = false;
params.t_global.cell_size = 4;           

ic_params.tablename = 'intensityChannelNorm6';
ic_params.useForColor = false;
ic_params.cell_size = 4;
ic_params.nDim = 5;
ic_params.learning_rate = 0.6;
ic_params.feature_is_deep = false;

cnn_params.nn_name = 'imagenet-resnet-50-dag.mat'; 
cnn_params.output_var = {'res4dx'};    
cnn_params.downsample_factor = [1];           
cnn_params.input_size_mode = 'adaptive';       
cnn_params.input_size_scale = 1;       
cnn_params.learning_rate = 0.2;
cnn_params.feature_is_deep = true;
cnn_params.augment.blur = 1;
cnn_params.augment.rotation = 1;
cnn_params.augment.flip = 1;
%cnn_params.useForGray = false;
    
%struct('getFeature',@get_cnn_layers, 'fparams',cnn_params),...
% Which features to include
params.t_features = {
    struct('getFeature',@get_fhog,'fparams',hog_params),...
    struct('getFeature',@get_table_feature, 'fparams',ic_params),...
    struct('getFeature',@get_table_feature, 'fparams',cn_params),...
    struct('getFeature',@get_cnn_layers, 'fparams',cnn_params),...
};

% Image sample parameters
params.search_area_shape = 'square';    % The shape of the samples
params.search_area_scale = 4.1;         % The scaling of the target size to get the search area
params.min_image_sample_size = 200^2;   % Minimum area of image samples
params.max_image_sample_size = 250^2;   % Maximum area of image samples

% Define initial masks
params.mask_window_min = 1e-3;           % the minimum value of the mask window

% Detection parameters
params.refinement_iterations = 1;       % Number of iterations used to refine the resulting position in a frame
params.newton_iterations = 5;           % The number of Newton iterations used for optimizing the detection score
params.clamp_position = false;          % Clamp the target position to be inside the image

% Learning parameters
params.output_sigma_factor = [1/16 1/3];		% Label function sigma
params.temporal_consistency_factor = [38 5];
params.stability_factor = 0;
params.sparse_factor = [1.2e-5 2.1e-6];
params.buffer_frames = 8;

% ADMM parameters
params.max_iterations = 2;
params.init_penalty_factor = 1;
params.penalty_scale_step = 10;

% Scale parameters for the translation model
params.number_of_scales = 7;            % Number of scales to run the detector
params.scale_step = 1.01;               % The scale factor

% GPU
params.use_gpu = true;                 % Enable GPU or not
params.gpu_id = [];                     % Set the GPU id, or leave empty to use default

% Initialize
params.visualization = 0;
params.seq = seq;

% Run tracker
[results] = tracker(params);
