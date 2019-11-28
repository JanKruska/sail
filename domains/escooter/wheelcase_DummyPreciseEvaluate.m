function [value] = wheelcase_DummyEvaluate(nextObservations, d)
%wheelcase_DummyEvaluate - Dummy PE for testing other parts of SAIL
% Just sum of genome

value = sum(nextObservations,2);