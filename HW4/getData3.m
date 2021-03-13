function [data1, data2, data3, n1, n2, n3, label] = getData3(label1, label2, label3, labels, data)
    ind1 = find(labels==label1);
    ind2 = find(labels==label2);
    ind3 = find(labels==label3);
    n1 = size(ind1, 1);
    n2 = size(ind2, 1);
    n3 = size(ind3, 1);
    data1 = zeros(784, n1);
    data2 = zeros(784, n2);
    data3 = zeros(784, n3);
    for i = 1:n1
        ind = ind1(i);
        data1(:,i) = data(:, ind);
    end

    for i = 1:n2
        ind = ind2(i);
        data2(:,i) = data(:, ind);
    end
    
    for i = 1:n3
        ind = ind3(i);
        data3(:,i) = data(:, ind);
    end
    label = zeros(n1+n2+n3,1);
    label(1:n1) = label1;
    label(n1+1:n1+n2) = label2;
    label(n1+n2+1:n1+n2+n3) = label3;

end