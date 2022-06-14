function [PROPABILITY_OF_SEQUENCE] = viterbi(States, Observations, Initial_state_matrix, Transition_matrix, Emission_matrix, Sequence)
    N = length(States);
    M = length(Observations);
    T1 = zeros(N,M);
    T2 = zeros(N,M);
    k = zeros(N,M);
    %determine each hidden state's possibility for the first observation
    for state = 1:N
       T1(state,1) = Initial_state_matrix(state, 1).*Emission_matrix(state, Sequence(1));
    end
    %determine each hidden state's possibility for the rest of the observations
    for j = 2:M
        for i = 1:N
           for q = 1:N
              k(q, j) = T1(q,j-1)*Transition_matrix(q,i)*Emission_matrix(i,j);
           end
           %k is the current state's most likely prior state (represented by number)
           max = argmax(k(1:N,j));
           T1(i,j) = T1(max,j-1)*Transition_matrix(max,i)*Emission_matrix(i,j);
           T2(i,j) = max;
        end
    end
    k = argmax(T1(1:2,j));
    for o = M:-1:1
        PROPABILITY_OF_SEQUENCE(o) = States(k);
        k = T2(k,o);
    end
end

%function to find the index of the largest element in a matrix
function y = argmax(x)
  [~,y] = max(x, [], 'all', 'linear');
end
