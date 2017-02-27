function E = spst_muv_extractSD(act, dec, Rmuv, classes, sddir, outdir, suffix, options)

import de.tu_bs.phchem.jMUV.extractSD;

for i=1:size(classes,1)
    classe = char(classes(i));
    
    idsact = cellstr(num2str(act.(classe).ids(Rmuv.act.(classe),1)));
    idsdec = cellstr(num2str(dec.(classe).ids(Rmuv.dec.(classe),1)));
    
    asdfile = strcat(sddir, options.sep, classe, '_', suffix{1}, '.sdf');
    %disp(strcat('actives:', asdfile));
    
    dsdfile = strcat(sddir, options.sep, classe, '_', suffix{2}, '.sdf');
    %disp(strcat('decoys:', dsdfile));
    
    aoutfile = strcat(outdir, options.sep, classe, '_', suffix{1}, '.sdf');
    doutfile = strcat(outdir, options.sep, classe, '_', suffix{2}, '.sdf');
    
    extractSD.extract(idsact, asdfile, aoutfile);
    extractSD.extract(idsdec, dsdfile, doutfile);
end

E = [];