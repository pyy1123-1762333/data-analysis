clear all; close all; clc

%% load the training data
% [images, labels] = mnist_parse('train-images-idx3-ubyte', 'train-labels-idx1-ubyte');
[train_data, train_label] = mnist_parse('train-images-idx3-ubyte', 'train-labels-idx1-ubyte');
[test_data, test_label] = mnist_parse('t10k-images-idx3-ubyte', 't10k-labels-idx1-ubyte');

% SVD analysis
% reshape the train data: each column is an image
train_data = double(reshape(train_data, size(train_data,1)*size(train_data,2), []));
train_label = double(train_label);
test_data = double(reshape(test_data, size(test_data,1)*size(test_data,2), []));
test_label = double(test_label);

% use PCA
[M, N] = size(train_data);
train_data = train_data - repmat(mean(train_data, 2), 1, N);
[U, S, V] = svd(train_data/sqrt(N-1), 'econ');
% [U, S, V] = svd(train_data, 'econ');
sig = diag(S);
proj_data = U' * train_data;

% calculate the rank of the digit space
energy = 0;
total = sum(diag(S).^2);
thre = 0.9;
r = 0;
while energy < thre
    r = r+1;
    energy = energy + (S(r,r).^2)/total;
end

%% plot the singular value and energy
figure(1)
subplot(2, 1, 1)
plot(sig, 'bo', 'Linewidth', 0.5)
ylabel('\sigma')

subplot(2, 1, 2)
plot(sig.^2 / sum(sig.^2), 'bo', 'Linewidth', 0.5)
ylabel('Energy')

%% Projection onto 3 V-modes
% 2, 3, 5 for now
for label=0:9
    label_indices = find(train_label == label);
    plot3(V(label_indices, 2), V(label_indices, 3), V(label_indices, 5),...
        'o', 'DisplayName', sprintf('%i',label), 'Linewidth', 2)
    hold on
end
xlabel('2nd V-Mode'), ylabel('3rd V-Mode'), zlabel('5th V-Mode')
title('Projection onto V-modes 2, 3, 5')
legend
set(gca,'Fontsize', 10)

% -------------------------------------------------------------------------
%% Implement LDA for 2 digits -- 2 selected digits
% get the data with label 4 and 5:
l1 = 4;
l2 = 5;
proj_data = U' * train_data;
[data1, data2, n1, n2, label] = getData(l1, l2, train_label, proj_data);

feature = 87;

[U,S,V,threshold,w,sort1,sort2] = trainer(data1, data2, feature);

% calculate the accuracy for train data
result1 = sort1 > threshold;
result2 = sort2 < threshold;
err1 = size(find(result1==1));
err2 = size(find(result2==1));
acc1 = 1 - err1/size(sort1);
acc2 = 1 - err2/size(sort2);

% plot the result for train data:
figure(2)
subplot(1,2,1)
histogram(sort1,30); hold on, plot([threshold threshold], [0 800],'r')
%set(gca,'Xlim',[-3 4],'Ylim',[0 10],'Fontsize',14)
title(l1)
subplot(1,2,2)
histogram(sort2,30); hold on, plot([threshold threshold], [0 800],'r')
%set(gca,'Xlim',[-3 4],'Ylim',[0 10],'Fontsize',14)
title(l2)

% check the accuracy for test data-----------------------------------------
% get the test data with label 4 and 5:
[data1, data2, n1, n2, label] = getData(l1, l2, test_label, test_data);
test = [data1 data2];

% change first label to 0, second to 1 to do comparison
label = zeros(n1+n2,1);
label(1:n1) = 0;
label(n1+1:n1+n2) = 1;
TestNum = size(test, 2);
TestMat = U' * test;
pval = w' * TestMat;
ResVec = (pval > threshold);
% 0's are correct, 1s are incorrect
err = abs(ResVec - label');
errNum = sum(err);
accuracy = 1 - errNum/TestNum;
% -------------------------------------------------------------------------
%% Implement LDA for 2 digits: try different combinations:
% get the data with label 4 and 5:
accu_LDA = zeros(10, 10);
for i = 0:9
    for j = i+1:9
        l1 = i;
        l2 = j;
        
        [data1, data2, n1, n2, label] = getData(l1, l2, train_label, proj_data);

        feature = 87;

        [U,S,V,threshold,w,sort1,sort2] = trainer(data1, data2, feature);

        % calculate the accuracy for train data
        result1 = sort1 > threshold;
        result2 = sort2 < threshold;
        err1 = size(find(result1==1));
        err2 = size(find(result2==1));
        acc1 = 1 - err1/size(sort1);
        acc2 = 1 - err2/size(sort2);

        % check the accuracy for test data-----------------------------------------
        % get the test data
        [data1, data2, n1, n2, label] = getData(l1, l2, test_label, test_data);
        test = [data1 data2];

        % change first label to 0, second to 1 to do comparison
        label = zeros(n1+n2,1);
        label(1:n1) = 0;
        label(n1+1:n1+n2) = 1;
        TestNum = size(test, 2);
        TestMat = U' * test;
        pval = w' * TestMat;
        ResVec = (pval > threshold);
        % 0's are correct, 1s are incorrect
        err = abs(ResVec - label');
        errNum = sum(err);
        accuracy = 1 - errNum/TestNum;
        accu_LDA(i+1,j+1) = accuracy;
    end
end

%% Implement LDA for 3 digits: 
l1 = 0;
l2 = 4;
l3 = 9;
[data1, data2, data3, n1, n2, n3, label] = getData3(l1, l2, l3, train_label, proj_data);
feature = 87;

[U, S, V, w, sort1, sort2, sort3] = trainer3(data1, data2, data3, feature);

threshold1 = getThreshold(sort2, sort3);
threshold2 = getThreshold(sort3, sort1);


% plot the result for train data:
figure(2)
subplot(2,2,1)
histogram(sort1,30); hold on, plot([threshold2 threshold2], [0 800],'r')
title(l1)
subplot(2,2,2)
histogram(sort3,30); hold on, plot([threshold2 threshold2], [0 800],'r')
title(l3)
subplot(2,2,3)
histogram(sort3,30); hold on, plot([threshold1 threshold1], [0 800],'r')
title(l3)
subplot(2,2,4)
histogram(sort2,30); hold on, plot([threshold1 threshold1], [0 800],'r')
title(l2)

% check the accuracy for test data-----------------------------------------
% get the test data with label 4 and 5:
[data1, data2, data3, n1, n2, n3, label] = getData3(l1, l2, l3, test_label, test_data);
test = [data1 data2 data3];

% change first label to 0, second to 1 to do comparison
TestNum = size(test, 2);
TestMat = U' * test;
pval = w' * TestMat;
ResVec = zeros(TestNum, 1);
for i = 1:TestNum
    if pval(i) > threshold2
        ResVec(i) = l1;  % label1
    elseif pval(i) < threshold1
        ResVec(i) = l2;  % label2
    else
        ResVec(i) = l3;
    end
end
err_num = 0;
for i = 1:TestNum
    if (ResVec(i) ~= label(i))
        err_num = err_num + 1;
    end
end
sucRate = 1 - err_num/TestNum;

%% decision tree: different combination of digits
% choose data with labels 4 & 5:
accu_DecTree = zeros(10,10);
for i = 0:9
    for j = i+1:9
        l1 = i;
        l2 = j;
        [data1, data2, n1, n2, label] = getData(l1, l2, train_label, proj_data);
        data = [data1 data2];
        tree = fitctree(data', label, 'CrossVal', 'On');
        % view(tree.Trained{1}, 'Mode', 'graph');
        classError = kfoldLoss(tree);

        [data1, data2, n1, n2, label] = getData(l1, l2, test_label, test_data);
        test = [data1 data2];
        test_labels = predict(tree.Trained{1}, test');
        accu = sum(test_labels == label)/length(label);
        accu_DecTree(i+1, j+1) = accu;
    end
end

%% SVM classifier: different combination of digits
% multiplying SV by the inverse of the largest/first singular value.
% choose data with labels 4 & 5:
accu_SVM = zeros(10,10);
for i = 0:9
    for j = i+1:9
        l1 = i;
        l2 = j;
        [data1, data2, n1, n2, label] = getData(l1, l2, train_label, proj_data);
        data = [data1 data2];
        data = data ./ max(data(:));
        Mdl = fitcsvm(data', label);
        [data1, data2, n1, n2, label] = getData(l1, l2, test_label, test_data);
        test = [data1 data2];
        test_labels = predict(Mdl, test');

        % 0 false; 1 true
        check = label==test_labels;
        err = size(find(check==0), 1);
        accu = 1 - err/size(test_labels, 1);
        accu_SVM(i+1,j+1) = accu;
    end
end