function F = mydct2(f)

rows = size(f,1);
columns = size(f,2);

% DCT se kathe grammh
for w=1:rows
  nf(w,:) = mydct(f(w,:)).'; % Transpose gia na ginei ksana seira epeidh h dct ta kanei sthles
end
% DCT se kathe sthlh
for w=1:columns
  F(:,w) = mydct(nf(:,w));
end

end

