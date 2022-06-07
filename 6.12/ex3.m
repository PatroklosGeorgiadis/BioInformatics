clc
% PYGL glycosen phosphorylase L (Homo sapiens chromosome 14)
Liver = getgenbank('NC_000014', 'PARTIALSEQ', [50905217, 50944530],'SequenceOnly','True');
% PYGB glycosen phosphorylase B (Homo sapiens chromosome 20)
Brain = getgenbank('NC_000020', 'PARTIALSEQ', [25248070, 25298012],'SequenceOnly','True');
N = length(Liver);
M = length(Brain);
%p1 determines the number of the current player. When it equals 1, that
%means player 1 is playing, while if it's 2, player 2 is playing
p1 = 1;
while(N>0 || M>0)
    %if both "chromosomes" lengths are 1, then the next player won't be
    %able to split one of the chromosomes in two after they delete the
    %first one. Therefore, they lose and the current player wins
    if (N == 1 && M == 1)
       if(p1 == 1)
        p1 = 2;
       else
        p1 = 1;
       end
       disp("Player "+p1+" wins!"); 
       return
    end
    %destroy one out of the 2 chromosomes
    if(p1 == 1)
        destroyed_chromosome = chromosome_destroy(1);
        p1 = 2;
    else
        destroyed_chromosome = chromosome_destroy(2);
        p1 = 1;
    end
    %SUBJECTED TO CHANGE WITH AN OPPOSITE RESULT
    %if the not deleted chromosome has a length of 1, then it can't be
    %split and the current player loses
    if (N == 1 || M == 1)
        disp("Wrong move! Player "+p1+" wins!"); 
        return
    end
    %checking which chromosome got destroyed and then spliting the other
    %one
    if(destroyed_chromosome == 'N')
        [N, M] = chromosome_split(M);
    else
        [N, M] = chromosome_split(N);
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
       return
    end
end

function [splitA, splitB] = chromosome_split(n)
    disp("Now you need to choose how you will split the other chromosome.");
    disp("The length of this chromosome is: "+n);
    disp("Choose the length of the 1st split chromosome. ");
    splitA = input("Assume that the length of the chromosome you are splitting is equal to n. : ");
    splitA = round(splitA);
    if (splitA >= n || splitA <= 0)
        disp("Error while calculating the length. Try again");
        [splitA, splitB] = chromosome_split(n);
        return
    end
    splitB = n - splitA;
    disp(splitA);
    disp(splitB);
end
