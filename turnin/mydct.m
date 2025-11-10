% Prin thn ektelesh tou script na ektelestoun oi entoles sto octave:
% pkg load image
% pkg load signal

function F = mydct(f)
% Metatrepw to f se sthlh gia na douleuw panta me sthlh
f = f(:);
N = length(f);

% Theloume h g na einai h f kai h anapodh f
g = [f; flip(f)];

G=fft(g);

w_0=1/sqrt(N);
w_greater=sqrt(2)/sqrt(N);
for u=1:N
    F(u)=G(u)*exp(-j*pi*(u-1)/(2*N));
    if u==1
        F(u)=F(u)*w_0/2;
    else
        F(u)=F(u)*w_greater/2;
    end
end

end
