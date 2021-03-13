function [data1, data2, n1, n2, label] = getData(label1, label2, labels, data)
    ind1 = find(labels==label1);
    ind2 = find(labels==label2);
    n1 = size(ind1, 1);
    n2 = size(ind2, 1);
    data1 = zeros(784, n1);
    data2 = zeros(784, n2);
    for i = 1:n1
        ind = ind1(i);
        data1(:,i) = data(:, ind);
    end

    for i = 1:n2
        ind = ind2(i);
        data2(:,i) = data(:, ind);
    end
    label = zeros(n1+n2,1);
    label(1:n1) = label1;
    label(n1+1:n1+n2) = label2;

end