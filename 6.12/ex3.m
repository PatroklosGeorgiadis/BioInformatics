clc
% PYGL glycosen phosphorylase L (Homo sapiens chromosome 14)
Liver = getgenbank('NC_000014', 'PARTIALSEQ', [50905217, 50944530],'SequenceOnly','True');
% PYGB glycosen phosphorylase B (Homo sapiens chromosome 20)
Brain = getgenbank('NC_000020', 'PARTIALSEQ', [25248070, 25298012],'SequenceOnly','True');
N = length(Liver);
M = length(Brain);
p1 = 1;
while(N~=0 || M~=0)
    if(p1 == 1)
        destroyed_chromosome = chromosome_destroy(1);
        p1 = 2;
    else
        destroyed_chromosome = chromosome_destroy(2);
        p1 = 1;
    end
    if(destroyed_chromosome == 'N')
        N = 0;
        chromosome_split(M)
    else
        chromosome_split(N)
        M = 0;
    end
end
%disp(Brain);

function [pick] = chromosome_destroy(num)
    x = input("Player "+num+", choose which chromosome to destroy: N or M? ", 's');
    if(x == 'N' || x == 'n')
       pick = 'N'; 
    elseif(x == 'M' || x == 'm')
       pick = 'M';
    else
       pick = chromosome_destroy(num);
    end
end

function chromosome_split(I)
    disp("Now you need to choose how you will split the other chromosome.");
    disp("Choose the length of the 1st split chromosome. ");
    x = input("Assume that the length the chromosome you are splitting is equal to n. : ", 's');
    
end
