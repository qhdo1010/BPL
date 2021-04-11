% Demo of fitting a motor program to an image.

% Parameters
K = 5; % number of unique parses we want to collect
verbose = true; % describe progress and visualize parse?
include_mcmc = false; % run mcmc to estimate local variability?
fast_mode = true; % skip the slow step of fitting strokes to details of the ink?

if fast_mode
    fprintf(1,'Fast mode skips the slow step of fitting strokes to details of the ink.\n');
   % warning_mode('Fast mode is for demo purposes only and was not used in paper results.');
end


%load('Phi_img','img');
img = arc(107).train(1).input;
img = imresize(img,[105 105]);
img = imbinarize(img);
img = imcomplement(img);
G = fit_motorprograms(img,K,verbose,include_mcmc,fast_mode);


img = arc(107).train(1).output;
img = imresize(img,[105 105]);
img = imbinarize(img);
img = imcomplement(img);

G_out = fit_motorprograms(img,K,verbose,include_mcmc,fast_mode);
