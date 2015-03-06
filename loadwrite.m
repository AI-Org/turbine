function loadwrite(filedir)
% reads all .DAT files from filedir and 
% writes 

  filelist = readdir (filedir);
  
  for ii = 1:numel(filelist)
  %for ii = 1:2
    %if ii == 5
    %  continue;
    %endif
    %ii = 5

    if (regexp(filelist{ii},"^0427.*(.DAT)+$"))
      display(filelist{ii})

      datname = [filedir "/" filelist{ii}];
      [data,header,units] = loadcart2(datname);

      %write Data into a file named fname
      fname = [strsplit(filelist{ii},"."){1,1} ".csv"];
      % delete if such a file name already exists in the current directory
      delete(fname);
      
      % get the stopping columns before write to disk
      [normalstops1, normalstops2, emergencystops1, emergencystops2, warnings1, warnings2] = modifyDecTOBin(data);
      header = [header "," "Normal Stops1" "," "Normal Stops2" "," "Emergency Stops1" "," "Emergency Stops2" "," "Warnings1" "," "Warnings2"];
      data = [data, normalstops1, normalstops2, emergencystops1, emergencystops2, warnings1, warnings2];
      
      %write the header value
      fid = fopen(fname, 'w');
      fprintf(fid, [header '\n']);
      fclose(fid);
           
      % append data to the file fname
      csvwrite(fname, data, '-append');
      
      %clear all the local variables
      clear data;
      clear dname;
      clear fname;
      
    endif
  endfor


end


function [normalstops1, normalstops2, emergencystops1, emergencystops2, warnings1, warnings2] = modifyDecTOBin(data)

    normalstops1  = arrayfun(@convertToBitPositions, data(:,85));
    normalstops2  = arrayfun(@convertToBitPositions, data(:,86));
    emergencystops1 = arrayfun(@convertToBitPositions, data(:,87));
    emergencystops2 = arrayfun(@convertToBitPositions, data(:,88));
    warnings1 = arrayfun(@convertToBitPositions, data(:,89));
    warnings2 = arrayfun(@convertToBitPositions, data(:,90));

end

function bitPosition = convertToBitPositions(datapoint)

    binform = dec2bin(datapoint);
    # reverse the character binary form of the decimal number
    revbinform = fliplr(binform);
    # find the bit position and return it
    bitPosition = getBitPosition(revbinform);

end

function bitPosition = getBitPosition(revbinform)
  bitPosition = 0;
  
  for ii = 1:length(revbinform)

    if(revbinform(1,ii) == '1')
      bitPosition = ii;
      break;
    endif

  endfor

end

