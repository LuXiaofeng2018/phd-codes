function simple = muv_simple_descriptors(sdfdir, classes, suffix, mode, options)
%
% simple = muv_simple_descriptors(sdfdir, classes, suffix, mode, options)
%
% Calculate simple descriptors for a directory of SD-files
%
% Input:    sdfdir (String) path of the directory with SD-files
%           
%           classes Cell array of activity class names
%
%           suffix  Cell array of suffices
%
%           mode    'OE'  uses OpenEye Tools for descriptor calculation
%                   'CDK' uses the Chemistry Development Kit (CDK)
%
%           options SpSt options struct
%
% Output:   act     Data struct of actives as created by spst_read_data
%            .ids.(class)   Data struct of unique identifiers for each compound.
%                           Each field (class) contains mx1 ids.
%            .dsc.(class)   Descriptor matrices for each class. (mxn)
%           
%           dec     Data struct of decoys with as created by spst_read_data
%            .ids.(class)   Data struct of unique identifiers for each compound.
%                           Each field (class) contains mx1 ids.
%            .dsc.(class)   Descriptor matrices for each class. (mxn)
%
%
%
% Copyright:        Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008

% Import java classes from jMUV
% The file jMUV.jar must be included in your Matlab classpath
% See Matlab help for details.
import de.tu_bs.phchem.jMUV.SimpleDescriptors;
import de.tu_bs.phchem.jMUV.SimpleDescriptorsOE;

% If you want to use OpenEye's Babel and Filter for calculating the
% descriptors, hardcode the respective commands here.
babelcmd = 'babel';
filtercmd= 'filter';
% if your use the OpenEye tools, you also need to specify a scratch
% directory to which you have write access
scratch = '/home/baschti/scratch';


% Column-wise scaling factors derived from a comprehensive sample of
% chemical space are hard-coded here.

% When calculated with OpenEye tools
% mean
mOE = [0.0048    0.0684   24.2515    0.2610    0.3320    0.0208    2.5528    4.2024    0.0199    0.3584   32.0773   58.7606    2.2126    3.7800    1.9857    2.7780    3.6006];
% standard deviation
sOE = [0.0785    0.2931   11.7798    0.6391    1.0921    0.1576    1.7370    2.9589    0.1809    0.6357   14.5133   28.4246    2.8201    2.4140    1.9201    1.4949    2.7040];
% When calculated with the CDK tools
% mean
mCDK = [0.0046    0.0665   23.9777    0.2569    0.3274    0.0202    2.5479    4.1616    0.0203    0.3568   31.7450   58.2312         0    6.0623    1.7723    2.7397   3.7942];
% standard deviation
sCDK = [0.0766    0.2896   11.6926    0.6342    1.0814    0.1571    1.7535    2.9585    0.1823    0.6359   14.4233   28.2651         0    3.4033    1.6058    1.4851   2.7040];

% When calculated with the CDK 

if (options.verbose)
    disp('This program calculates simple descriptors for a directory of SD-files.');
    disp('The content of the descriptor vectors is:');
    disp('#B #Br #C #Cl #F #I #N #O #P #S #HeavyAtoms #TotalAtoms #ChiralCenters #HBondAcc #HBondDon #RingSystems LogP');
end

% loop through files in directory
for i=1:size(classes,1)
    
    classe = char(classes(i));
    
    % compile the filename
    filename = strcat(sdfdir, options.sep, classe, '_', suffix, '.sdf');
    
    % calculate the descriptors
    if (options.verbose)
        disp(strcat('Calucalting simple descriptors for:', filename, '...'));
    end
    
    % do the actual calculation either with OpenEye Filter/Babel or...
    if (strcmpi(mode, 'OE'))
        
        descmat = SimpleDescriptorsOE.calculateMatrix(filename, filtercmd, babelcmd, scratch);
        
    % with the CDK
    elseif(strcmpi(mode, 'CDK'))
         descmat = SimpleDescriptors.calculateMatrix(filename);
    else
        error(strcat('Simple descriptor mode:', mode, '!NOT! supported. Possible values: OE or CDK.'));
    end
    
    if (options.verbose)
        disp('...done.');
    end
    
    
    % first column: molecular ids, sort.
    [simple.(classe).ids, IDX] = sort(descmat(:,1),1);
    % rest: descriptors, sort in same order
    d = descmat(IDX,2:end);
    
    
    % normalize data with hardcoded mean, standarddev.
    if (options.normalize)
        if (options.verbose)
            disp('Scaling data...');
        end
        if (strcmpi(mode, 'OE'))
            r = sOE > 0;
            % subtract mean
            d = d(:,r) - ones(size(d(:,r),1),1)*mOE(:,r);
            % divide by stddev
            d = d./(ones(size(d,1),1)*sOE(:,r));
        elseif(strcmpi(mode, 'CDK'))
            r = sCDK > 0;
            % subtract mean
            d = d(:,r) - ones(size(d(:,r),1),1)*mCDK(:,r);
            % divide by stddev
            d = d./(ones(size(d,1),1)*sCDK(:,r));
        else
           error('Simple descriptor mode not supported. Possible values: OE or CDK.');
        end
            
    end
    % return the result...
    simple.(classe).dsc = d;
end
    
        
    