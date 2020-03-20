info = dicominfo('IMG0001.dcm');
Y = dicomread(info);
figure
imshow(Y,[]);