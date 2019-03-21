function arrival_time = realPeakkey(value,key)

% temp_matrix = zeros(1,1);
% flag = 1;
% 
% temp_key = key;
% flag_find = 1;
% find_matrix=zeros(1,1);
    for i = key-10000:key
        if(value(i) >= value(key)*0.30)
            temp_time = i;
            break;
        else
            temp_time = key;
        end    
    end
    arrival_time = temp_time;
   
%     while(1)
%         for i=temp_key-500:temp_key
%             find_matrix(flag_find) = abs(value(i));
%             flag_find = flag_find+1;
%         end       
%         temp_max = max(find_matrix);
%         if(temp_max<0.3)
%             temp_time = temp_key-500;
%             break;
%         end
%         temp_key = temp_key-500;
%         flag_find = 1;
%     end
%     
%    for i = temp_time:temp_time+4000
%         if(value(i) >= value(key)*0.30)
%             middle_time = i;
%             break;
%          else
%             middle_time = key;
%         end    
%    end
% 
% 
%     for i =middle_time:middle_time+100
%         temp_matrix(flag) = value(i);
%         flag = flag+1;
%     end
%     [num,loc] = max(temp_matrix);
%     final_time = middle_time+loc-1;
% 
%     
%     if((value(final_time)>=10))
%             for i = final_time-1000:final_time
%                 if value(i) >= 0.26*value(final_time)
%                     arrival_time = i;
%                     break;
%                 end
%             end
%     else
%             for i = final_time-1000:final_time
%                 if value(i) >= 0.75*value(final_time)
%                     arrival_time = i;
%                     break;
%                 end
%             end
%     end
    
end