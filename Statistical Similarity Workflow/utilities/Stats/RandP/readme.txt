Description 	

  RANDP - pick random values with relative probability
 
      R = RANDP(PROB,..) returns integers in the range from 1 to
      NUMEL(PROB) with a relative probability, so that the value X is
      present approximately (PROB(X)./sum(PROB)) times in the matrix R.
 
      All values of PROB should be equal to or larger than 0.
 
      RANDP(PROB,N) is an N-by-N matrix, RANDP(PROB,M,N) and
      RANDP(PROB,[M,N]) are M-by-N matrices. RANDP(PROB, M1,M2,M3,...) or
      RANDP(PROB,[M1,M2,M3,...]) generate random arrays.
      RANDP(PROB,SIZE(A)) is the same size as A.
 
      Examples:
        R = randp([1 3 2],1,10000) ;
        % return a row vector with 10000 values with about 16650 two's
        histc(R,1:3) ./ numel(R)
 
        R = randp([1 1 0 0 1],10,1)
        % 10 samples evenly drawn from [1 2 5]
 
        % randomly select 100 elements according to a specific distribution
        V = {'Red','Green','Blue'} ;
        ind = randp([80 10 10],200,1) ;
        R = V(ind) ; % should contain about 160 'Red'
 
      Also see RAND, RANDPERM
               RANDPERMBREAK, RANDINTERVAL, RANDSWAP (MatLab File Exchange)

version 2.0, feb 2009