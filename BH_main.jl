#a JULIA program for a full diagonalizaiton 
# for an OBC chain in 1D


#Number of particles
const N = 4 
#Number of sites
const M = 4 

include("BH_basis.jl")
include("BH_sparseHam.jl")

basis = CreateBasis(N,M)

#Hamiltonian parameters
T = -1.0

f = open("energy.dat","w")
for U=1.0:100.0
	
	#Create the Hamiltonian
	SparseHam = CreateSparseHam(basis,T,U)

	#http://docs.julialang.org/en/release-0.3/stdlib/linalg/?highlight=lanczos
	d = eigs(SparseHam, nev=1, which=:SR) 
	#d = eigvals(FullHam)
	#println(U," ",d[1])
	write(f,join((U,d[1][1])," "), "\n")
	flush(f)

end
close(f)

#SparseHam = sparse(FullHam)
#println(SparseHam)
#
#d2 = eigs(SparseHam)
#println(d2)
