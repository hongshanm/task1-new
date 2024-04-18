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

% 设置窗口大小和步长
windowSize = 4000;
stepSize = 1000; % 步长为1000个样本

% 创建动态图
figure;

% 初始化滑动窗口图
hLines = plot(t(1:windowSize), v1(1:windowSize), 'b-', ...
              t(1:windowSize), v2(1:windowSize), 'r-', ...
              t(1:windowSize), v3(1:windowSize), 'g-', ...
              t(1:windowSize), v4(1:windowSize), 'm-', ...
              t(1:windowSize), v5(1:windowSize), 'c-', ...
              t(1:windowSize), v6(1:windowSize), 'y-');
xlabel('Timestamp (us)');
title('Velocity vs Time');
legend('Gyroscope X', 'Gyroscope Y', 'Gyroscope Z', ...
       'Accelerometer X', 'Accelerometer Y', 'Accelerometer Z');
grid on;

% 初始时刻的 x 轴数据
initialXData = t(1:windowSize);

% 每次更新图形的时间间隔（秒）
updateInterval = 1.0; % 调整为所需的时间间隔

% 保持程序持续运行的主循环
while true
    % 循环绘制滑动窗口图
    for i = 1:stepSize:(length(t) - windowSize + 1)
        % 提取当前窗口数据
        startIndex = i;
        endIndex = i + windowSize - 1;
        windowT = t(startIndex:endIndex);
        windowV1 = v1(startIndex:endIndex);
        windowV2 = v2(startIndex:endIndex);
        windowV3 = v3(startIndex:endIndex);
        windowV4 = v4(startIndex:endIndex);
        windowV5 = v5(startIndex:endIndex);
        windowV6 = v6(startIndex:endIndex);

        % 计算 x 轴偏移量
        xOffset = t(startIndex) - initialXData(1);
        newXData = initialXData + xOffset;

        % 更新滑动窗口图
        set(hLines(1), 'XData', newXData, 'YData', windowV1); % 更新第一组数据
        set(hLines(2), 'XData', newXData, 'YData', windowV2); % 更新第二组数据
        set(hLines(3), 'XData', newXData, 'YData', windowV3); % 更新第三组数据
        set(hLines(4), 'XData', newXData, 'YData', windowV4); % 更新第四组数据
        set(hLines(5), 'XData', newXData, 'YData', windowV5); % 更新第五组数据
        set(hLines(6), 'XData', newXData, 'YData', windowV6); % 更新第六组数据

        % 设置 Y 轴的限制
        ylim([-150, 150]);


        % 等待一段时间以观察图形
        pause(updateInterval); % 控制滑动速度
    end
end
