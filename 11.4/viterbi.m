function [PROPABILITY_OF_SEQUENCE] = viterbi(States, Observations, Initial_state_matrix, Transition_matrix, Emission_matrix, Sequence)
    N = length(States);
    M = length(Observations);
    T1 = zeros(N,M);
    T2 = zeros(N,M);
    %determine each hidden state's possibility for the first observation
    for state = 1:N
       T1(state,1) = Initial_state_matrix(state).*Emission_matrix(state, Sequence(1));
    end
    %determine each hidden state's possibility for the rest of the observations
    for j = 2:M
        k = argmax(T1(1:N,j-1));
        %k is the state's most likely prior state (represented by number)
        for i = 1:N
           T1(i,j) = T1(k,j-1)*Transition_matrix(k,i)*Emission_matrix(i,j);
           T2(i,j) = k;
        end
    end
    disp(T1)
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
