% İlknur Baş
% exercise 11
clc, clear all, close all;

% Question 1-2
% echo1 has a healhty heart. in echo 2, there is not much movement on
% specific area.

% optical_flow_func('visiontraffic.avi');
optical_flow_func('echo1.avi');
optical_flow_func('echo2.avi');


function [] = optical_flow_func(video)  

    % Constructs a multimedia reader object
    vidReader = VideoReader(video);
    % Initialize the optical flow object
    % returns an optical flow object that you can use to estimate the direction 
    % and speed of the moving objects in a video.
    % make changes in eps
    % Optical flow or optic flow is the pattern of apparent motion of
    % objects...
    
    eps = 0.01; % smaller threshold (0.003) bigger noise/more movement
    opticFlow = opticalFlowLK('NoiseThreshold', eps);
    figure();
    while hasFrame(vidReader)
        % Read the rgb frame
        frameRGB  = readFrame(vidReader);
        % Convert rgb to grayscale
        frameGray = rgb2gray(frameRGB);
        size(frameGray);
        % filter applied
        % frameGray = imdiffusefilt(frameGray);   
        frameGray = wiener2(frameGray,[5 5]);
        % Compute optical flow
        flow = estimateFlow(opticFlow, frameGray);
        % Display rgb video frame with flow vectors
        imshow(frameRGB);
        hold on;
        plot(flow, 'DecimationFactor', [5 5], 'ScaleFactor', 10);
        drawnow;
        hold off;
    end
end