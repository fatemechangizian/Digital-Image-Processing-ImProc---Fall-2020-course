function mask = freqHPF(dim,fcoupure)

m = min(dim);

mask = zeros(dim(1),dim(2));
xmin = -dim(2)/2;
ymax = dim(1)/2;
[X,Y] = meshgrid(xmin:xmin+dim(2)-1, ymax:-1:ymax-dim(1)+1);
R = sqrt((X/m).^2+(Y/m).^2);
% find frequency more than the cut frequency
index = find(R>fcoupure);
mask(index) = 1;
