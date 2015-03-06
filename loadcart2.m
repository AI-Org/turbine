function [data,header,units] = loadcart2(filename)
%filename='04272002/04271824.DAT'
%          example usage:
%
%            data=loadcartU('filename.txt');
%
%

%This is the universal CART2 & CART3 data file opener, it detects the file
%type (between CART 2 and 3, and also different types of CART 3, and also
%auto-detects the number of channels and assumes the number of samples to
%be 600 seconds worth

%The first thing to do is to see if this is just the filename, or filename
%+ path and if plus path strip out just the filename

%This is a universal file opener, first determine the file type

%First check for CART 2, which will have a shorter filename
%In the case of CART 2, must first open the co-located HDR

%Read in the HDR file
 
[a,b,c,d,e,f,g,type]=textread(['04272002/CART.HDR'],'%d%s%s%f%f%f%f%s','delimiter',',','headerlines',1);
    
%Now loop through the type column and count everything not 'I' or 'U'
NumChan = 1;
header = [strsplit(b{1,1},"\""){1,2} " (" strsplit(c{1,1},"\""){1,2} ") "];
units = [strsplit(c{1,1},"\""){1,2}];

val1 = [];
val2 = [];
val3 = [];
val4 = [];

for i=2:length(type)
        if (type{i} == '"I"' || type{i} == '"U"')
            %don't count it
        else
            NumChan = NumChan + 1;
            header = [header "," strsplit(b{i,1},"\""){1,2} " (" strsplit(c{i,1},"\""){1,2} ") "];
            units = [units "," strsplit(c{i,1},"\""){1,2}];
            
        end
end
    
        
%Now open the data file and grab the info
fid2=fopen(filename,'r','l');

if(fid2~=-1)
      % Read data
      data=fread(fid2,[NumChan,100*600],'float32')';
      fclose(fid2);
      
end;

%fid3=fopen(filename,'r','l');
%if(fid3~=-1)
      % Read data
 %     dataf=fread(fid3,[length(type),100*600],'float32')';
 %     fclose(fid3);
      
%end;

end;