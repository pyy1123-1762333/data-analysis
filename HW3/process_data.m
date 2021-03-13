function result = process_data(vidFrame, filter, scale)
    numFrames = size(vidFrame, 4);
    result = zeros(numFrames, 2);
    for i = 1:numFrames
        X = vidFrame(:,:,:,i);
        X_gray = double(rgb2gray(X));
        X_prime = X_gray .* filter;
        threshold = X_prime > scale;
        
        [Y, X] = find(threshold);
        result(i, 1) = mean(X);
        result(i, 2) = mean(Y);
    end

end