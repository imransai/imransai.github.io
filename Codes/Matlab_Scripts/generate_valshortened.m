%Function for saving Motion-Corrected Velodyne Points Projected into Image
%Plane.

kitti_depthset = '../../Data/KITTI_Depth/';

dataset_type = 'val_shortened';

dataparam.skip_layer_rows = 5;
dataparam.skip_layer_cols = 1;

filelist = dir(fullfile(kitti_depthset, 'val_selection_cropped', 'image'));
filelist = filelist(3:end);
filelist = {filelist.name};

for ii = 1:length(filelist)    
   
    drive_split = strsplit(filelist{ii},'_');
    cam_id = strsplit(drive_split{10},'.');
    cam_id = cam_id{1};
    drive_seq = strjoin(drive_split(1:6),'_');
    cam_catgry = ['image_' cam_id];
    filename = [drive_split{8} '.png'];
    save_dir_subsample = fullfile(kitti_depthset, 'val_shortened', 'proj_depth', ...
                 sprintf('%dx%d_nSKips',dataparam.skip_layer_rows-1, dataparam.skip_layer_cols - 1));
    save_dir_gt = fullfile(kitti_depthset, 'val_shortened', 'proj_depth', 'groundtruth');
    save_dir_color = fullfile(kitti_depthset, 'val_shortened', 'image');
    
    if ~exist(save_dir_subsample)
      mkdir(save_dir_subsample);  
        
    end
    
    if ~exist(save_dir_gt)
       mkdir(save_dir_gt); 
        
    end
    
    if ~exist(save_dir_color)
        mkdir(save_dir_color);
        
    end
    
    target_filename = filelist{ii};
    source_file_subsample = fullfile(kitti_depthset, 'val', drive_seq, 'proj_depth', ...
                 sprintf('%dx%d_nSKips',dataparam.skip_layer_rows-1, dataparam.skip_layer_cols - 1),...
                 cam_catgry, filename);
    target_file_subsample = fullfile(save_dir_subsample,...
                 target_filename);
    source_file_gt = fullfile(kitti_depthset, 'val', drive_seq, 'proj_depth','groundtruth', ...
                            cam_catgry, filename);
    target_file_gt = fullfile(save_dir_gt,...
                 target_filename);
    
    source_file_color = fullfile(kitti_depthset, 'val', drive_seq, 'color', ...
                            cam_catgry, filename);
    target_file_color = fullfile(save_dir_color,...
                 target_filename);
    
    copyfile(source_file_subsample,target_file_subsample);
    copyfile(source_file_gt,target_file_gt);
    copyfile(source_file_color,target_file_color);
    
end