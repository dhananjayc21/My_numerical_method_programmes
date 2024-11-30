% % CLASSICAL BISECTION METHOD
% 
% f = @(x) x^4 - 3 * x^2 + 2 * x - 8 ;
% left = 0;
% right = 5;
% flag = 1;
% flag2 = 1;
% ansval = -1000;
% iterations = 0;
% if f(left) * f(right) >= 0
%     flag = -1;
% end
% 
% if flag == 1
%     while flag2 == 1 
% 
%         mid = (left + right)/2;
%         if f(left) * f(mid) < 0
%             right = mid;
%         elseif f(right) * f(mid) < 0
%             left = mid;
%         else
%             flag2 = 0;
%         end 
%         iterations = iterations + 1;
%          if abs(ansval - mid) > 0.00001
%             ansval = mid;
%         else
%             flag2 = 0;
%         end 
%     end
% end


% % BISECTION METHOD USING FALSE POSITION
% 
% f = @(x) x^4 - 3 * x^2 + 2 * x - 8 ;
% left = 0;
% right = 5;
% flag = 1;
% flag2 = 1;
% ansval = -1000;
% iterations = 0;
% if f(left) * f(right) >= 0
%     flag = -1;
% end
% 
% if flag == 1
%     while flag2 == 1 
% 
%         false_pos = (f(left)*right - f(right)*left)/(f(left) - f(right));
%         if f(left) * f(false_pos) < 0
%             right = false_pos;
%         elseif f(right) * f(false_pos) < 0
%             left = false_pos;
%         else
%             flag2 = 0;
%         end 
%         iterations = iterations + 1;
% 
%         if abs(ansval - false_pos) > 0.00001
%             ansval = false_pos;
%         else
%             flag2 = 0;
%         end    
% 
%     end
% end
