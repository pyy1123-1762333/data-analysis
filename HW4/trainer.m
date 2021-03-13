function [U, S, V, threshold, w, sort1, sort2] = trainer(data1, data2, feature)

    n1 = size(data1, 2);
    n2 = size(data2, 2);
    [U, S, V] = svd([data1 data2], 'econ');
    % projection onto principal componenet: X = USV' -> U'X = SV'
    proj = S*V';  
    U = U(:, 1:feature);
    d1 = proj(1:feature, 1:n1);
    d2 = proj(1:feature, n1+1:n1+n2);
    m1 = mean(d1, 2);
    m2 = mean(d2, 2);
    
    Sw = 0;
    
    for k = 1:n1
        Sw = Sw + (d1(:,k)-m1)*(d1(:,k) - m1)';
    end
    for k = 1:n2
        Sw = Sw + (d2(:,k)-m2)*(d2(:,k) - m2)';
    end
    Sb = (m1 - m2)*(m1 - m2)';
    
    [V2, D] = eig(Sb, Sw);
    [lambda, ind] = max(abs(diag(D)));
    w = V2(:, ind);
    w = w/norm(w,2);
    v1 = w' * d1;
    v2 = w' * d2;
    
    if mean(v1) > mean(v2)
        w = -w;
        v1 = -v1;
        v2 = -v2;
    end
    
    sort1 = sort(v1);
    sort2 = sort(v2);
    t1 = length(sort1);
    t2 = 1;
    while sort1(t1) > sort2(t2)
        t1 = t1-1;
        t2 = t2+1;
    end
    
    threshold = (sort1(t1) + sort2(t2))/2;
end
