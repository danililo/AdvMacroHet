#set page(numbering: "1.")
#set par(justify: true, leading: 1em, spacing:2em)
// #set par(first-line-indent: 1em)
#show heading.where(level:2): set text(size: 14pt)

#set math.equation(numbering: "(1)")

#set heading(numbering: "1.")

#let eps = $epsilon.alt$
#let cov = $"Cov"$
#let ss = "ss"
#let hh = "hh"
#let it = $i t$
#let it1 = $i t 1$
#let itm1 = $i t-1$

//
// FRONT PAGE
//

#let course(it) = block(smallcaps[#text(size:16pt)[#it]])
#let university(it) = block(smallcaps[#it])
#let title(it) = block(text(size: 30pt, )[#it])
#let subtitle(it) = block(text(
  size: 18pt, 
  // style: "italic"
)[#it])
#let author(it) = block(text(size: 18pt)[#it])


#course[Advanced Macroeconomics: Heterogenous Agent  Models]
#university[University of Copenhagen, , fall 2024]
#block(height: 10em)
#block(height: 1em)


#title[Assignment 2: _The HANK Model_]
// #subtitle[Revision 1]

#block(height: .1em)
#author[Daniel Riegels]

// #place(bottom)[ #outline() ]

#pagebreak()



#figure(image("dsf.png", width:60%), caption:"DSF vs. H for all five models of the assignment.")

= DSF in the HANK model
The degree of self-finance (DSF) measures how much a policy finances itself. For example, it is often discussed in Danish policy whether reducing income taxes in the highest income bracket ("topskat") can finance itself, since people might decide to work more when facing a lower marginal tax, thus creating a larger tax base for the government. In the case of this assignment, the DSF measures how much of the costs associated with the spending shock that is financed through extra tax revenues from the resulting economic boom.

I find the transition path for three different model instances with $H in {0, 20, 40}$ and compute the DSF of the shock to government spending. Results are shown below.

#figure(table(columns:2, align: right, stroke:none,
[$H$], [DSF],
table.hline(),
[0], [-0.0001],
[20], [0.1060],
[40], [0.3102],
))
We see that the DSF is increasing in $H$. The stimulus creates a boom in the economy, which allows the government to collect extra taxes that partially offset the costs of the spending shock.  Households have perfect foresight and predict that the tax increases they will eventually face in $t>= H$ will be less than the current value of the stimulus, since the costs are partially covered through the additional government revenue in the boom period $t < H$, and since households discount the future.




= Differences between TANK and HANK
In order to solve the TANK model, I implement the household block for constrained and unconstrained households based on the budget constraints, the Euler equation and the formulas for aggregate consumption and aggregate marginal utility.

Consumption is forward looking for the unrestricted household, so I solve it backwards by inverting the Euler-equation:

$
  (c_t^R)^(-sigma) &= beta (1+r_(t+1))(c_(t+1)^r)^(-sigma) \
  <=> c_t^R &= [beta (1+r_(t+1))]^(-1/sigma)c_(t+1)^r \
$

Saving behavior is backwards looking, so I solve it forwards by rewriting the budget constraint:

$ c_t^R + A_t/(1-lambda) &= (1+r_t) A_(t-1)/(1-lambda ) + (1-tau) (Pi_t + w_t L_t^hh) - chi_t 
\ <=>  A_t &= (1+r_t) A_(t-1) + (1-lambda) [ (1-tau) (Pi_t + w_t L_t^hh) - chi_t - c_t^R]
// \ <=> A_(t) &= (1-lambda)/(1+r_(t+1))[ c_(t+1)^R + chi_(t+1) + A_(t+1)/(1-lambda) - (1-tau) (Pi_(t+1) + w_(t+1) L_(t+1)^hh)]

$

To calibrate the model, I only need to identify $beta$, which is achieved by imposing the steady state $c^R_t = c_(t+1)^R$ in the Euler equation, which yields:
$ (c_ss^R)^(-sigma) &= beta(1+r_ss) (c_ss^R)^(-sigma)
\ <=> beta &= 1/(1+r_ss)
$
Having implemented the household block and calibrated the model, I can now compute the DSF. Results are shown below.
#figure(table(columns:2, align: right, stroke:none,
[$H$], [DSF],
table.hline(),
[0], [0.0000],
[20], [0.0000],
[40], [0.0000],
))

The fact that the DSF is zero for all $H$ is explained by the behavior of the unrestricted and the restricted households. Restricted hand-to-mouth households have an MPC of 1, which means they spend the entire extra income in $t=0$ in the same period. Their gains from the extra consumption is perfectly offset by the loss they suffer in $t=H$.


On the other hand, the unrestricted households smooth consumption perfectly. They predict that the behavior of the restricted households will cause a short term crash to the economy at time $H$ and increases savings gradually over $t<H$ to perfectly smooth across the crash. This also explains their willingness to purchase all the extra bonds issued by the government in $t<=H$.  Thus their consumption path is completely unaffected by the stimulus.

The behavior observed in the TANK model arises from the fact that while the share of hand-to-mouth households $lambda$ can be chosen to match a realistic contemporary MPC, it cannot simultaneously capture subsequent intertemporal MPCs (iMPCs). This can however be obtained in a TANK model, where most households will spend out of the income from the unexpected shock across several years, generating a fiscal multiplier that is above 1 from the deficit financed shock. 


= HANK with low taxes 

I re-run the HANK-model with $tau_ss = 0.005$ and compute the DSF again. Results are shown below.

#figure(table(columns:2, align: right, stroke:none,
[$H$], [DSF],
table.hline(),
[0], [0.0001],
[20], [0.0249],
[40], [0.0837],
))

Compared to the original HANK model, a lower $tau_ss$ results in a lower DSF. This can be explained by the mechanical effect of the government gaining less revenue from the boom, as well as the behavioral effect of households predicting that the government will eventually have to increase lump sum taxes more, since their benefit from the boom is smaller – causing households to spend less during the boom.

= HANK with an active central bank.
Again I find the transition paths for the HANK model with $phi.alt_Y = .5 $ such that the central bank is active. Results are shown below.


#figure(table(columns:2, align: right, stroke:none,
[$H$], [DSF],
table.hline(),
[0], [0.0055],
[20], [0.0997],
[40], [0.1271],
))

Again we see that the DSF is smaller compared to the original HANK model. When the central bank is active, the size of the boom is dampened by increasing interest rates, and thus the amount of self-financing extra government revenue is smaller. 

The result is exactly the same if I re-run the model with a higher $kappa$. A higher $kappa$ implies more flexible prices and thus more inflation as a result of the stimulus, but this has no effect in this particular model, since the entire economy is in real terms. If the government issued nominal bonds instead of real bonds, the size of $kappa$ would come into play and would interplay with the active Central Bank in determining how much interest rates would need to increase to combat inflation, and thus how much of the self-financing effect of the stimulus that would be eaten up by the dampening of the boom.