function [PROPABILITY_OF_SEQUENCE] = viterbi(States, Observations, Initial_state_matrix, Transition_matrix, Emission_matrix, Sequence)
    N = length(States);
    M = length(Observations);
    T1 = zeros(N,M);
    T2 = zeros(N,M);
    for state = 1:N
       T1(state,1) = Initial_state_matrix(state).*Emission_matrix(state, Sequence(1));
    end
    for j = 2:M
        for i = 1:N
           k = mod(argmax(T1(i:N,j-1)), 2);
           if k == 0
               k = 2;
           end
           T1(i,j) = T1(k,j-1)*Transition_matrix(k,i)*Emission_matrix(i,j);
           T2(i,j) = k;
        end
    end
    disp(T1)
end

%function to find the index of the largest element in a matrix
function y = argmax(x)
  [~,y] = max(x, [], 'all', 'linear');
end
