function [PROPABILITY_OF_SEQUENCE] = viterbi(States, Observations, Initial_state_matrix, Transition_matrix, Emission_matrix, Sequence)
N = length(States);
M = length(Observations);
T1 = zeros(N,M);
T2 = zeros(N,M);
for state = 1:N
   T1(state,1) = Initial_state_matrix(state).*Emission_matrix(state, Sequence(1));
end
disp(T1)
%for j = 2:M
%    for i = 1:N
%       T1(i,j) = MAX();
%       T2(i,j) = MAX();
%    end
%end
