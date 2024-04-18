% 读取数据文件
data = readtable('Inertial.csv');

% 确定正确的列名并提取数据
t = data.Timestamp_us_;
v1 = data.GyroscopeX_deg_s_;
v2 = data.GyroscopeY_deg_s_;
v3 = data.GyroscopeZ_deg_s_;
v4 = data.AccelerometerX_g_;
v5 = data.AccelerometerY_g_;
v6 = data.AccelerometerZ_g_;

% 创建动态图
figure;
hLines = plot(t, zeros(size(t)), 'b-', t, zeros(size(t)), 'r-', t, zeros(size(t)), 'g-', ...
              t, zeros(size(t)), 'm-', t, zeros(size(t)), 'c-', t, zeros(size(t)), 'y-');
xlabel('Timestamp (us)');
ylabel('Gyroscope X (deg/s)');
title('Velocity vs Time');
grid on;
legend('Line 1', 'Line 2', 'Line 3', 'Line 4', 'Line 5', 'Line 6');

% 设置绘图间隔
plotInterval = 10;

% 在循环之外初始化绘图
drawnow limitrate;

% 循环绘图
for i = 1:plotInterval:length(t)
    set(hLines(1), 'YData', v1(1:i), 'XData', t(1:i));  % 更新第一组数据
    set(hLines(2), 'YData', v2(1:i), 'XData', t(1:i));  % 更新第二组数据
    set(hLines(3), 'YData', v3(1:i), 'XData', t(1:i));  % 更新第三组数据
    set(hLines(4), 'YData', v4(1:i), 'XData', t(1:i));  % 更新第四组数据
    set(hLines(5), 'YData', v5(1:i), 'XData', t(1:i));  % 更新第五组数据
    set(hLines(6), 'YData', v6(1:i), 'XData', t(1:i));  % 更新第六组数据
    drawnow limitrate;
end