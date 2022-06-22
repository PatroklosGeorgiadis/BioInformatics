clc
clear
% PYGL glycosen phosphorylase L (Homo sapiens chromosome 14)
Liver = getgenbank('NC_000014', 'PARTIALSEQ', [50905217, 50944530],'SequenceOnly','True');
% PYGB glycosen phosphorylase B (Homo sapiens chromosome 20)
Brain = getgenbank('NC_000020', 'PARTIALSEQ', [25248070, 25298012],'SequenceOnly','True');
N = length(Liver);
M = length(Brain);
%p1 determines the number of the current player. When it equals 1, that
%means player 1 is playing, while if it's 2, player 2 is playing
player = 1;
disp("Game Started! Player 1 will now take their turn and delete one of the following chromosomes,");
disp("then split the other one in two parts. After that, Player 2 will follow by repeating the same");
disp("actions as Player 1, and so on. The player that deletes the last nucleod wins!");
disp("Warning: You must be able to split the non-deleted chromosome, otherwise you lose");
while(N>0 || M>0)
    %if both "chromosomes" lengths are 1, then the next player won't be
    %able to split one of the chromosomes in two after they delete the
    %first one. Therefore, they lose and the current player wins
    displayer("Chromosome N: " + Liver);
    displayer("Chromosome M: " + Brain);
    if (N == 1 && M == 1)
       player = change_player(player);
       disp("Player "+player+" wins!"); 
       return
    end
    %destroy one out of the 2 chromosomes
    destroyed_chromosome = chromosome_destroy(player);
    player = change_player(player);
    %checking which chromosome got destroyed and then spliting the other
    %one
    if(destroyed_chromosome == 'N')
        %if the not deleted chromosome has a length of 1, then it can't be
        %split and the current player loses
        if (M == 1)
            disp("Wrong move! Player "+player+" wins!"); 
            return
        end
        [N, M] = chromosome_split(M);
        Liver = Brain(1:N);
        Brain = Brain((N+1):end);
    else
        %again, if the not deleted chromosome has a length of 1, then it can't be
        %split and the current player loses
        if (N == 1)
            disp("Wrong move! Player "+player+" wins!"); 
            return
        end
        [N, M] = chromosome_split(N);
        Brain = Liver((N+1):end);
        Liver = Liver(1:N);
    end
end

%function to change the current player
function [player] = change_player(p)
    if(p == 1)
        player = 2;
       else
        player = 1;
    end
end

%function to delete one of the two chromosomes
function [pick] = chromosome_destroy(num)
    x = input("Player "+num+", choose which chromosome to destroy: N or M? ", 's');
    if(x == 'N' | x == 'n')
       pick = 'N'; 
    elseif(x == 'M' | x == 'm')
       pick = 'M';
    else
       pick = chromosome_destroy(num);
       return
    end
end

%function to split the second chromosome into 2 not empty chromosomes
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
end

%displaying function for long chromosomes
function displayer(text)
    L = strlength(text);
    text = char(text);
    while (L > 15000)
        disp(text(1:15000));
        text = text(15001:end);
        L = L - 15000;
    end
    disp(text);
end
