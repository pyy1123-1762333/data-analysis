function data = get_data(cam1, cam2, cam3)
    [M, I] = min(cam1(1:20, 2));
    cam1 = cam1(I:end, :);
    [M, I] = min(cam2(1:20, 2));
    cam2 = cam2(I:end, :);
    [M, I] = min(cam3(1:20, 2));
    cam3 = cam3(I:end, :);
    
    % make the 3 cam data consistent in length:
    len1 = length(cam1);
    len2 = length(cam2);
    len3 = length(cam3);
    
    l = [len1 len2 len3];
    m = min(l);
    
    if len1 == m
        cam2 = cam2(1:m, :);
        cam3 = cam3(1:m, :); 
    elseif len2 == m
        cam1 = cam1(1:m, :);
        cam3 = cam3(1:m, :); 
    else
        cam1 = cam1(1:m, :);
        cam2 = cam2(1:m, :); 
    end

    data = [cam1'; cam2'; cam3'];
end