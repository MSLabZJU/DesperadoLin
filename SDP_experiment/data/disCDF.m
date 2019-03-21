temp = load('erDis.mat');
erDis = temp.erDis;
erDis = sort(erDis);
erDisUnique = unique(erDis);
for i=1:1:length(erDisUnique);
    num(i) = findNum(erDis,erDisUnique(i));
    num(i) = num(i)/100;
end
% value = 0.2;
% for j=i+1:1:i+2
%     num(j) = findNum(erDis,value);
%     num(j) = num(j)/100;
%     value = value + 0.1;
% end
figure;
plot(erDisUnique,num);
