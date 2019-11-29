function [value] = escooter_DummyPreciseEvaluate(nextObservations, d)
%escooter_DummyPreciseEvaluate - Dummy PE for testing other parts of SAIL
% Just sum of genome

value = sum(nextObservations,2);