
%inicializa la camara
vid = videoinput('winvideo', 1, 'RGB24_640x480');
src = getselectedsource(vid);
%%
%inicializa la camara
% vid = videoinput('winvideo', 1, 'YUY2_640x480');
% src = getselectedsource(vid);
% src.Exposure = -9;
% vid.ReturnedColorspace = 'rgb';
% 
% preview(vid);

%%

vid.FramesPerTrigger = Inf;

% pos(i,:) guarda la posicion de la particula en la i-esima imagen
pos = [nan nan];
i=1;

stop(vid);
start(vid);

%imgs guarda las ultimas 3 imagenes
imgs = uint8(zeros([480 640 3 3]));

%el indice ndx indica en que posicion de imgs se agrega la nueva imagen
%otros(ndx) es siempre la imagen siguiente a ndx
ndx = 1;
otros = [2 3 1];

while (1)
%     figure(1)
    if vid.FramesAvailable>=1
        
        imgs(:, :, :, ndx) = getdata(vid, 1);
        % I es la diferencia entre 2 imagenes consecutivas
        I=(double(imgs(:,:,1,ndx))-double(imgs(:,:,1,otros(ndx))));
        
        %radio y centro en pixeles
        radio = 130;
        centro = [354, 230];
        
        pos(i,:) = calcula_posicion_en_una_imagen(I,centro,radio);
        i=i+1;
           
    end
    
    ndx = mod(ndx, 3) + 1;
end
