%2020.5.19 PCA U4 Beispiel
clear all
%% Ԫ�������ɵ�ͼ
x = [2.5, 0.5, 2.2, 1.9, 3.1, 2.3, 2, 1, 1.5, 1.1];
y = [2.4, 0.7, 2.9, 2.2, 3.0, 2.7, 1.6, 1.1, 1.6, 0.9];
figure(1)
plot(x,y,'*')
title('Ԫ�������ɵ�ͼ')
%% 1.Schatze Mittelwert und normalisiere Daten auf Mittelwert 0
u_x = mean(x);
u_y = mean(y);
u = [u_x;u_y];
for i =1:length(x)
    x_normalisiere(i) = x(i) - u_x;
    y_normalisiere(i) = y(i) - u_y;
end
for i = 1:length(x)
    DataAdjust(1,i) = x_normalisiere(i);
    DataAdjust(2,i) = y_normalisiere(i);
end
%% 2.Schatze Kovarianzmatrix 
Kovarianzmatrix = 1/length(DataAdjust)*DataAdjust*DataAdjust';

%% 3.Berechne Eigenwertzerlegung von Kovarianzmatrix 
[V,D] = eig(Kovarianzmatrix);
D_max = D(2,2); V_max = [V(1,2);V(2,2)];
D_min = D(1,1); V_min = [V(1,1);V(2,1)];
%% ���ͼ��
Transformation_D_max =D_max* V_max'*DataAdjust;  %1x1 * 1x2 * 2x10 = 1x10,�˹�������ֻ��һ�����ף���ת����һ��ά��
figure(2)  %�Գ���Ϊ����ת��
plot(0,Transformation_D_max,'*')
title('�Գ���Ϊ���׵�ת��')

figure(3)  %�Զ���Ϊת��
Transformation_D_min =D_min* V_min'*DataAdjust;  %1x1 * 1x2 * 2x10 = 1x10���˹�������ֻ��һ�����ף���ת����һ��ά��
plot(Transformation_D_min,0,'*')
title('�Զ���Ϊ���׵�ת��')

figure(4)  %Ԫ�������»���Ϊ����ϵ�µ�ͼ
a = atan(0.6779/0.7352);
matrix = [cos(a) sin(a);-sin(a),cos(a)];
% lamta = [D_max 0;0 D_min];
Transformation_D_sum = matrix' * DataAdjust;
% for i =1:10
% %     x_t(i) = x_normalisiere(i)/cos(a)+(y_normalisiere(i)-x_normalisiere(i)/tan(a))*sin(a);
% %     y_t(i) = (y_normalisiere(i)-x_normalisiere(i)/tan(a))*cos(a);
% 
% end
for i =1:10
    plot(Transformation_D_sum(1,i),Transformation_D_sum(2,i),'*')
    xlim([-2,2])
    ylim([-2,2])
    title('Ԫ�������»���Ϊ����ϵ�µ�ͼ')
    hold on
end

achse_x =D_max* V_max*x_normalisiere;
achse_y =D_min* V_min*y_normalisiere;
figure(5)
for i =1:10
    %plot(x_normalisiere, y_normalisiere,'b*')
    plot(achse_x(1,i),achse_x(2,i),'r*')
    plot(achse_y(1,i),achse_y(2,i),'b*')
    title('PCA�ؽ����ͼ')
    hold on
end

% %% Rekonstruktionsfehler
% Hauptachse_1_fehler = Transformation_D_max * Transformation_D_max'
% Hauptachse_2_fehler = Transformation_D_min * Transformation_D_min'

