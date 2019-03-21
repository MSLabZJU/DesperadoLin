temp = load('erLoc.mat');
erLoc = temp.erLoc;
erLoc = sort(erLoc);
erLocUnique = unique(erLoc);
for i=1:1:length(erLocUnique);
    num(i) = findNum(erLoc,erLocUnique(i));
    num(i) = num(i)/100;
end
% value = 0.3;
% num(i+1) = findNum(erLoc,value);
% num(i+1) = num(i+1)/100;

figure;
plot(erLocUnique,num);