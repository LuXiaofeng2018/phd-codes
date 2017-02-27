function S = spst_read_data(classes, prefix, suffix)

for i=1:size(classes,1)
    
    classe = char(classes(i,1));
    
    filename = strcat(prefix, classe, suffix);
    
    l = load(filename);
    
    [S.(classe).ids IDx] = sort(l(:,1),1);
    S.(classe).dsc = l(IDx,2:end);
    
end

