module.exports =
  subreddits: [
      id: 1000
      name: 'personalfinance'
      triggers: [2000]
  ]
  triggers: [
      id: 2000
      value: '/u/PFBot!'
      commands: [3000, 3001]
      subreddits: [1000]
  ]
  commands: [
      id: 3000
      value: 'How much should you save?'
      triggers: [2000]
      responses: [4000]
    ,
      id: 3001
      value: 'How much should I save?'
      triggers: [2000]
      responses: [4000]
    ,
      id: 3002
      value: 'FAQ!'
      triggers: [2000]
      responses: [4001]
  ]
  responses: [
      id: 4000
      commands: [3000, 3001]
      value: '''
        TL;DR -  you should save as much as you can afford to. The more you save
        the earlier you can retire.

        Assuming your expenses in retirement will be roughly equivalent to your
        expenses now you can tell how much money you should save based on when
        you'd like to retire. And if you know how much you spend and how much
        you save that totals to how much you earn and can give us a percentage!
        
        For this calculation we'll assume the following reasonable things:
        
        - You use a [4% Safe withdrawal rate](http://www.bogleheads.org/wiki/Safe_withdrawal_rates) during retirement
        
        - You earn 5% rate of return on your investments after inflation
        
        - You plan to live a _long_ time so you want your nest egg to keep the same [real value](http://en.wikipedia.org/wiki/Real_versus_nominal_value_(economics\\))
        
        Savings Rate | Working Years until Retirement
        ----:|:---
        0%   | ∞
        5%   | 66
        10%  | 51
        15%  | 43
        20%  | 37
        25%  | 32
        33%  | 26
        50%  | 17
        67%  | 9.8
        75%  | 7.1
        80%  | 5.6
        90%  | 2.7
        95%  | 1.3
        100% | 0.0

        [Here's a spreadsheet with the calculations!](https://www.icloud.com/iw/#numbers/BAJbxS4DfKc4GZwkDE2B8kq-fV8eLqxVfF-E)
      '''
    ,
      id: 4001
      commands: [3002]
      value: '/r/personalfinance/wiki/faq'
  ]

