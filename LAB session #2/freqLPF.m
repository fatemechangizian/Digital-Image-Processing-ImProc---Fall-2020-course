function mask = freqLPF(dim,fcoupure)

m = min(dim);
mask = zeros(dim(1),dim(2));
xmin = -dim(2)/2;
ymax = dim(1)/2;
[X,Y] = meshgrid(xmin:xmin+dim(2)-1, ymax:-1:ymax-dim(1)+1);
R = sqrt((X/m).^2+(Y/m).^2);
% find frequency less than the cut frequency
index = R<fcoupure;
mask(index) = 1;