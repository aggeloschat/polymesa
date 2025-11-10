function F = mydct(f)
% Metatrepw to f se sthlh gia na douleuw panta me sthlh
f = f(:);
N = length(f);

% Theloume h g na einai h f kai h anapodh f
g[f; flip(f)];

G=fft(g);

for u=0:(N-1)
  realGuPhase=real(G(u+1)*exp(-j*pi*u/(2*N)));
  if u==0
    F(u+1)=realGuPhase/(2*sqrt(N));
  else
    F(u+1)=realGuPhase/(2*sqrt(N));
  end
end
