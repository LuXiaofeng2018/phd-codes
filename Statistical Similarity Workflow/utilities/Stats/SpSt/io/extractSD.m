function extractSD(ids, in_sdfile, out_sdfile)

import de.tu_bs.phchem.jMUV.extractSD;

if (islogical(ids))
    ids = find(ids);
end

ids = cellstr(num2str(ids));

extractSD.extract(ids, in_sdfile, out_sdfile);