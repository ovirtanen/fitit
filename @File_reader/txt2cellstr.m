function [c] = txt2cellstr(~, fid, eol)
%TXT2CELLSTR Reads a txt file to cell array of strings.
%   [c] = txt2cellstrfid,eol) where fid is a file indentifier and eol the
%   end of line character in the text file, reads the text file into a cell
%   array of strings c where each cell in c corresponds to one row in the
%   text file. 
%
% Windows eol: [char(13) char(10)]
% Unix eol: char(10)
%

% Copyright (c) 2015, Otto Virtanen
% All rights reserved.

s = transpose(fread(fid, 'uchar=>char'));
s = strrep(s, eol, char(10));

if(s(end) ~= eol) % add eol to the end if missing
    
    s = [s eol];
    
end % if

i = find(s == char(10));

si = [1 i(1:end-1)+1];  % start indices of rows

ei = i-1;               % end indices of rows

c = cell(size(i'));     % initialize for speed

for j = 1:length(i)
    
    sub = s(si(j):ei(j));
    
    if(isempty(sub))
        sub = '';       % otherwise will give 1x0 char
    end % if
    
    c{j} = sub;
    
end % for

end