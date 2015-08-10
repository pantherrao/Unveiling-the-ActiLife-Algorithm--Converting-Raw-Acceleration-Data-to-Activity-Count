
grid on;
set(0, 'ShowHiddenHandles', 'on');

aTempVar = findobj(gcf, 'Type', 'text');
set(aTempVar, 'Fontweight', 'bold');
set(aTempVar, 'FontSize', 12);

aTempVar = findobj(gcf, 'Type', 'axes');
set(aTempVar, 'Fontweight', 'bold');
set(aTempVar, 'FontSize', 12);

set(0, 'ShowHiddenHandles', 'off'); 
%%%%%%%%%%%%%%%%%%%%%%%%
% grid on;
% set(0, 'ShowHiddenHandles', 'on');
% 
% aTempVar = findobj(gcf, 'Type', 'text');
% set(aTempVar, 'Fontweight', 'bold');
% set(aTempVar, 'Fontsize', 12);


% aTempVar = findobj(gcf, 'Type', 'axes');
% set(aTempVar, 'Fontweight', 'bold');
% 
% set(0, 'ShowHiddenHandles', 'off');

aTempVar = findobj(gcf, 'Type', 'Line');
set(aTempVar, 'LineWidth', 2);
%aTempVar = findobj(gcf, 'Type', 'Marker');
set(aTempVar, 'MarkerSize', 8);
%set(aTempVar, 'Marker', 'x');
figurenumber = gcf;
set(figurenumber,'Color',[1 1 1]);
set(gcf, 'InvertHardCopy', 'on');
clear aTempVar



