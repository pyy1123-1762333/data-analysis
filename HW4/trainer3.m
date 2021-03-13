function [U, S, V, w, sort1, sort2, sort3] = trainer3(data1, data2, data3, feature)

    n1 = size(data1, 2);
    n2 = size(data2, 2);
    n3 = size(data3, 2);
    [U, S, V] = svd([data1 data2 data3], 'econ');
    % projection onto principal componenet: X = USV' -> U'X = SV'
    proj = S*V';  
    U = U(:, 1:feature);
    d1 = proj(1:feature, 1:n1);
    d2 = proj(1:feature, n1+1:n1+n2);
    d3 = proj(1:feature, n1+n2+1:n1+n2+n3);
    m1 = mean(d1, 2);
    m2 = mean(d2, 2);
    m3 = mean(d3, 2);
    mu = mean([m1 m2 m3], 2);
    
    % Calculate within-class matrix
    Sw = 0;
    for k = 1:n1
        Sw = Sw + (d1(:,k)-m1)*(d1(:,k) - m1)';
    end
    for k = 1:n2
        Sw = Sw + (d2(:,k)-m2)*(d2(:,k) - m2)';
    end
    for k = 1:n3
        Sw = Sw + (d3(:,k)-m3)*(d3(:,k) - m3)';
    end
    
    % Calculate between-class matrix
    Sb = (mu - m1)*(mu - m1)' + (mu - m2)*(mu - m2)' +(mu - m3)*(mu - m3)';

    [V2, D] = eig(Sb, Sw);
    [lambda, ind] = max(abs(diag(D)));
    w = V2(:, ind);
    w = w/norm(w,2);
    v1 = w' * d1;
    v2 = w' * d2;
    v3 = w' * d3;
    
    sort1 = sort(v1);
    sort2 = sort(v2);
    sort3 = sort(v3);

end
