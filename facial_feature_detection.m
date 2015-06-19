% Script used to demonstrate the use of different facial feature detectors
% for face frontalizations. 
% PLEASE MODIFY THIS SCRIPT AS REQUIRED BY THE FACIAL FEATURE DETECTOR
% INSTALLED ON YOUR SYSTEM. This is part of the distribution for
% face image frontalization ("frontalization" software), described in [1].
%
% If you find this code useful and use it in your own work, please add
% reference to [1]. Please also respect any distribution notices of the
% facial feature detectors used [2,3,4]
%
% Please see project page for more details:
%   http://www.openu.ac.il/home/hassner/projects/frontalize
%
% Please see demo.m for example usage.
%
%  References:
%   [1] Tal Hassner, Shai Harel, Eran Paz, Roee Enbar, "Effective Face
%   Frontalization in Unconstrained Images," forthcoming. 
%   See project page for more details: 
%   http://www.openu.ac.il/home/hassner/projects/frontalize
%
%   [2] X. Xiong and F. De la Torre, "Supervised Descent Method and its Application to Face
%   Alignment," IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2013
%   Available: http://www.humansensing.cs.cmu.edu/intraface
%
%   [3] X. Zhu, D. Ramanan. "Face detection, pose estimation and landmark localization in the wild," 
%   Computer Vision and Pattern Recognition (CVPR) Providence, Rhode Island, June 2012. 
%   Available: http://www.ics.uci.edu/~xzhu/face/
%
%   [4] V. Kazemi, J. Sullivan. "One Millisecond Face Alignment with an
%   Ensemble of Regression Trees," Computer Vision and Pattern Recognition
%   (CVPR), Columbus, Ohio, June, 2014
%   Available through the dlib library: http://blog.dlib.net/2014/08/real-time-face-pose-estimation.html
%
%
%   The SOFTWARE ("frontalization" and all included files) is provided "as is", without any
%   guarantee made as to its suitability or fitness for any particular use.
%   It may contain bugs, so use of this tool is at your own risk.
%   We take no responsibility for any damage that may unintentionally be caused
%   through its use.
%
%   ver 1.2, 18-May-2015
%

switch detector
    case 'SDM'
        % SDM detector (Intraface) [2] 
        load model3DSDM Model3D % reference 3D points corresponding to SDM detections

        % detect facial features on query
        addpath(genpath('SDM/FacialFeatureDetection&Tracking_v1.4'))
        tmpdir = pwd;
        cd SDM/FacialFeatureDetection&Tracking_v1.4
        [Models,option] = xx_initialize;
        cd(tmpdir);
        faces = Models.DM{1}.fd_h.detect(I_Q,'MinNeighbors',option.min_neighbors,...
          'ScaleFactor',1.2,'MinSize',[50 50]);
        if ~isempty(faces)
            output = xx_track_detect(Models,I_Q,faces{1},option);
            fidu_XY = double(output.pred);
        end
        


    case 'ZhuRamanan'
        % Zhu and Ramanan detector [3]
        load model3DZhuRamanan Model3D % reference 3D points corresponding to Zhu & Ramanan detections
        
        % detect facial features on query
        addpath(genpath('ZhuRamanan'))
        load('ZhuRamanan/face_p146_small.mat','model');
        model.interval = 5;
        model.thresh = min(-0.65, model.thresh);
        if length(model.components)==13 
            posemap = 90:-15:-90;
        elseif length(model.components)==18
            posemap = [90:-15:15 0 0 0 0 0 0 -15:-15:-90];
        else
            error('Can not recognize this model');
        end
        
        
        I_Q_bs = detect(I_Q, model, model.thresh);
        if isempty(I_Q_bs)
            return
        end

        I_Q_bs = clipboxes(I_Q, I_Q_bs);
        I_Q_bs = nms_face(I_Q_bs,0.3);

        if (isempty(I_Q_bs))
            return;
        end
        x1 = I_Q_bs(1).xy(:,1);
        y1 = I_Q_bs(1).xy(:,2);
        x2 = I_Q_bs(1).xy(:,3);
        y2 = I_Q_bs(1).xy(:,4);
        fidu_XY = [(x1+x2)/2,(y1+y2)/2];
        
    case 'dlib'
        % Kazemi and Sullivan detector implemented by the dlib library [4] 
        load model3Ddlib Model3D % reference 3D points corresponding to dlib detections
        
        % this detector runs in Python; here we only load them for the
        % current face image. See dlib_detect_script.py for an example
        % usage
        fidu_XY = load('path_to_dlib_xy.mat'); % load detections performed by Python script on current image
        fidu_XY = reshape(fidu_XY,68,2);
        fidu_XY = double(fidu_XY);
        
        
        
    otherwise
        error(1,'To use a new, unsupported facial feature detector please see MakeNew3DModel.m\n');
        
end
    
    
    