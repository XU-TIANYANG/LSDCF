error('delete this line after installation!');
close all;
setup_paths();
%  Load video information
base_path  = './sequenses';
video = choose_video(base_path);

video_path = [base_path '/' video];
[seq, gt_boxes] = load_video(video_path,video);
seq.videoName = video;
results = run_LSDCF(seq);

pd_boxes = results.res;
thresholdSetOverlap = 0: 0.05 : 1;
success_num_overlap = zeros(1, numel(thresholdSetOverlap));
if numel(gt_boxes(1,:))>4
    temp = zeros(size(gt_boxes,1),4);  
    for i = 1:size(gt_boxes,1)
        bb8 = round(gt_boxes(i,:));
        x1 = round(min(bb8(1:2:end)));
        x2 = round(max(bb8(1:2:end)));
        y1 = round(min(bb8(2:2:end)));
        y2 = round(max(bb8(2:2:end)));
        temp(i,:) = round([x1, y1, x2 - x1, y2 - y1]);
    end
    gt_boxes = temp;
end

thresholdSetPre = 0: 1 : 50;
success_num_pre = zeros(1, numel(thresholdSetPre));
res = calcRectInt(gt_boxes, pd_boxes);
p_gt = [gt_boxes(:,2),gt_boxes(:,1)]+([gt_boxes(:,4),gt_boxes(:,3)]-1)/2;
p_res = [pd_boxes(:,2),pd_boxes(:,1)]+([pd_boxes(:,4),pd_boxes(:,3)]-1)/2;
dis = sqrt(sum((p_gt-p_res).^2,2));
for t = 1: length(thresholdSetOverlap)
    success_num_overlap(1, t) = sum(res > thresholdSetOverlap(t));
end
for t = 1: length(thresholdSetPre)
    success_num_pre(1, t) = sum(dis <= thresholdSetPre(t));
end
Pre = success_num_pre(21) / size(gt_boxes, 1);
cur_AUC = mean(success_num_overlap) / size(gt_boxes, 1);
FPS_vid = results.fps;
display([video  '---->' ' FPS: ' num2str(FPS_vid)   '  op: '   num2str(cur_AUC)  '  pr: '   num2str(Pre)]);