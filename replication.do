clear 

import excel "/Users/dddavis/Dropbox/Project Disclosure Experiment/analysis/dataStata.xlsx", sheet("all") firstrow
//import excel "/Users/okorenok/Dropbox/Project Disclosure Experiment/analysis/dataStata.xlsx", sheet("all") firstrow

//Table 3 dummies


// buyer dummy
gen buyerD = (session<7)
// bonus dummy
gen bonusD = (Bonus>0)

// begining dummy (first 7 periods)
gen beg_D = ((Period>0)&(Period<8))|((Period>15)&(Period<23))|((Period>30)&(Period<38))

// new Group variable for clusters 
gen nGroup = Group if session ==1
replace nGroup = Group +5 if session ==2 
replace nGroup = Group +10 if session ==3 
replace nGroup = Group +16 if session ==4
replace nGroup = Group +21 if session ==5
replace nGroup = Group +26 if session ==6
replace nGroup = Subject if session ==7
replace nGroup = Subject +14 if session ==8

// Disclosure dummies
// full disclosure:
gen full_D = (Treatment==1)
gen full_13D = (Treatment==1)&(BasicValue==13)
gen full_9D = (Treatment==1)&(BasicValue==9)
gen full_6D = (Treatment==1)&(BasicValue==6)
// partial disclosure: 
gen part_D = (Treatment==2)
gen part_11D = (Treatment==2)&((BasicValue==13)|(BasicValue==9))
gen part_6D = (Treatment==2)&(BasicValue==6)
// no disclosure:
gen none_D = (Treatment==3)


// Table 3 dummies
gen full_13_uninf_D = full_13D*(infD==0)
gen full_9_uninf_D = full_9D*(infD==0)
gen full_6_uninf_D = full_6D*(infD==0)
gen part_11_uninf_D = part_11D*(infD==0)
gen part_6_uninf_D = part_6D*(infD==0)
gen none_uninf_D = none_D*(infD==0)
gen full_13_inf_D = full_13D*(infD==1)
gen full_9_inf_D = full_9D*(infD==1)
gen full_6_inf_D = full_6D*(infD==1)
gen part_11_inf_D = part_11D*(infD==1)
gen part_6_inf_D = part_6D*(infD==1)
gen none_inf_D = none_D*(infD==1)


gen full_13_uninf_beg_D = full_13_uninf_D*beg_D
gen full_9_uninf_beg_D = full_9_uninf_D*beg_D
gen full_6_uninf_beg_D = full_6_uninf_D*beg_D
gen part_11_uninf_beg_D = part_11_uninf_D*beg_D
gen part_6_uninf_beg_D = part_6_uninf_D*beg_D
gen none_uninf_beg_D = none_uninf_D*beg_D

gen full_13_inf_beg_D = full_13_inf_D*beg_D
gen full_9_inf_beg_D = full_9_inf_D*beg_D
gen full_6_inf_beg_D = full_6_inf_D*beg_D
gen part_11_inf_beg_D = part_11_inf_D*beg_D
gen part_6_inf_beg_D = part_6_inf_D*beg_D
gen none_inf_beg_D = none_inf_D*beg_D


gen dev_exp = BestOffer - 13*full_13D - 9*full_9D - 6*full_6D-11*part_11D-6*part_6D - 9.33*none_D


// Table 4 dummies 
gen a_uninf_D = (infD==0)*(((BestOffer<6)&((full_6D==1)|(part_6D==1)))|((BestOffer<9)&(full_9D==1))|((BestOffer<9.33)&(none_D==1)))
gen b_uninf_D = (infD==0)*((a_uninf_D==0)&(((BestOffer<7.5)&((full_6D==1)|(part_6D==1)))|((BestOffer<10)&(full_9D==1))|((BestOffer<10)&(none_D==1))))
gen c_uninf_D = (infD==0)*((a_uninf_D==0)&(b_uninf_D==0)&((full_6D==1)|(part_6D==1)|(full_9D==1)|(none_D==1)))
gen d_uninf_D = (infD==0)*((BestOffer<10)&((full_13D==1)|(part_11D==1)))
gen e_uninf_D = (infD==0)*((d_uninf_D==0)&(((BestOffer<=11)&(part_11D==1))|((BestOffer<=13)&(full_13D==1))))
gen f_uninf_D = (infD==0)*((d_uninf_D==0)&(e_uninf_D==0)&((part_11D==1)|(full_13D==1)))

gen a_inf_D = (infD==1)*(((BestOffer<6)&((full_6D==1)|(part_6D==1)|((Treatment==3)&(BasicValue==6))))|((BestOffer<9)&((full_9D==1)|((Treatment==3)&(BasicValue==9))|((Treatment==2)&(BasicValue==9)))))
gen b_inf_D = (infD==1)*((a_inf_D==0)&(((BestOffer<7.5)&((full_6D==1)|(part_6D==1)|((Treatment==3)&(BasicValue==6))))|((BestOffer<10)&((full_9D==1)|((Treatment==3)&(BasicValue==9))|((Treatment==2)&(BasicValue==9))))))
gen c_inf_D = (infD==1)*((a_inf_D==0)&(b_inf_D==0)&((full_6D==1)|(part_6D==1)|(full_9D==1)|((Treatment==3)&(BasicValue==6))|((Treatment==3)&(BasicValue==9)|((Treatment==2)&(BasicValue==9)))))
gen d_inf_D = (infD==1)*((BestOffer<10)&((full_13D==1)|((Treatment==2)&(BasicValue==13))|((Treatment==3)&(BasicValue==13))))
gen e_inf_D = (infD==1)*((d_inf_D==0)&((BestOffer<=13)&((full_13D==1)|((Treatment==2)&(BasicValue==13))|((Treatment==3)&(BasicValue==13)))))
gen f_inf_D = (infD==1)*((d_inf_D==0)&(e_inf_D==0)&(((Treatment==2)&(BasicValue==13))|(full_13D==1)|((Treatment==3)&(BasicValue==13))))


gen a_uninf_beg_D = a_uninf_D*beg_D
gen b_uninf_beg_D = b_uninf_D*beg_D 
gen c_uninf_beg_D = c_uninf_D*beg_D 
gen d_uninf_beg_D = d_uninf_D*beg_D 
gen e_uninf_beg_D = e_uninf_D*beg_D 
gen f_uninf_beg_D = f_uninf_D*beg_D 

gen a_inf_beg_D = a_inf_D*beg_D  
gen b_inf_beg_D = b_inf_D*beg_D
gen c_inf_beg_D = c_inf_D*beg_D
gen d_inf_beg_D = d_inf_D*beg_D
gen e_inf_beg_D = e_inf_D*beg_D
gen f_inf_beg_D = f_inf_D*beg_D

// Table 5 dummies
// disclosure*information dummy
gen part_uninf_D = part_D*(infD==0)
gen full_uninf_D = full_D*(infD==0)
gen part_inf_D = part_D*(infD==1)
gen full_inf_D = full_D*(infD==1)

// disclosure*information*begining dummy
gen part_uninf_beg_D = part_uninf_D*beg_D
gen full_uninf_beg_D = full_uninf_D*beg_D
gen part_inf_beg_D = part_inf_D*beg_D
gen full_inf_beg_D = full_inf_D*beg_D

// Automated dummies 
gen bb_uninf_D = b_uninf_D+a_uninf_D
gen bb_inf_D = b_inf_D+a_inf_D
gen bb_uninf_beg_D = bb_uninf_D*beg_D 
gen bb_inf_beg_D = bb_inf_D*beg_D 


// *****************************************************************************
// *****************************************************************************
// TABLE 3
// *****************************************************************************
// *****************************************************************************


reg dev_exp full_6_uninf_D part_6_uninf_D full_9_uninf_D none_uninf_D part_11_uninf_D full_13_uninf_D  full_6_inf_D part_6_inf_D full_9_inf_D none_inf_D part_11_inf_D full_13_inf_D  full_13_uninf_beg_D full_9_uninf_beg_D full_6_uninf_beg_D part_11_uninf_beg_D part_6_uninf_beg_D none_uninf_beg_D full_13_inf_beg_D full_9_inf_beg_D full_6_inf_beg_D part_11_inf_beg_D part_6_inf_beg_D none_inf_beg_D if (Period>0)&(Seller==1)&(buyerD==1), nocon  cl(nGroup)

// difference from zero
test full_6_uninf_D =0
test part_6_uninf_D=0 
test full_9_uninf_D=0 
test none_uninf_D=0 
test part_11_uninf_D=0 
test full_13_uninf_D=0 

test full_6_inf_D =0
test part_6_inf_D=0 
test full_9_inf_D=0 
test none_inf_D=0
test part_11_inf_D=0 
test full_13_inf_D=0 

// difference from $10 ALL ARE DIFFERENT
test full_6_uninf_D=4
display "p-value = " 1-ttail(r(df_r),sign(_b[full_6_uninf_D]-4)*sqrt(r(F)))
test part_6_uninf_D=4
display "p-value = " 1-ttail(r(df_r),sign(_b[part_6_uninf_D]-4)*sqrt(r(F))) 
test full_9_uninf_D=1
display "p-value = " 1-ttail(r(df_r),sign(_b[full_9_uninf_D]-1)*sqrt(r(F)))  
test none_uninf_D=2/3 
display "p-value = " 1-ttail(r(df_r),sign(_b[none_uninf_D]-2/3)*sqrt(r(F)))  
test part_11_uninf_D=-1
display "p-value = " 1-ttail(r(df_r),sign(_b[part_11_uninf_D]+1)*sqrt(r(F)))  
test full_13_uninf_D=-3 
display "p-value = " 1-ttail(r(df_r),sign(_b[full_13_uninf_D]+3)*sqrt(r(F)))  


test full_6_inf_D=4
display "p-value = " 1-ttail(r(df_r),sign(_b[full_6_inf_D]-4)*sqrt(r(F)))
test part_6_inf_D=4
display "p-value = " 1-ttail(r(df_r),sign(_b[part_6_inf_D]-4)*sqrt(r(F))) 
test full_9_inf_D=1
display "p-value = " 1-ttail(r(df_r),sign(_b[full_9_inf_D]-1)*sqrt(r(F)))  
test none_inf_D=2/3 
display "p-value = " 1-ttail(r(df_r),sign(_b[none_inf_D]-2/3)*sqrt(r(F)))  
test part_11_inf_D=-1
display "p-value = " 1-ttail(r(df_r),sign(_b[part_11_inf_D]+1)*sqrt(r(F)))  
test full_13_inf_D=-3 
display "p-value = " 1-ttail(r(df_r),sign(_b[full_13_inf_D]+3)*sqrt(r(F)))  


// differences across information conditions
test full_6_uninf_D =full_6_inf_D
test part_6_uninf_D=part_6_inf_D 
test full_9_uninf_D=full_9_inf_D 
test none_uninf_D=none_inf_D
test part_11_uninf_D=part_11_inf_D 
test full_13_uninf_D=full_13_inf_D 


// *****************************************************************************
// *****************************************************************************
// TABLE 4
// *****************************************************************************
// *****************************************************************************

reg  SellDecision a_uninf_D b_uninf_D c_uninf_D e_uninf_D f_uninf_D a_inf_D b_inf_D c_inf_D d_inf_D e_inf_D f_inf_D a_uninf_beg_D b_uninf_beg_D c_uninf_beg_D  e_uninf_beg_D f_uninf_beg_D a_inf_beg_D b_inf_beg_D c_inf_beg_D d_inf_beg_D e_inf_beg_D f_inf_beg_D if (Period>0)&(Seller==1)&(buyerD==1), nocon  cl(nGroup)

// difference from one
test c_uninf_D = 1
test e_uninf_D = 1
test f_uninf_D = 1
test c_inf_D = 1
test e_inf_D = 1
test f_inf_D = 1

// different from area b
test a_uninf_D =  b_uninf_D
test c_uninf_D = b_uninf_D

test a_inf_D =  b_inf_D
test c_inf_D = b_inf_D

// different from area e
test b_uninf_D =  e_uninf_D
test f_uninf_D = e_uninf_D

test b_inf_D =  e_inf_D
test d_inf_D = e_inf_D
test f_inf_D = e_inf_D
// differences across information conditions
test a_uninf_D =  a_inf_D
test b_uninf_D =  b_inf_D
test c_uninf_D =  c_inf_D
test f_uninf_D =  f_inf_D
test e_uninf_D =  e_inf_D


// *****************************************************************************
// *****************************************************************************
// Bonus insidence: TABLE 5
// *****************************************************************************
// *****************************************************************************

reg bonusD  none_uninf_D part_uninf_D full_uninf_D  none_inf_D part_inf_D full_inf_D   part_uninf_beg_D full_uninf_beg_D none_uninf_beg_D part_inf_beg_D full_inf_beg_D none_inf_beg_D if (Period>0)&(Seller==1)&(buyerD==1), nocon  cl(nGroup)

// no trade prediction 
test none_uninf_D = 0.43
test part_uninf_D = 0.43
test full_uninf_D = 0.43
test none_inf_D = 0.43
test part_inf_D = 0.43 
test full_inf_D = 0.43

// optimal 
test none_uninf_D = 0.43 
test part_uninf_D = 0.7 
test full_uninf_D = 0.5 
test none_inf_D = 0.43
test part_inf_D = 0.7 
test full_inf_D = 0.5

// low == medium
test none_uninf_D == part_uninf_D
test none_inf_D == part_inf_D

// low == high
test none_uninf_D == full_uninf_D
test none_inf_D == full_inf_D

// medium == high
test part_uninf_D == full_uninf_D
test part_inf_D == full_inf_D

// acorss all three 
test none_uninf_D == part_uninf_D == full_uninf_D
test none_inf_D == part_inf_D == full_inf_D

// differences across information conditions
test none_uninf_D = none_inf_D
test part_uninf_D = part_inf_D
test full_uninf_D = full_inf_D



// *****************************************************************************
// *****************************************************************************
// TABLE 4: Automated
// *****************************************************************************
// *****************************************************************************

reg  SellDecision bb_uninf_D e_uninf_D bb_inf_D e_inf_D bb_uninf_beg_D e_uninf_beg_D bb_inf_beg_D e_inf_beg_D if (Period>0)&(Seller==1)&(buyerD==0), nocon  cl(nGroup)

// Different from 1 (e only)
test e_uninf_D = 1
test e_inf_D = 1
// Difference between e and b
test e_uninf_D = bb_uninf_D
test e_inf_D = bb_inf_D

// Difference across information conditions
test bb_uninf_D = bb_inf_D
test e_uninf_D = e_inf_D


// *****************************************************************************
// *****************************************************************************
// TABLE 5: Automated
// *****************************************************************************
// *****************************************************************************


reg bonusD  none_uninf_D part_uninf_D full_uninf_D none_inf_D part_inf_D full_inf_D  none_uninf_beg_D part_uninf_beg_D full_uninf_beg_D none_inf_beg_D part_inf_beg_D full_inf_beg_D  if (Period>0)&(Seller==1)&(buyerD==0), nocon  cl(nGroup)

// no trade prediction 
test none_uninf_D = 0.43
test part_uninf_D = 0.43
test full_uninf_D = 0.43
test none_inf_D = 0.43
test part_inf_D = 0.43 
test full_inf_D = 0.43

// optimal 
test none_uninf_D = 0.43 
test part_uninf_D = 0.7 
test full_uninf_D = 0.5 
test none_inf_D = 0.43
test part_inf_D = 0.7 
test full_inf_D = 0.5

// low == medium
test none_uninf_D == part_uninf_D
test none_inf_D == part_inf_D

// low == high
test none_uninf_D == full_uninf_D
test none_inf_D == full_inf_D

// medium == high
test part_uninf_D == full_uninf_D
test part_inf_D == full_inf_D

// acorss all three 
test none_uninf_D == part_uninf_D == full_uninf_D
test none_inf_D == part_inf_D == full_inf_D
  
