function num = first_output(var)
% FIRST_OUTPUT     Find the first SPINS output in the working directory
%
%  Usage:
%    num = first_output()
%    num = first_output('rho')
%
%  Inputs:
%    - one optional argument. A string of the field name to use
%
%  Outputs:
%    'num' - the number of the first output
%
%  David Deepwell, 2016

    % use the u field to find the smallest output number
    if exist('var','var')
        files = dir([var,'.*']);
    else
        files = dir('u.*');
    end
    nfiles = length(files);
    table = struct2dataset(files);

    % find all extension numbers
    outputs = zeros(1,nfiles);
    for ii = 1:nfiles
        filename = table{ii,1};
        [~, dot_num] = strtok(filename, '.');
        if strcmp(dot_num, '.dump')
            outputs(ii) = NaN;
        else
            outputs(ii) = str2num(dot_num(2:end));
        end
    end
    num = min(outputs);
end