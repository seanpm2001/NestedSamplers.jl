using NestedSamplers: default_update_interval

@testset "default helpers" begin
    @test default_update_interval(Proposals.Uniform()) == 1.5
    @test default_update_interval(Proposals.RWalk()) == 3.75
    @test default_update_interval(Proposals.RWalk(walks=10)) == 1.5
    @test default_update_interval(Proposals.RStagger()) == 3.75
    @test default_update_interval(Proposals.RStagger(walks=10)) == 1.5
    # @test default_update_interval(Proposals.Slice()) == 0.9 * ndims * 5   ## check what default to set for ndims?
    # @test default_update_interval(Proposals.Slice(slices=10)) == 0.9 * ndims * 10  ## check what default to set for ndims?
end

spl = Nested(3, 100)
@test spl.proposal isa Proposals.Uniform
@test spl.update_interval == 150
@test spl.enlarge == 1.25
@test spl.min_ncall == 200
@test spl.active_us == spl.active_points == zeros(3, 100)
@test spl.active_logl == zeros(100)


expected = """
Nested(ndims=3, nactive=100, enlarge=1.25, update_interval=150)
  bounds=Ellipsoid{Float64}(ndims=3)
  proposal=NestedSamplers.Proposals.Uniform
  logz=-1.0e300
  log_vol=-4.610166019324897
  H=0.0"""
@test sprint(show, spl) == expected

spl = Nested(10, 1000)
@test spl.proposal isa Proposals.RWalk
@test spl.update_interval == 3750

## spl = Nested(25, 1500)
## @test spl.proposal isa Proposals.Slice
## @test spl.update_interval ==    ## decide this once default for ndims is set!
