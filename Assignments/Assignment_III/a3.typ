#set math.equation(numbering:"(1)")
#let nonum(eq) = math.equation(block: true, numbering: none, eq)

= Assignment 3


== Idea 2: Distributional effects of inheritance taxation


=== Main question: How would a higher inheritance tax affect labor supply?
- Parents might work less if they can pass on less of their ultimate savings to their loved ones
- Kids might work more if they do not expect to receive as much from their parents.
- Interesting to study in a HA context:
  - Distributional effects
  - Higher MPCs are relevant for behavior when inhering large amounts of money.



=== Model
- Based on Ayagari-model with endogenous labor supply – extended with inheritance and bequest motives
==== Household block:
$
  v_t (z_t, a_(t-1)) = 
  max_(c_t, ell_t)
  EE [sum_(t=0)^T 
      beta^t (s_(t, i) 
      (c_t^(1-sigma)/(1-sigma) 
      - phi ell_t^(1+(1/nu)) / (1 + (1/nu)
  
  )) + (1-s_(t,i)) phi.alt ( tilde(a)_(t-1)) ) ] \
$
#nonum($
  "s.t. " c_t + a_t &= (1+tilde(r)) a_(t-1) + tilde(w)_t ell_t z_t + Pi_t + cal(T)_t +tilde(b)_t \
  log z_(t+1) &= rho_z log z_t + psi_(t+1), psi tilde cal(N) (mu_psi, sigma_psi), EE[z_t] = 1 \
  a_t &>=0
  


$)

where I have introduced the variables (in addition to the definitions used in assignment 1):
- $s_(t,i)$: a random variable indicating the household is still  alive in time $t.$ 

- $s_(t,p)$: a random variable indicating that the last parent of the household is still alive
-  $tilde(a)_(t-1) = (1-tau^b)a_(t-1)$: the taxed fortune left behind for relatives
-  $phi.alt(tilde(a)_(t-1))$: a bequest motif providing utility when dying in period $t$ from leaving wealth behind. 
- $tilde(b)_t = (1-tau^b)b_t$: the taxed inheritance received at the time of last parent's death, where

$ 
  b_t = cases(
    a_(t-1 ,p) quad &s_(t,p)= 0,
    0 quad  &s_(t, p) = 1
  )
$

The chance of still being alive in a given period $EE(s_(t,i) | t)$ can be calibrated using empirical mortality rates. 

In the full version of the model, every household is linked to a parent household in a 1-to-1 relationship. Numerically solving this would require a full Monte Carlo-simulation of individual households. However, an alternative approach can simplify implementation by making a couple of extra assumptions.

First, we could replace the endogenous link between parents' wealth and kids' inheritance  by assuming:
$
  a_(t-1, p) = a_(0, i)
$<initwealth>

By equating the inheritance to the household's initial wealth $a_(0,i)$ we model social heritage in a simplistic way, such that households with low initial wealth can expect low inheritance and vice versa. 

Second, we could assume e.g.
$ EE(s_(t, p) | t) = EE(s_(t+30 ,i) | t) $

or in words: We assume that the chance of a parent still being alive at any given time is the same as the chance that a kid is still alive 30 years later. Or put more simply: We assume parents are thirty years older than their kids.




=== Issues
- The current specification actually provides bequest incentives in every period after death, not just at the time of death
- Same thing goes for the inheritance

 

The rest of the model is identical to the Aiygari model with endogenous labour supply:



=== Extensions:
- $phi.alt$ could be child's marginal utility from extra assets. This could capture that parents might have a greater bequest motive if their kids are struggling than if the kids are already well-off.
- We could model retirement in some way to avoid the unrealistic behavior that people have labour income all life. Maybe let $phi$ depend negatively on $t$?



=== Notes
- Based on Aiyagari model with bequest motives
- Extend household block with a chance that last parent dies each period – with increasing probability over time
- Death of final parent triggers a taxed transfer of parents' wealth
- Wealth of parent is for simplicity set to (some fraction?) of the initial wealth level of the household?
  - Cannot be a copy of current wealth $=>$ this could result in saving to increase value of future inheritence from parents, which is not realistic
- More elaborate Monte Carlo-based models could maybe model individual linked households across several generations



#pagebreak()
== Idea: Heterogenous agents in a migrant worker sending country (e.g. Mexico)
How does increased migration costs affect the wealth distribution in a migrant worker sending community?
- Extend model with costly migration
- Analyze the distributional effects of a (permanent) exogenous shock to migration costs


Based on entrepreneurial production function (Lec 6)
- No need for sticky wages or unions if we assume self-employment
- Maybe exchange firm block with direct household (agricultural) production
- Remove government?
- Add endogenous migration costs decreasing in \# existing migrants

