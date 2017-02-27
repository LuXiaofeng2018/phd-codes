function K = spst_ripleysK(D, map, options)
%
% K = spst_ripleysK(D, map,options)
%
% Input:    D       Data matrix with rows = observations, columns=variables
%
%           map     Hypercubic map for uniform csr. For higher data
%                   dimensions (>3) the use of a map and corresponding edge
%                   correction is strongly advised against. Use map = [] instead.
%
%           options Options struct variable. Default values are indicated
%                   by *asterisks*.
%
%           options.distmode:   *'euc'*, 'city', 'cheby'
%           options.step:       *0.008*, any decimal
%           options.maxD:       *4*, any integer
%
% Copyright:        Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008

% if options is omitted, set default values
if (nargin < 3)
    options.distmode='euc';
    options.step=0.01;
    options.maxD=10;
end

[m, n] = size(D);


% if a map is used, caculate area. Else set area  = 1;
if (size(map,2) < 1)
    A = 1;
else
    A = prod(abs(map(1,:) - map(2,:)));
end

% set x-Axis
x = 0:options.step:options.maxD;
K = zeros(size(x,2),1);
if (size(map,2) > 2)
    error('spst_ripleysK: maps with dimension >2 not supported!!');
end

if (m <= 10000)     % Does the problem fit into memory? Adjusting this parameter to your system
                    % may considerably speed up the calculation.
    
    % compute intraset event-event distance matrix
    d = distance(D,D, options.distmode);
    
    % Set diagonal elements (distance of an event to itself) to a big
    % number in order to exclude it from the calculation
    bigdiag = diag(ones(size(d,1),1).*9999999999999999999999);
    d = d+bigdiag;

    

    for i=1:size(x,2)

        t = x(i);
        
        % weights will only apply, if the data is 2-dimensional (classical
        % Ripley's K) as in the citation above
        
        if (map)
            if (strcmpi(options.weight, 'fortin'))
                
                % h= weight vector
                h = zeros(m,1);
                
                % for each event, create a circle or radius t around the
                % event. The weight is the fraction of points in the circle
                % that are within the map's borders.
                for k=1:m

                    s = circ_sec(D(k,:), t, options.distmode);

                    on = sum(isonmap(s, map));

                    h(k,1) = on/size(s,1);
                end

                h = h*ones(1,m);

            elseif(strcmpi(options.weight, 'ripley'))

                h = zeros(m);
                for r = 1:m
                    for q = 1:m

                        s = circ_sec(D(r,:), d(r,q), dist_mode);
                        on = sum(isonmap(s, map));
                        h(r,q) = on/size(s,1);
                    end
                end
            end
        end
        
        % event-event distances smaller than t
        dsmt = double(d<t);
        % apply weights, if necessary
        if (size(map,2) == 2)
            dsmt = dsmt.*h;
        end
        % sum for each column
        wI = sum(dsmt,2);
        % multiply with area, scale by number of event-event pairs.
        K(i,1) = A*sum(wI)/m^2;
    end
else
    
    % Split the problem to chunks. K will be summed up in the end.
    ch_size = 200;
    chunks = 1:ch_size:m;
    numchunks = numel(chunks);
   
    % Initialize for batchwise calculation of K
    KK = zeros(distbins, numchunks);
    
    for c = 1:numchunks-1
        
        % calculate distance of chunk to the complete dataset
        d = distance(D(chunks(c):(chunks(c)+ch_size-1),:),D, options.distmode);

        % now it is not the main diagonal with the self-distances!!!
        bigdiag = diag(ones(ch_size,1).*9999999999999999999999);
        d(:,chunks(c):chunks(c)+ch_size-1) = d(:,chunks(c):chunks(c)+ch_size-1)+bigdiag;
        
        % the rest is exactly as above
        for i=1:size(x)

            t = x(i);
            
            if (size(map,2) == 2)
                if (strcmpi(options.weight, 'fortin'))

                    h = zeros(ch_size,1);

                    for k=0:ch_size-1

                        s = circ_sec(D(chunks(c)+k,:), t, dist_mode);

                        on = sum(isonmap(s, map));

                        h(k+1,1) = on/size(s,1);
                    end

                    h = h*ones(1,m);

                elseif(strcmpi(weight_mode, 'ripley'))

                    h = zeros(m);
                    for r = 0:ch_size-1
                        for q = 1:m

                            s = circ_sec(D(chunks(c)+r,:), d(r+1,q), dist_mode);
                            on = sum(isonmap(s, map));
                            h(r+1,q) = on/size(s,1);
                        end
                    end
                end
            end

            dsmt = double(d<t);
            
            if (size(map,2) == 2)
                dsmt = dsmt.*h;
            end
            
            wI = sum(dsmt,2);

            KK(i,c) = sum(wI);
        
        end
    end
    
    % last chunk (may be smaller than 2000)
    d = distance(D(chunks(c):end,:),D, options.distmode);

    % now it is not the main diagonal with elements d(i,i)!!!
    % and the matrix to add is not of size 2000,2000
    nummissing = m-chunks(c)+1;
    bigdiag = diag(ones(nummissing,1).*9999999999999999999999);
    d(:,chunks(c):end) = d(:,chunks(c):end)+bigdiag;


    for i=1:size(x,2)

        t = x(i);
        % weights 

        if (strcmpi(options.weight, 'fortin'))

            h = zeros(nummissing,1);

            for k=0:nummissing-1

                s = circ_sec(D(chunks(c)+k,:), t, options.distmode);

                on = sum(isonmap(s, map));

                h(k+1,1) = on/size(s,1);
            end

            h = h*ones(1,m);

        elseif(strcmpi(options.weight, 'ripley'))

            h = zeros(m);
            for r = 0:nummissing-1
                for q = 1:m

                    s = circ_sec(D(chunks(c)+r,:), d(r+1,q), options.distmode);
                    on = sum(isonmap(s, map));
                    h(r+1,q) = on/size(s,1);
                end
            end
        end

        dsmt = double(d<t);
        if(size(map,2) == 2)
            dsmt = dsmt.*h;
        end
        
        wI = sum(dsmt,2);

        KK(i,end) = sum(wI);
    end
    % sum over all chunks
    K = sum(KK,2);
    K = A*K/m^2;    % scale by number of events, multiply with area
    x = 0:options.step:options.maxD;
end
        
% concatenate with x-Axis and return

K = [x' K];
    



