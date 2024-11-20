import numpy as np
import numba as nb

from GEModelTools import lag, lead
   
@nb.njit
def production(par,ini,ss,L,w,pi,Y,NKPC_res, profits):
    Y[:] = L
    pi_p = lead(pi,ss.pi)
    NKPC_res[:] = pi*(1+pi) - (par.kappa*(w - 1/par.mu) + par.beta*pi_p*(1+pi_p))
    profits[:] = Y - w*L


@nb.njit
def central_bank(par,ini,ss,r,Y):
    r[:] = ss.r + par.phi_Y*(Y - ss.Y)


@nb.njit
def government(par,ini,ss,Taxes,B,w,L,r,gov_budget,epsT,LT,profits):

    inc_taxes_ss = par.tau*(ss.w*ss.L + ss.profits)

    for t in range(par.T):
        
        B_lag = B[t-1] if t > 0 else ini.B

        inc_taxes = par.tau*(w[t]*L[t] + profits[t])

        if t <= par.H:
            LT[t] = ss.LT - epsT[t]
        else:
            LT[t] = ss.LT - (inc_taxes - inc_taxes_ss) + (B_lag - ss.B)  

        Taxes[t] = LT[t] + inc_taxes
        gov_budget[t] = Taxes[t] + B[t] - ((1+r[t])*B_lag)




@nb.njit
def TA_HHs(par,ini,ss,w, L, profits, C_hh, A_hh, MUC_hh, r, LT, C_R, C_HtM):

    if par.HH_type == 'TANK':

        # You need to write code here for the following variables:
        # C_R, C_HtM, C_hh, A_hh, MUC_hh
        # Using information specificed in section 4 of the assignment 
        # When you do this remember that the variables are inputs into this function (TA_HHs)
        # and are arrays of length T (so don't write C_R = X, but C_R[:] = X, or C_R[t] = X depending on application)

        # I assume L_hh = L. At least holds in ss.

        # Use ss values for terminal periods and then compute backwards

        for k in range(par.T): # Loop backwards
            t = par.T - k - 1
            if t == par.T - 1:
                C_R[t] = ss.C_R
            else:
                C_R[t] = (par.beta*(1+r[t+1]) * C_R[t+1]**(-par.sigma)) ** (-1/par.sigma) # Inverse Euler, Eq 18
        
        A_hh[-1] = ss.A_hh # Hack: Use ss value for terminal period as our t-1 value as well
        for t in range(par.T-1): # Loop forwards 
                A_hh[t] = (
                    (1 + r[t]) * A_hh[t-1]
                    + (1-par.sHtM) * (
                        (1-par.tau) * (profits[t] + w[t] * L[t])
                        - LT[t] - C_R[t])
                )

        # Eq 17 
        C_HtM[:] = (1-par.tau) * (profits + w * L) - LT

        # Eq 19
        C_hh[:] = (1-par.sHtM) * C_R + par.sHtM * C_HtM

        # Eq "20" MUC
        MUC_hh[:] = (1-par.sHtM) * C_R**(-par.sigma) + par.sHtM*C_HtM**(-par.sigma)

@nb.njit
def labor_supply(par,ini,ss,L,w,MUC_hh,labor_supply_res):
    
    labor_supply_res[:] = par.varphi*L**par.nu - (1-par.tau)*w*MUC_hh


@nb.njit
def market_clearing(par,ini,ss,B,Y,C_hh,A_hh,A,clearing_A,clearing_Y):
        
    # a. aggregates
    A[:] = B

    # b. market clearing
    clearing_A[:] = A-A_hh
    clearing_Y[:] = Y-C_hh 
    