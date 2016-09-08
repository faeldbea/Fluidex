function pos = calcula_posicion_en_una_imagen(I,centro,radio)
      %pos es un vector de 1x2 con la posicion de la particula. si no
      %encuentra ninguna devuelve [nan nan]
      
%     subplot(2,2,1)
%     imagesc(I)

    %los pixeles negativos se ponen en 0, eliminando una de las particulas.
    % Ademas se rescalan los valores pues graytresh toma intensidad
    % normalizada
    I(I<0)=0;
    I=I/max(I(:));
   
    % graytrsh selecciona un umbral tresh usando el metodo de Otsu
    thres=graythresh(I);
    
    %im2bw convierte los pixeles de I por encima de tresh en 1, y los
    %menores a tresh en 0.
    BW = im2bw(I,thres);
%     subplot(2,2,2)
%     imagesc(BW)


    % L reconoce objetos en BW, asignando un numero distinto a cada region 
    % contigua de unos (1) en BW.
    [~,L] = bwboundaries(BW,'noholes');   
%     imshow(label2rgb(L, @jet, [.5 .5 .5]))
%     hold on
%     scatter(centro(1), centro(2), 'x')
%     hold off
%     
  
%     subplot(2,2,4)
    %stats contiene las areas  y los centroides de los objetos en L
    stats = regionprops(L,'Area','Centroid');
    
    % elimina los demasiado grandes o demasiado chiquitos
    maxarea=1000;
    minarea=50;
    index=find([stats.Area]>minarea & [stats.Area]<maxarea);
    L(~ismember(L,index))=0;

    
    % quito todos los objetos mas alla de la region circular.
    % esto deberia hacerlo al principio sobre I en vez de sobre L, estoy
    % calculando objetos que ya se que voy a quitar.
    [X,Y] = meshgrid(1:640,1:480);
    X = X-centro(1);
    Y = Y - centro(2);
    Mdist = sqrt(X.^2+Y.^2);
    index = Mdist > radio;
    L(index) = 0;
    
%     imshow(label2rgb(L, @jet, [.5 .5 .5]))
%     hold on
%     scatter(centro(1), centro(2), 'x')
%     hold off
%     
    if max(L(:))>0   %solo si queda algun objeto     
        u = unique(L);
        %me quedo con el mas grande
        [~, indmax]=max([stats(u(2:end)).Area]);
        %pero acordate que no miramos el cero (el primero asi que)
        indmax=indmax+1;
        
        pos = stats(u(indmax)).Centroid;
%         hold on 
%         plot(pos(1),pos(2),'ko')
%         hold off
    else
        pos=[nan nan];
    end
    
end
