function [data] = loadcarthdr2(filename)
% loadcart3hdr  load CART .hdr files for cart 3 turbine
% [data] = loadcart(filename)
%
%          filename is the name of the .hdr file to be loaded
%          if no filename is stated, "CART3 header file.hdr" is used
%
%          example usage:
%
%            data=loadcart3hdr('filename.hdr');
%
%          loads the file 'filename.hdr' into data
%          data=[name units offset slope]

% This is the new universal HDR file opener and will work differently than
% previous versions, instead of being passed in the HDR file name, it will
% be passed in the filename of the data file you are interested in and will
% either get it from there (CART 3) or else from the assumed HDR file
% (CART.HDR)

%The first thing to do is to see if this is just the filename, or filename
%+ path and if plus path strip out just the filename

    #[a,b,c,d,e,f,g,h]=textread([path 'CART.HDR'],'%d%q%q%f%f%f%f%q','delimiter',',','headerlines',1);
[a,b,c,d,e,f,g,h]=textread(['04272002/CART.HDR'],'%d%s%s%f%f%f%f%s','delimiter',',','headerlines',1);
j=1;
    for i=1:length(a)
      if(not(strcmp(h(i),'I') | strcmp(h(i),'U')))
          data(j,:)=[b(i) c(i) d(i) e(i)];
          j=j+1;
      end
    end
