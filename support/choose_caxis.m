function [colaxis, cmap] = choose_caxis(var, data)
%  CHOOSE_CAXIS  choose the colorbar limits and colormap of data based on the field 'var'
%
%  Inputs:
%    var   - field name
%    data  - field data
%
%  Outputs:
%    coloaxis  - 2 element vector of colorbar limits
%    cmap      - colormap
%
%  David Deepwell, 2015

% remove extra information from the plotted field
if strncmp(var, 'Mean', 4)
    var = strsplit(var, 'Mean ');
    var = var{end};
elseif strncmp(var, 'SD', 2)
    SD = true;
    var = strsplit(var, 'SD ');
    var = var{end};
elseif strncmp(var, 'Scaled SD', 9)
    SD = true;
    var = strsplit(var, 'Scaled SD ');
    var = var{end};
end

% find value of data that is closest to zero
climits = [min(data(:)) max(data(:))];
c0 = min(abs(climits));

% choose color axis limits and colormap based on the field name
cmap = 'darkjet';    % the default colormap
if exist('SD', 'var')
    colaxis = [0 1]*max(data(:));
    cmap = 'hot';
elseif ~isempty(strfind(var, 'Dye')) || strcmpi(var, 'Tracer')
    colaxis = [-1 1];
elseif strcmp(var, 'Density') && c0 < 0
    colaxis = [-1 1]*max(abs(data(:)));
elseif strcmpi(var, 'U') || strcmpi(var, 'V') || strcmpi(var, 'W')
    colaxis = [-1 1]*max(abs(data(:)));
elseif strcmp(var, 'KE')
    colaxis = [0 1]*max(data(:));
    cmap = 'hot';
elseif strcmp(var, 'Ri')
    colaxis = [0 5];
else
    colaxis = 'auto';
end 
