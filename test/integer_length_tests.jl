struct Shout
  shout::String
  start::Int
end
using Random, Test

begin

N = 5

shouts = [Shout(uppercase(randstring(rand(3:5))), rand(1:100)) for k in 1:N]
shoutlimits(s::Shout) = (s.start, s.start + length(s.shout) + 1);
shouttranslate(s::Shout, n) = Shout(s.shout, s.start + n);
q = 60

function shoutlens(R)
    l = 0
    for r in R
        a, b = shoutlimits(r)
        l += b - a
    end
    return l
end

@testset "Integer Length δq=$(δq)" for δq in [0, 2]
    for j in 1:N
        r, s = random_sequence(shouts, q, shoutlimits, shouttranslate, δq)
        ℓ = shoutlens(r)
        @test q - δq ≤ ℓ ≤ q + δq
    end
end

using MotifSequenceGenerator: DeadEndMotifs
@test_throws DeadEndMotifs random_sequence(shouts, 7, shoutlimits, shouttranslate, 0)


end
