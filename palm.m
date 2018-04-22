img_path='Samples\0001';
addpath(img_path);
addpath('Functions\DetectROI');
ROIL=repmat(struct('image',uint8(zeros(192,192))),1,5);
GABORL=repmat(struct('image',uint8(zeros(192,192))),1,5);
for i=1:5
    ROIL(i).image=findROI(img_path, ['\0001_m_l_0' num2str(i) '.jpg'],192,150);
end

%% cari ROI
figure;
suptitle('ROI - Tangan Kiri');
for j=1:5
    subplot(2,3,j)
    imshow(ROIL(j).image);
    title(['Citra 0' num2str(j) '.jpg']);
end

%% Deteksi Tepi
figure;
suptitle('Hasil Deteksi Tepi');
for j=1:5
    subplot(2,3,j)
    imL_bf_filter=edge(ROIL(j).image,'sobel');
    imL_af_filter=bwmorph(imL_bf_filter,'bridge');
    imshow(imL_af_filter);
    title(['Citra 0' num2str(j) '.jpg']);
end

% Gabor
wavelength = 64;
orientation = 0;
figure;
suptitle('Hasil Gabor');
for i=1:5
    subplot(2,3,i)
    [mag,phase] = imgaborfilt(ROIL(i).image,wavelength,orientation);
    GABORL(i).image = imbinarize(phase);
    imshow(phase);
    title(['Citra 0' num2str(i) '.jpg']);
end

dif = xor(GABORL(1).image,GABORL(2).image);
total = nnz(dif) %mencari nilai 1 pada matrik
figure;
suptitle('Perbedaan Citra');
imshow(dif);