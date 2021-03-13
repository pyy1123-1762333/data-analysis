function threshold = getThreshold(sort1, sort2)
    t1 = length(sort1);
    t2 = 1;
    while sort1(t1) > sort2(t2)
        t1 = t1-1;
        t2 = t2+1;
    end
    threshold = (sort1(t1) + sort2(t2))/2;
end