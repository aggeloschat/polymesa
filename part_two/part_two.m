clear;
image = imread('cameraman.tif');
[rows columns] = size(image);

entropy(image)
figure;
imagesc(image);
colormap(gray);


Q1=[ 16 11 10 16 24 40 51 61;
     12 12 14 19 26 58 60 55;
     14 13 16 24 40 57 69 56;
     14 17 22 29 51 87 80 62;
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 104 113 92;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99
   ];

m=1;
while m<=rows
  n=1;
  while n<=columns
      F_k(m:m+7,n:n+7)=round(dct2(image(m:m+7,n:n+7))./Q1);
      n=n+8;
  end
  m=m+8;
end

entropy(abs(F_k))

zero_count=0;
m=1;
while m<=rows
  n=1;
  while n<=columns
      if (abs(F_k(m,n))==0)
          zero_count=zero_count+1;
      end
      n=n+1;
  end
  m=m+1;
end
zero_count
m=1;
while m<=rows
  n=1;
  while n<=columns
      nimage(m:m+7,n:n+7)=uint8(idct2(F_k(m:m+7,n:n+7).*Q1));
      n=n+8;
  end
  m=m+8;
end
image=double(image);
nimage=double(nimage);
psnr=10*log10((255*255)/(sum(sum((nimage-image).^2))/(rows*columns)))

figure;
imagesc(nimage);
colormap(gray);

Q2=2*Q1;

m=1;
while m<=rows
    n=1;
    while n<=columns
        F_k(m:m+7,n:n+7)=round(dct2(image(m:m+7,n:n+7))./Q2);
        n=n+8;
    end
    m=m+8;
end

entropy(abs(F_k))

m=1;
while m<=rows
    n=1;
    while n<=columns
        nimage(m:m+7,n:n+7)=uint8(idct2(F_k(m:m+7,n:n+7).*Q2));
        n=n+8;
    end
    m=m+8;
end

image=double(image);
nimage=double(nimage);
psnr=10*log10((255*255)/(sum(sum((nimage-image).^2))/(rows*columns)))

figure;
imagesc(nimage);
colormap(gray);

Q3=3*Q1;

m=1;
while m<=rows
    n=1;
    while n<=columns
        F_k(m:m+7,n:n+7)=round(dct2(image(m:m+7,n:n+7))./Q3);
        n=n+8;
    end
    m=m+8;
end

entropy(abs(F_k))

m=1;
while m<=rows
    n=1;
    while n<=columns
        nimage(m:m+7,n:n+7)=uint8(idct2(F_k(m:m+7,n:n+7).*Q3));
        n=n+8;
    end
    m=m+8;
end
image=double(image);
nimage=double(nimage);
psnr=10*log10((255*255)/(sum(sum((nimage-image).^2))/(rows*columns)))

figure;
imagesc(nimage);
colormap(gray);
