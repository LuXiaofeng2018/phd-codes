function [w, h] = adabstdemo(x, y, T, learn, func, ...
                             finish, drawsymb, pausestep)

%   ADABSTDEMO      ADA Boost Demonstration
%
%   ADABSTDEMO(X,Y,ITERS,@LEARN,@CLASSFUN,FIN,DRAWSYM,STEP)
%
%   X contains the features, and Y contains the class labels {-1, 1}.
%   ITERS is the maximum number of iterations.
%   LEARN is the name of the function for the learner, and CLASSFUN is the
%   name of the function that will provide a classification output.
%   FIN is 0 if one wants to converge to zero training error.
%   DRAWSYM is 1 if the size of the characters is proportional to the
%   error in the current classifier or 0 otherwise.
%   STEP equal to 1 means the process will pause at each iteration and will
%   restart when the user hits a key. STEP equal to 100 provides a movie
%   view. 
%
%   This function will provide graphical demonstrations of the ADA Boost
%   method. The decision stump is included as the learner.
%
%   EXAMPLES:
%
%   % This first demo shows a small data set. The user must kit any key to
%   % continue at each step of the iteration. See demo1.m for more details.
%   load demo1.mat
%   [w, h] = ...
%        adabstdemo(x, y, 10, @stumplearn, @stumpfunc, 0, 1, 1);
%
%   % The next demo shows a donut-shape data set. It will run for 50
%   % iterations in movie view. See demo2.m for more details.
%   load demo2.mat
%   [w, h] = ...
%       adabstdemo(x, y, 50, @stumplearn, @stumpfunc, 1, 0, 100);
%
%   % The final demo shows a discrimnant boundary given by a sine function.
%   % It will run for 100 iterations. The size of the characters displayed
%   % is given by the error in the previous iteration. So, large characters
%   % are the ones that the current classifier will concentrate on.
%   load demo3.mat
%   [w, h] = ...
%       adabstdemo(x, y, 100, @stumplearn, @stumpfunc, 1, 1, 100);
%
%   See also CSBOOST, AGGREGATE, STUMPFUNC, STUMPLEARN
%                  
% This is boosting code from Hsuan-Tien Lin, Cal Tech.
% This is included in the text and the CS Toolbox, with his permission.

%   W. L. and A. R. Martinez, 12/14/07
%   Computational Statistics Toolbox, V 2 

warning('off')

N = size(x, 1);
w = zeros(T, 1);
d = ones(N, 1) ./ N;
h = cell(T, 1);
stoptoken = 0;

ispos = (y > 0);
pos = find(ispos);
neg = find(~ispos);

minX = min(x(:, 1));
maxX = max(x(:, 1));
minY = min(x(:, 2));
maxY = max(x(:, 2));

gridX = (maxX - minX) ./ 100;
gridY = (maxY - minY) ./ 100;

minX = minX - 10 * gridX;
maxX = maxX + 10 * gridX;
minY = minY - 10 * gridY;
maxY = maxY + 10 * gridY;

[bigX, bigY] = meshgrid(minX:gridX:maxX, minY:gridY:maxY);
ntest=size(bigX, 1) * size(bigX, 2);
tx=[reshape(bigX, ntest, 1), reshape(bigY, ntest, 1)];

trainerr = [];

for t=1:T
%% Draw   
  clf;
  hold on;
  
  if t > 1
    theta = h{t-1};
    if theta(3) == 1
      if ~finish
        if theta(1) > 0
          fill([theta(2), theta(2), maxX, maxX], ...
               [minY, maxY, maxY, minY], 'y');
        else
          fill([theta(2), theta(2), minX, minX], ...
               [minY, maxY, maxY, minY], 'y');      
        end        
      end              
      H = line([theta(2), theta(2)], [minY, maxY]);
    else
      if ~finish
        if theta(1) > 0
          fill([minX, maxX, maxX, minX], ...
               [theta(2), theta(2), maxY, maxY], 'y');
        else
          fill([minX, maxX, maxX, minX], ...
               [theta(2), theta(2), minY, minY], 'y');
        end        
      end                    
      H = line([minX, maxX], [theta(2), theta(2)]);
    end
    set(H, 'LineStyle', '-.', 'LineWidth', 3, 'Color', [0 0 1])
  end
  
  
  if drawsymb
    for n=1:N
      if y(n) > 0
        symbol = 'o';
      else
        symbol = 'x';
      end
      fontsize = ceil(d(n) * 10 * N) * 2;
      if fontsize > 32
        fontsize = 32;
      end      
      text(x(n, 1), x(n, 2), symbol, 'FontSize', fontsize);
    end
  else
    plot(x(pos, 1), x(pos, 2), 'o');
    plot(x(neg, 1), x(neg, 2), 'x');
  end
  
  [lbl, z] = aggregate(w, h, func, tx);
  bigZ = reshape(z, size(bigX, 1), size(bigX, 2));
  [C, H] = contour(bigX, bigY, bigZ, [0 0]);
  set(H, 'Color', [1 0 0], 'LineWidth', 5)
  
  
  axis([minX maxX minY maxY]);
  drawnow;

  if mod(t-1, pausestep) == 0
      disp('HIT ANY KEY TO CONTINUE')
    pause;
  end
  
  if stoptoken
    break;
  end

  t
  h{t} = learn(x, y, d);
  hx = func(h{t}, x);
  
  err = sum(((y .* hx) < 0) .* d);
  if err < 1e-10
    T = 1;
    h{T} = h{t};
    w(T) = 1;
    stoptoken = 1;
    continue;
  end  

  w(t) = 0.5 * log((1 - err) ./ err);

  
  d = d .* exp(- (y .* hx) * w(t));
  d = d ./ sum(d);
  
  [yy, mgn] = aggregate(w, h, func, x);  
  trainerr(t) = sum(yy ~= y) ./ N * 100;  
  
  if ~finish && trainerr(t) < 1e-10
    T = t;
    stoptoken = 1;
    continue;
  end  
  
end

w = w(1:T, 1) ./ sum(w);
h = {h{1:T}};

warning('on')
