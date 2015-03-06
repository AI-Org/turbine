function Namelist = CartNamesU(filename)

%data = loadcarthdrU(filename);
data = loadcarthdr2(filename);
Namelist(:,2) = data(:,1);
for i = 1:size(Namelist,1)
    Namelist{i,1} = i;
    if(length(Namelist{i,2})>19)
        Namelist{i,2} = Namelist{i,2}(1:19);
    end
end