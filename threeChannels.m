% preview(vid)
stop(vid)
vid.FramesPerTrigger = Inf;
start(vid)
% figure
figure(1)
tic
tanterior=0;
while 1
    if vid.FramesAvailable>0
        [test time abstime] = getdata(vid,vid.FramesAvailable);
    
    %   pause(0.001)
        for ind=1:3 
            subplot(1,3,ind)
            imagesc(test(:,:,ind,1)')
            axis equal
        end
        t = toc;
        str=sprintf('pasaron %2.4f seg',1/(t-tanterior));
        title(str)
        tanterior=t;
        drawnow
    end
end
