function B = NodeToCell(A)
    B = conv2(+A,ones(2,2)/4,'valid');
end