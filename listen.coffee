module.exports =
  subreddits: [
      id: 1000
      name: 'personalfinance'
      triggers: [2000]
  ]
  triggers: [
      id: 2000
      value: '/u/PFBot!'
      commands: [3000, 3001, 3002, 3003, 3004, 3005, 3006, 3007, 3008, 3009]
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
    ,
      id: 3003
      value: 'Where should you start?'
      triggers: [2000]
      responses: [4002]
    ,
      id: 3004
      value: 'Where should I start?'
      triggers: [2000]
      responses: [4002]
    ,
      id: 3005
      value: 'WTF?'
      triggers: [2000]
      responses: [4003]
    ,
      id: 3006
      value: 'Thanks'
      triggers: [2000]
      responses: [4004]
    ,
      id: 3007
      value: 'Thank you'
      triggers: [2000]
      responses: [4004]
    ,
      id: 3008
      value: 'What do you do with a windfall?'
      triggers: [2000]
      responses: [4005]
    ,
      id: 3009
      value: 'What do I do with a windfall?'
      triggers: [2000]
      responses: [4005]
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
    ,
      id: 4002
      commands: [3003, 3004]
      value: 'http://www.bogleheads.org/wiki/Getting_Started'
    ,
      id: 4003
      commands: [3005]
      value: '''
        Hello, my name is /u/PFBot. I was created by /u/KerrickLong to help the
        /r/PersonalFinance community. To learn more about me, including my
        commands, please visit /r/PFBot/wiki/faq.
      '''
    ,
      id: 4004
      commands: [3006, 3007]
      value: '\tUncaught ThanksError: Could not accept gratitude, not a human.'
    ,
      id: 4005
      commands: [3008, 3009]
      value: '''
      First, **tell nobody** (except your spouse, and maybe your CPA /
      accountant / financial planner) until you've got a plan.

      From the sidebar: ["I have $[X]... What do I do with
      it?!"](http://lazytraders.com/insights/starting-out-i-have-x-dollars-what-should-i-invest-in/)

      From the Bogleheads Wiki:
      [Windfalls](http://www.bogleheads.org/wiki/Windfalls)
      '''
  ]

