pos = [pos21;pos22;pos23;pos24;pos25;pos26;pos27;pos28;pos29;pos30;...
        pos31;pos32;pos33;pos34];

% [pos11;pos12;pos13;pos14;pos15;pos16;pos17;pos18;pos19;pos20];
% [pos35;pos36;pos37;pos38;pos39;pos40;pos41;pos42;pos43;pos44;...
%         pos45;pos46];


centro = [354, 230];
radios = sqrt((pos(:,1)-centro(1)).^2 + (pos(:,2)-centro(2)).^2);
pos(radios<25,:)=nan;
radios = sqrt((pos(:,1)-centro(1)).^2 + (pos(:,2)-centro(2)).^2);

vels = pos(2:end,:)-pos(1:end-1,:);


modvels = sqrt(vels(:,1).^2 + vels(:,2).^2);

subplot(2,2,1)
quiver(pos(1:end-1,1), pos(1:end-1,2), vels(:,1), vels(:,2))
hold on
scatter(centro(1),centro(2))
axis([0,640,0,480])
hold off

subplot(2,2,2)
plot(radios)


subplot(2,2,3)
plot(modvels)


subplot(2,2,4)
plot(radios(1:end-1),modvels, '+r')
