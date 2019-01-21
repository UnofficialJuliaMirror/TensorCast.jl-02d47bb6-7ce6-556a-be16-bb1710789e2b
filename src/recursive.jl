
# using .RecursiveArrayTools

# import TensorCast: recursive_glue

using RecursiveArrayTools

@inline function recursive_glue(A::AbstractArray{IT,N}, code::Tuple) where {IT,N}
    gluecodecheck(A, code)
    if code == (:,*)
        VectorOfArray(A)
    elseif code == (*,:)
        transpose(VectorOfArray(A))
    elseif count(isequal(*), code) == 1 && code[end] == (*)
        VectorOfArray(A)
    elseif iscodesorted(code)
        flat = VectorOfArray(vec(A))
        finalsize = (size(first(A))..., size(A)...)
        reshape(flat, finalsize)
    else
        error("can't glue code = $code with VectorOfArray")
    end
end
