function [ output_args ] = matf( input_args )
% Load mat file into single variable
    aux=load(input_args);
    names=fieldnames(aux);
    output_args=aux.(names{1});


end

