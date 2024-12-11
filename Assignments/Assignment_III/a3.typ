#set par(justify: true)
// #set par(leading:.85em, spacing:1.5em)
// #set par(first-line-indent: 1em)
#show heading.where(level:2): set text(size: 14pt)
#set math.equation(numbering: "(1)")
#set enum(indent: 1.5em, body-indent:1em)
#set heading(numbering: "1.")

#let eps = $epsilon.alt$
#let cov = $"Cov"$
#let ss = "ss"
#let hh = "hh"
#let it = $i t$
#let it1 = $i t 1$
#let itm1 = $i t-1$
#set math.equation(numbering:"(1)")
#let nonum(eq) = math.equation(block: true, numbering: none, eq)

// Dark Mode
// #set page(fill: black)
// #set text(fill: white)

//
// FRONT PAGE

//

#let course(it) = block(smallcaps[#text(size:16pt)[#it]])
#let university(it) = block(smallcaps[#it])
#let title(it) = {
  set par(leading:.5em)
  block(text(size: 30pt)[#it])
  }
#let subtitle(it) = block(text(
  size: 18pt, 
  // style: "italic"
)[#it])
#let author(it) = block(text(size: 18pt)[#it])


#course[Advanced Macroeconomics: Heterogenous Agent  Models]
#university[University of Copenhagen, , fall 2024]
#block(height: 10em)
#block(height: 1em)


#title[Assignment 3:  _Inheritance taxation in HANC with bequests and  endogenous labor supply_]
// #subtitle[Revision 1]

#block(height: .1em)
#author[Daniel Riegels]

// #place(bottom)[ #outline() ]

#pagebreak()

#set page(numbering: "1.")
#counter(page).update(1)


= Introduction

Inheritances play a key role in explaining the long term persistence of wealth inequality in society. For this reason, a much-debated political question is how much we should tax inheritances. Higher inheritance taxes could potentially increase social mobility by redistributing wealth from rich dynasties to poor households. However, taxing inheritances could also influence labor supply, as parental savings and labor decisions could be shaped by their expectations about the ability to transfer wealth to their descendants, while the labor supply decisions of children may adjust based on their anticipated inheritance.

This assignment explores these mechanisms within a heterogeneous-agent (HA) framework, using an extended Aiyagari HANC-model with endogenous labor supply and bequest motives. The aim is to study how inheritance taxation impact household behavior and aggregate outcomes. 



= Model

Below, I will formally state my model. Parts of the model description are replicated directly from the Ayagari-model with endogenous labor supply from Assignment 1, and from the "HANC" and "HANC-gov" notebooks from the GEModelTools repository. I have also found inspiration in the lecture slides on topic 6: Wealth Inequality, and in my own submission of Assignment 1.
// #pagebreak()



== Households

Households are homogeneous _ex ante_, but heterogeneous _ex post_ with respect to their productivity $z_(t)$, their (end-of-period) assets $a_(t)$ and whether they are still alive $s_t$. The distribution of households over idiosyncratic states is denoted $underline(bold(D))_t$ before shocks are realized and $bold(D)_t$ afterwards. Each period households choose their labor supply $ell_t$ and consumption $c_t$ subject to a no-borrowing constraint, $a_(t )>=0$. The real interest rate is $r_t$, the real wage is $w_t$, and real profits are $Pi_t$. Households receive real lumpsum transfers $cal(T)_t$ from the government. Interest-rate income is taxed with the rate $tau_t^alpha in [0,1] $. Labor income is taxed with the rate $tau_t^ell$.

Households live a finite number of periods. $s_t$ indicates whether the household is still alive in period $t$, and $s_t^p$ indicates whether the parent of the household is still alive. When a household dies, they gain utility through the bequest motif $phi.alt(a_(t-1))$. Child households receive an inheritance $b_t$ when their parent dies, corresponding to the terminal wealth of the parent household $a_(t-1)^p$. Inheritances are taxed with the rate $tau_t^b in [0,1]$. 


The household problem is
$
  v_(t) (s_(t), z_(t) , a_(t-1)) 
  = max_(c_(t), ell_(t), a_t)
  &s_(t) [ 
      c_(t)^(1-sigma)/(1-sigma)
      - phi ell_(t)^(1+(1/nu)) / (1 + (1/nu) )
  ] 

  + (1-s_(t)) phi.alt ( tilde(a)_(t-1)) 
  \ &+ beta  EE [v_(t+1)(s_(t+1, )z_(t + 1), a_(t) ) | s_(t), z_(t), a_(t) ]
  
  \ "s.t. " c_(t) + a_(t) &= (1+tilde(r)_t) a_(t-1) + tilde(w)_(t) ell_(t) z_(t) + Pi_(t) + cal(T)_(t) +tilde(b)_(t)
  
  \ log z_(t+1) &= rho_z log z_(t) + psi_(t+1), psi tilde cal(N) (mu_psi, sigma_psi), EE[z_(t)] = 1
  
  \ b_t &= (1-s^p_t) a_(t-1)^p 
  
  \ phi.alt(a_t) &= gamma a_t^(1-eta)/(1-eta)
  \ a_(t) &>=0
$

where $tilde(r)_t = (1-tau_t^a)r_t$, $space tilde(w)_t = (1-tau^b_t)w_t, space$ $tilde(a)_t=(1-tau^b_t)a_t, $ and $tilde(b)_t = (1-tau^b_t)b_t$. The binary random variable $s_t$ is Bernoulli distributed and equal to 1 with a probability $p_t$ which decreases over time. Likewise, $s_t^p$ is equal to 1 with probability $p_t^p$.  
New households enter the economy when old ones die such that a stationary equilibrium can be obtained.
Households observe their parents' wealth $a_(t-1)^p$ and have perfect foresight with regards to wages $w_t$, interest rates $r_t$, taxes $tau^ell_t, tau^r_t, tau^b_t$, profits $Pi_t$, transfers $cal(T)_t$ and survival probabilities $p_t, p_t^p$, such that implicitly 

$ 
  v_t (s_t, z_t, a_(t-1)) = v_t (s_t, z_t, a_(t-1), a_(t-1)^p, {w_t, r_t, tau_t^ell, tau_t^r, tau^b_t, Pi_t, cal(T)_t,  p_t, p_t^p}^infinity_(t=0)) 
$

Aggregate quantities are

$
  L^"hh"_t &= integral ell_t z_t dif bold(D)_t \
  C^"hh"_t &= integral c_t dif bold(D)_t \
  A^"hh"_t &= integral a_t dif bold(D)_t \

$

== Firms

A representative firm rents capital, $K_(t-1)$, and hires labor, $L_t$, to produce goods, with the production function

$
  Y_t = F(Gamma_t, K_(t-1), L_t) =  Gamma _t K^alpha_(t-1) L_t^(1-alpha)
$

Capital depreciates with the rate $delta in (0,1).$ The real rental price of capital is $r_t^K$ and the real wage is $w_t$. Profits are

$
  Pi_t = Y_t - w_t L_t - r_t^K K_(t-1)
$
 
The law of motion for capital is

$
  K_t = (1-delta) K_(t-1) + I_t
$


Profit maximization by

$
  max_(K_(t-1), L_t) Y_t - w_t L_t - r_t^k K_(t-1)
$

implies the standard pricing equations

$
  r_t^k = alpha Gamma _t (K_(t-1) \/ L_t)^(alpha-1) \
  w_t = (1-alpha) Gamma_t (K_(t-1) \/ L_t)^alpha
$

where $r^k_t$ is the rental rate of capital and $w_t$ is the wage rate.

The households own the representative firm in equal shares.



== Government

The government raises taxes from the capital income tax, the labor income tax, and the inheritance tax, and transfers this back to the households as a lump sum transfer. The budget constraint for the government is

$
  cal(T)_t = integral [tau_t^a r_t a_(t-1 ) + tau_t^ell w_t ell_t z_t + (1-s_t)tau^b a_(t-1)] dif bold(D)_t
$


== Market clearing

Market clearing implies

1. Labor market: $L_t = L_t^"hh"$
2. Goods market: $Y_t = C_t^"hh" + I_t$
3. Asset market: $K_t = A_t^"hh"$



== Solving the model

Using the notation

$
  u(c_t) = c_t^(1-sigma)/(1-sigma), quad nu(ell_t) = phi ell^(1+1/nu)/(1+1/nu)
$

the Lagrangian for the household problem is:

$
  cal(L) = EE_0 sum_(t=0)^infinity beta ^t  
  &s_t (u(1+tilde(r)a_(t-1) + tilde(w)_t ell_t z_t + Pi_t + cal(T)_t + tilde(b)_t - a_t)-nu (ell_t)) \
  &+ (1-s_t) phi.alt ((1-tau^b) a_(t-1)) + beta^t lambda_t (a_t - 0)
$

where $lambda_t$ is the Lagrangian multiplier on the borrowing constraint. The first order conditions with regards to savings and labor supply are:

$
 s_t u'(c_t) &= beta EE_t [s_(t+1)  (1+tilde(r)_(t+1)) u'(c_(t+1)) +(1-s_(t+1))(1+tau^b_t) phi.alt ' (tilde(a)_t )] +lambda_t \
  &= p_(t+1) beta (1+tilde(r)_(t+1)) EE_t   [u'(c_(t+1))] +(1-p_(t+1))beta(1+tau^b_t) phi.alt ' (tilde(a)_t ) +lambda_t \
 \ nu'(ell_t) &= s_t tilde(w)_t z_t u'(c_t) 
$

The envelope condition is:

$
  underline(v)_(a,t)(s_t, a_t, z_t) equiv (diff underline(v)_t (s_t, a_t, z_t))/(diff a_t) = EE_t [(1+tilde(r)_(t) )u'(c_(t))] 
$

In the case where the household is unconstrained ($lambda_t = 0$) and still alive ($s_t=1$), the Euler equation is derived using the first order condition and the envelope condition:

$
 u'(c_t) &= p_(t+1) beta underline(v)_(a,t+1) (s_t, a_t, z_t) + (1-p_(t+1))beta(1+ tau^b_t) phi.alt ' (tilde(a)_t )
$

which can be inverted to obtain

$
 c_t &=  [p_(t+1) beta underline(v)_(a,t+1) (s_t, a_t, z_t) + (1-p_(t+1))beta(1+ tau^b_t) phi.alt ' (tilde(a)_t )]^(1/(-sigma))
$

In the case where the household is constrained ($lambda_t !=0$), we set $a_t=0$ and solve for $c_t, ell_t$ using the budget constraint and the labor supply FOC which still holds with equality. In the final case where the household is no longer alive $(s_t=0)$ in period $t$, their wealth is transferred to the child household through inheritance, and the parent household is  removed from the economy.


#pagebreak()
== Stationary equilibrium

In the stationary equilibrium,
1. Quantities $K_ss$ and $L_ss$,
2. prices $r_ss$ and $w_ss$,
3. the level of government transfers $cal(T)_ss$
4. the distribution $bold(D)_ss$ over $s_t$, $z_t$, $a_(t-1)$
5. and the policy functions $a^*_ss, ell^*_ss$ and $c^*_ss$

are such that 

1. Households maximize expected utility
2. Firms maximize profits
3. $bold(D)_ss$ is the invariant distribution implied by the household problem
4. Government balance sheet is satisfied
5. The markets for capital, labor and goods clear.

// $ 
// mat(delim: "[",
//   r_ss - F_K (Gamma_ss, K_ss, L_ss);
//   w_ss - F_L (Gamma_ss, K_ss, L_ss);
//   r_ss - (r_ss^K - delta);
//   A_ss - K_ss; 
//   cal(T)_ss - tau_ss^a r_ss A_ss^hh - tau_ss^ell w_ss L_ss ^hh - tau_ss^b  A_ss^hh S_ss;
//   A_ss - A^hh_ss; 
//   L_ss - L^hh_ss; 
//   A^hh_ss - integral a_ss dif bold(D)_ss;
//   L^hh_ss - integral ell_ss dif bold(D)_ss;
//   underline(bold(D))_ss -  Lambda'_ss Pi'_z Pi'_s underline(bold(D))_ss;
//   a_ss - a^*_ss
// )
// = bold(0)
// $


= Implementation and analysis

In the model specification stated above, the decisions of the child household depends on state variables in the parent household. In particular, at the time of the parent's death (when $s_t^p = 0$), the terminal wealth of the parents $a^p_(t-1)$ enters the budget constraint of the child household. This implies that implementing the model requires a full Monte Carlo-simulation, where individual child households are linked to parent households. Since such a simulation is computationally expensive, it is relevant to investigate whether we can simplify the model such that household decisions do not depend on state variables of other households. 

== Simplifying restrictions
If we introduce two additional restrictions, we can remove the child household's dependency on the parent household's state variables:

$
  a^p_(t-1) &= a_( 0) \
  p_t^p &= p_(t+k)
$ <initwealth>

The first restriction replaces the endogenous inheritance size with a fixed amount, which we equate with the child household's initial wealth. This is a simplistic way to remove the interdependency while still capturing some degree of social heritage, such that households with low initial wealth can expect low inheritance and vice versa. If the economy starts in a stationary equilibrium, the initial wealth distribution will reflect the equilibrium. 

In the second restriction, we set the "age" of the parents to be some fixed amount of periods older than the child household. In a yearly model, we could e.g. set $k=30$. Thus, instead of endogenously keeping track of the parent household's survival chances, we can instead derive it from the survival chances of the child household.

== Deterministic vs. stochastic length of life
Overall, we have options for implementing the survival chances $p_t$. The first option is using a deterministic length of life, for example by setting

$ 
  p_t = s_t = cases(0 quad t=J, 1 quad "o/w") 
$

Alternatively, the chance of still being alive each period $p_t$ could be calibrated using empirical mortality rates.
#footnote[For instance, using data from the 2024 Human Mortality Database:\ https://ourworldindata.org/grapher/annual-death-rate-by-age-group?country=~DNK]



== Analyzing inheritance taxation

To analyze how the size of inheritance taxation affects household behavior and aggregate outcomes, the model can initially be solved with $tau^b = 0$. From this stationary equilibrium, we can compute the transition path to a new equilibrium with a positive $tau^b$, e.g. $tau^b=0.15$ to match the current Danish inheritance tax rate. Then, we can observe how $Y_t$, $L_t$ and $K_t$ changes over the transition path and in the stationary equilibrium. 

In particular it is interesting to observe the effects on $L_t$, where we should expect inheritance taxation to negatively affect the labor supply of parent households, as their expected bequest utility diminishes with the tax. However, child households could be expected to increase their labor supply when we introduce the inheritance tax, since they will have to work more to meet their asset buffer target if they expect less net inheritance – especially when they reach an age where their parents' survival chances start diminishing.

Another object of interest is wealth inequality, which we can compute at each stage of the transition path using e.g. the Gini coefficient or a similar inequality measure. The inheritance tax is expected to lower inequality, as the government can afford higher transfers and wealthy households are less inclined to save. 

In further analysis, interactions between inheritance tax and the labor and capital taxes could be investigated. For instance, we could allow the labor tax to adjust while keeping transfers fixed, and thus perhaps mitigate some of the negative effects on labor supply from the inheritance tax. It is also possible that the behavioral responses to an inheritance tax is stronger if the capital gains tax is low, since the incentives to save could amplify one another.

Under all circumstances, it is obvious that the behavioral response to the inheritance tax depends on the strength of the bequest motif $phi.alt(a_(t-1))$, which is captured in the parameter in my model specification. $gamma$ could perhaps be calibrated to match the empirical size of the ratio between inheritances and consumption levels, although this is likely to differ greatly for different wealth groups, which would require a more elaborate model to capture.













// == Ideas for further extensions:

// The parent's bequest motif $phi.alt(a_(t-1))$ could alternatively be specified using the  _child_'s marginal utility from extra assets. This could capture that parents might have a greater bequest motive if their kids are struggling than if the kids are already well-off.



// // #pagebreak()
// // == Idea: Heterogenous agents in a migrant worker sending country (e.g. Mexico)
// // How does increased migration costs affect the wealth distribution in a migrant worker sending community?
// // - Extend model with costly migration
// // - Analyze the distributional effects of a (permanent) exogenous shock to migration costs


// // Based on entrepreneurial production function (Lec 6)
// // - No need for sticky wages or unions if we assume self-employment
// // - Maybe exchange firm block with direct household (agricultural) production
// // - Remove government?
// // - Add endogenous migration costs decreasing in \# existing migrants

