I = double(dicomread('E:\studia\VI sem\Moje\POM\Projekt-POM\MR-g³owa\STU0001\IMG0001.dcm'));
I2 = double(dicomread('E:\studia\VI sem\Moje\POM\Projekt-POM\MR-g³owa\STU0001\IMG0002.dcm'));
I(:,:,2)= I2;
maska = regiongrowing(I(:,:,1));
maska2 = regiongrowing(I2);
maska(:,:,2) = maska2;
%%

previousPixelIntensity = 0;
            se = strel('square',3); %element morfologiczny
            threshold = 10;
            for i = 1:2
            clear centroid
            Im = I(:,:,i);
            
            Isegmented = regiongrowing(Im, 106, 366);    %segmentation
            Iclosed = imclose(Isegmented, se);                %morfological close
            Iopen = imopen(Iclosed, se);                                 %morfological open
                                               
            imshow(Iclosed);
            
            maska(:,:,i) = Iclosed;
            centroid = regionprops(Iclosed, 'Centroid');
            pixelIntensity = I(round(centroid.Centroid(1)), round(centroid.Centroid(2)));
                if abs(pixelIntensity -previousPixelIntensity)< threshold || i ==1      
                    previousPixelIntensity = pixelIntensity;
                    disp(i)
                    figure
                    imshow(maska(:,:,i))
                    pause
                else
                    break
                end
                
            end


% figure(3)
%%
contourslice(maska, [], [], 1:2)
%% 
[X,Y] = meshgrid(0:1:512,1:0:512);
Z = sin(X) + cos(Y);
surf(X,Y,Z)
%% 
[y,z] = meshgrid(linspace(0,10,40));
    
  x = 200;
    % My standin for your vorticity data
    c = cos((x+y)/5) .* cos((x+z)/5);
    surf(x,y,z,c)
    hold on
  
  hold off
  xlim([0 200])
  
  %% 
  load mask.mat
  
visualization = vol3d('cdata',masktemp,'texture','3D');
view(3);  
axis tight; daspect([1,1,1]);
isosurface();
% alphamap('default');
% alphamap(.06 .* alphamap);
%%
regionprops3(masktemp, 'all')