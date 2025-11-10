% meros2.m
% Part 2 – Kbantopoihsh DCT se block 8x8
% Prin thn ektelesh tou script na ektelestoun oi entoles sto octave:
% pkg load image
% pkg load signal

clear;
clc;
close all;

pkg load image;

% 1 Diabazoume thn eikona pou dinetai
f_uint8 = imread('cameraman.tif');   % h arxikikh eikona se uint_8
[rows, cols] = size(f_uint8);
f       = double(f_uint8);           % gia ypologisoums se double

% 2. Ypologizoume thn entropia ths eikonas
H_orig = entropy(f_uint8);
fprintf('Entropy of original image: %.4f\n', H_orig);

figure;
imagesc(f_uint8); colormap(gray); axis image off;
title('Αρχική εικόνα');

% Pinakas Kbantopoihshs 01
Q1 = [ 16 11 10 16 24 40 51 61;
       12 12 14 19 26 58 60 55;
       14 13 16 24 40 57 69 56;
       14 17 22 29 51 87 80 62;
       18 22 37 56 68 109 103 77;
       24 35 55 64 81 104 113 92;
       49 64 78 87 103 121 120 101;
       72 92 95 98 112 100 103 99 ];

% Tha treksoume gia Q = 1*Q1 2*Q1 3*Q1
factors = [1 2 3];

for k = 1:numel(factors)

    fprintf('\n==============================\n');
    fprintf('Q = %d * Q1\n', factors(k));
    fprintf('==============================\n');

    %Xwrizei thn eikona se block 8x8

    Q = factors(k) * Q1;                 %Katallhlos pinakas kbantopoihshs
    F_hat = zeros(rows, cols);           %  Kbantismenoi syntelestes DCT (F)

    %% 4–5. DCT kathe block kai kbantopoihsh F_hat(u,v) = round(F(u,v) / Q(u,v))
    for m = 1:8:rows
        for n = 1:8:cols
            block  = f(m:m+7, n:n+7);     % block 8x8
            F      = dct2(block);         % DCT tou block
            Fq     = round(F ./ Q);       % kbantopoihsh
            F_hat(m:m+7, n:n+7) = Fq;     % apothikeush F̂
        end
    end

    %6. Entropia ths apolyths timhs ton kbantismenwn syntelestwn
    H_quant = entropy(abs(F_hat));
    fprintf('Entropy of |F_hat(u,v)|: %.4f\n', H_quant);

    % 7 Plithos midenikwn syntelestwn meta th kbantopoihsh
    zero_count = sum(F_hat(:) == 0);
    fprintf('Number of zero coefficients: %d\n', zero_count);

    % 8. Antistrofh kbantish: F_hat(u,v) = F_hat(u,v) .* Q(u,v)
    f_tilde = zeros(rows, cols);   % eikona meta tin IDCT (se double)

    for m = 1:8:rows
        for n = 1:8:cols
            Fq_block = F_hat(m:m+7, n:n+7);   % F_hat sto block
            F_rec    = Fq_block .* Q;         % F̃ anstistrofh kbantish

            %9. Antistrofos DCT tou block
            block_rec = idct2(F_rec);

            % 10. Clip stis times [0,255] kai metatroph se uint8
            block_rec(block_rec < 0)   = 0;
            block_rec(block_rec > 255) = 255;

            f_tilde(m:m+7, n:n+7) = block_rec;
        end
    end

    f_rec_uint8 = uint8(f_tilde);

    %11. Ypologismos PSNR kai emfanish eikonas
    % PSNR se sxesh me thn arxikh f se double
    MSE  = mean((f_tilde(:) - f(:)).^2);
    PSNR = 10 * log10(255^2 / MSE);

    fprintf('PSNR: %.4f dB\n', PSNR);

    figure;
    imagesc(f_rec_uint8);
    colormap(gray); axis image off;
    title(sprintf('Q = %d * Q1, PSNR = %.2f dB', factors(k), PSNR));

end

