function Color_MeasuringCIE
%情報通信実験５：ガンマ特性と色度図を作成する
%このプログラムは、情報通信実験５「CIE色度座標の計測」のプログラムです。
%2018/11/8 Hisakata made:

Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference', 'TextAlphaBlending',1);
KbName('UnifyKeyNames');

ScreenNumber = max(Screen('Screens'));
[w,rect] = Screen('OpenWindow',ScreenNumber);
Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
xcenter = rect(3)/2;
ycenter = rect(4)/2;

origLUT = Screen('ReadNormalizedGammaTable',w);
lut = linspace(0,1,256);
LUT(:,1)=lut;LUT(:,2)=lut;LUT(:,3)=lut;
Screen('LoadNormalizedGammaTable',w,LUT);

%Parameters ========================
r=255;
g=255;
b=255;

r_gamma = 1.00;
g_gamma = 1.00;
b_gamma = 1.00;

ovalsize = rect(4)/4;
ovalrect = [xcenter-ovalsize ycenter-ovalsize xcenter+ovalsize ycenter+ovalsize];

scaleWidth = 250;
xposi = rect(3)/2;

%Measuring==========================
KeyInputStopper;

LUT(:,1)=lut.^(1/r_gamma);LUT(:,2)=lut.^(1/g_gamma);LUT(:,3)=lut.^(1/b_gamma);
Screen('LoadNormalizedGammaTable',w,LUT);

[normBoundsRect, offsetBoundsRect, textHeight, xAdvance] = Screen('TextBounds',w,'Quit',rect(3)*0.1,rect(4)*0.1);

Screen('FillRect',w,[127 127 127]);
Screen('FillOval',w,[r,g,b],ovalrect);

Screen('DrawText',w,'Quit',rect(3)*0.1,rect(4)*0.1,[0 0 0],[255 255 255]);

[r_ScalepointRect,r_inputRect] = DrawingBars(w,rect,1,r);%Red
[g_ScalepointRect,g_inputRect] = DrawingBars(w,rect,2,g);%Green
[b_ScalepointRect,b_inputRect] = DrawingBars(w,rect,3,b);%Blue
Screen('Flip',w,0,1);
while 1
    Screen('FillOval',w,[r,g,b],ovalrect);
    [x,y,buttons] = GetMouse(w);
    
    if buttons(1) == 1
        %スライダーでRの値を変える
        if (x >= r_ScalepointRect(1)-20 && x <= r_ScalepointRect(3)+20) && (y >= r_ScalepointRect(2) && y <= r_ScalepointRect(4))
            r = round((x - (xposi-scaleWidth))/(scaleWidth*2)*255); 
            if r < 0; r = 0;elseif r > 255; r = 255;end
            Screen('FillRect',w,[255 255 255],r_inputRect);
            r_ScalepointRect = DrawingBars(w,rect,1,r);%Red
        
        %直接入力でRの値を変える
        elseif (x >= r_inputRect(1) && x <= r_inputRect(3)) && (y >= r_inputRect(2) && y <= r_inputRect(4))
            
            Screen('FillRect',w,[255 255 255],r_inputRect);
            r = GetEchoNumber(w,'R:', r_inputRect(1), r_inputRect(2), [255 0 0]);
            r = round(r);
            if r < 0; r = 0;elseif r > 255; r = 255;end
            r_ScalepointRect = DrawingBars(w,rect,1,r);%Red
           
        %スライダーでGの値を変える
        elseif  (x >= g_ScalepointRect(1)-20 && x <= g_ScalepointRect(3)+20) && (y >= g_ScalepointRect(2) && y <= g_ScalepointRect(4))
            
            g = round((x - (xposi-scaleWidth))/(scaleWidth*2)*255); 
            if g < 0; g = 0;elseif g > 255; g = 255;end
            Screen('FillRect',w,[255 255 255],g_inputRect);
            g_ScalepointRect = DrawingBars(w,rect,2,g);%Green
            
        %直接入力でGの値を変える
        elseif (x >= g_inputRect(1) && x <= g_inputRect(3)) && (y >= g_inputRect(2) && y <= g_inputRect(4))
            
            Screen('FillRect',w,[255 255 255],g_inputRect);
            g = GetEchoNumber(w,'G:', g_inputRect(1), g_inputRect(2), [255 0 0]);
            g = round(g);
            if g < 0; g = 0;elseif g > 255; g = 255;end
            g_ScalepointRect = DrawingBars(w,rect,2,g);%Green

        %スライダーでBの値を変える
        elseif (x >= b_ScalepointRect(1)-20 && x <= b_ScalepointRect(3)+20) && (y >= b_ScalepointRect(2) && y <= b_ScalepointRect(4))
            b = round((x - (xposi-scaleWidth))/(scaleWidth*2)*255); 
            if b < 0; b = 0;elseif b > 255; b = 255;end
            Screen('FillRect',w,[255 255 255],b_inputRect);
             b_ScalepointRect = DrawingBars(w,rect,3,b);%Blue
        
        %直接入力でBの値を変える
        elseif (x >= b_inputRect(1) && x <= b_inputRect(3)) && (y >= b_inputRect(2) && y <= b_inputRect(4))
            
            Screen('FillRect',w,[255 255 255],b_inputRect);
            b = GetEchoNumber(w,'B:', g_inputRect(1), b_inputRect(2), [255 0 0]);
            b = round(b);
            if b < 0; b = 0;elseif b > 255; b = 255;end
            b_ScalepointRect = DrawingBars(w,rect,3,b);%Blue
            
        % 測定終了（Quitボタンをクリックする）
        elseif (x >= offsetBoundsRect(1) && x <= offsetBoundsRect(3)) && (y >= offsetBoundsRect(2) && y <= offsetBoundsRect(4))
            Screen('DrawText',w,'Quit',rect(3)*0.1,rect(4)*0.1,[255 255 255],[0 0 0]);
            Screen('Flip',w,0,1);
            WaitSecs(0.3);
            break
        end
    end
    
    Screen('Flip',w,0,1);
end
KeyInputStopper(false);

Screen('LoadNormalizedGammaTable',w,origLUT);
sca;
end
%% subfunction
function [scalepointRect,inputRect] =  DrawingBars(w,rect,color,value)
scalepointColor= [255 255 255];
scaleHight = 20;
scaleWidth = 250;
scalepointWidth = 10;
xposi = rect(3)/2;

scaleposi = ((value+1)/256) * scaleWidth*2 + (xposi-scaleWidth);

switch color
    case 1
        scaleColor= [127 100 100];
        
        yposi = rect(4)/2+rect(4)*0.3;
        
        scaleRect = [xposi-scaleWidth-4 yposi-scaleHight xposi+scaleWidth+5 yposi+scaleHight];
        scalepointRect = [scaleposi-scalepointWidth/2 yposi-scaleHight scaleposi+scalepointWidth/2 yposi+scaleHight];
        
        % Drawing the scala
        Screen('FillRect',w,scaleColor,scaleRect);
        Screen('FillRect',w,scalepointColor,scalepointRect);
        text = sprintf('R: %d',value);
        Screen('DrawText',w,text,xposi+300,yposi-20,[0 0 0]);
        [normBoundsRect, inputRect] = Screen('TextBounds',w,text,xposi+300,yposi-20);
        
         
    case 2
        scaleColor= [100 127 100];
        yposi = rect(4)/2+rect(4)*0.3+30;
        
        scaleRect = [xposi-scaleWidth-4 yposi-scaleHight xposi+scaleWidth+5 yposi+scaleHight];
        scalepointRect = [scaleposi-scalepointWidth/2 yposi-scaleHight scaleposi+scalepointWidth/2 yposi+scaleHight];
        
        % Drawing the scala
        Screen('FillRect',w,scaleColor,scaleRect);
        Screen('FillRect',w,scalepointColor,scalepointRect);
        text = sprintf('G: %d',value);
        Screen('DrawText',w,text,xposi+300,yposi-20,[0 0 0]);
        [normBoundsRect, inputRect] = Screen('TextBounds',w,text,xposi+300,yposi-20);
        
        
    case 3
        scaleColor= [100 100 127];
        yposi = rect(4)/2+rect(4)*0.3+60;
        
        scaleRect = [xposi-scaleWidth-4 yposi-scaleHight xposi+scaleWidth+5 yposi+scaleHight];
        scalepointRect = [scaleposi-scalepointWidth/2 yposi-scaleHight scaleposi+scalepointWidth/2 yposi+scaleHight];
        
        % Drawing the scala
        Screen('FillRect',w,scaleColor,scaleRect);
        Screen('FillRect',w,scalepointColor,scalepointRect);
        text = sprintf('B: %d',value);
        Screen('DrawText',w,text,xposi+300,yposi-20,[0 0 0]);
        [normBoundsRect, inputRect] = Screen('TextBounds',w,text,xposi+300,yposi-20);

end
end

%%
function f = KeyInputStopper(visible, position, flush)
persistent fhandle

if nargin < 1 || isempty(visible)
    visible = true;
end
if nargin < 2 || isempty(position)
    position = [0 0 100 50];
end
if nargin < 3 || isempty(flush)
    flush = true;
end
if ~isempty(fhandle)        % if a previous window seems alive
    drawnow;                % update GUI
    if ishandle(fhandle)    % check if it is really alive
        pause(0.05);        % don't know why, but we should pause a bit
        close(fhandle);     % close the prev window
    end
    fhandle = [];
end
if visible
    fhandle = figure('Position', position); % create a new window
    set(fhandle, 'NumberTitle', 'off');
    set(fhandle, 'Name', 'Stopper');
    set(fhandle, 'MenuBar', 'none');
    set(fhandle, 'Toolbar', 'none');
    set(fhandle, 'WindowStyle', 'modal');   % don't know if it's working
    figure(fhandle);        % bring it front
end
if flush
    while KbCheck; end      % wait until any key press is released
end
f = fhandle;
end
