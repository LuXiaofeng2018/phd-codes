function R = spst_generate_topologies(act, dec, classes, options)


% Generate different topologies of actives

% D-optimal Design

R = struct;

disp('Actives: D-Opt.');
for i=1:size(classes,1)
    c= char(classes(i));
    
    R.(c).dopt.act = spst_dopt(act.(c).dsc, [], 30, options);
    
end

% D-optimal Onion Design
disp('Actives: Onion');
for i=1:size(classes,1)
    c= char(classes(i));
    
    R.(c).onion.act = spst_onion(act.(c).dsc, [], 30, 5, options);
end

% Minimum Distance

disp('Actives: MinD');
for i=1:size(classes,1)
    c= char(classes(i));
    
    R.(c).mind.act = spst_mindist(act.(c).dsc, [], 30, 30, options);
end

% Kennard Stone
disp('Actives: KS');
for i=1:size(classes,1)
    c= char(classes(i));
    
    R.(c).ks.act = spst_kennardstone(act.(c).dsc, [], 30, options);
end


% Geneate different topologies of decoys

acts = {'dopt', 'onion', 'mind', 'ks'};

for a = 1:size(acts)
    
    ac = char(acts(a));
    
    disp(strcat('Decoys:',ac, '      **************************************'));
    
    for  i=1:size(classes,1)
        c= char(classes(i));
        
        % NN Decoys
        R.(c).(ac).dec{1} = spst_knn_decoys(act.(c).dsc(R.(c).(ac).act,:), dec.(c).dsc, [], 15000, options);
        
        % sigmaF = 300    
        options.targetG = 300;
        R.(c).(ac).dec{2} = spst_GA(act.(c).dsc(R.(c).(ac).act,:), dec.(c).dsc, R.(c).(ac).dec{1}, 15000, options);
        
        % random decoys
        R.(c).(ac).dec{3} = false(size(dec.(c).dsc,1),1);
        r = randperm(size(dec.(c).dsc,1));
        R.(c).(ac).dec{3}(r(1:15000),1) = true;
    end
end
        