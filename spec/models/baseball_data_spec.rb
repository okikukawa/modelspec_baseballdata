require 'rails_helper'
describe Pitcher do
  it '最多投手が一人の場合'do
    Pitcher.create(player_id:'taro',year_id: 2000,wins:10)
    Pitcher.create(player_id:'jiro',year_id: 2001,wins:10)
    Pitcher.create(player_id:'saburo',year_id: 2000,wins:5)
    Pitcher.create(player_id:'shiro',year_id: 2000,wins:1)
    expect(Pitcher.most_winners(2000)).to eq ['taro']
  end
  it '最多投手が複数人の場合'do
    Pitcher.create(player_id:'taro',year_id: 2000,wins:10)
    Pitcher.create(player_id:'jiro',year_id: 2000,wins:10)
    Pitcher.create(player_id:'saburo',year_id: 2000,wins:5)
    Pitcher.create(player_id:'shiro',year_id: 2000,wins:1)
    expect(Pitcher.most_winners(2000)).to eq ['taro','jiro']
  end
  it '指定した年のデータが存在しない場合'do
    Pitcher.create(player_id:'taro',year_id: 2000,wins:10)
    Pitcher.create(player_id:'jiro',year_id: 2000,wins:10)
    Pitcher.create(player_id:'saburo',year_id: 2000,wins:5)
    Pitcher.create(player_id:'shiro',year_id: 2000,wins:1)
    expect(Pitcher.most_winners(2001)).to eq []
  end
  it '全員の勝利数が違う場合'do
    Pitcher.create(player_id:'player1',year_id: 2000,wins:10)
    Pitcher.create(player_id:'player2',year_id: 2000,wins:9)
    Pitcher.create(player_id:'player3',year_id: 2000,wins:8)
    Pitcher.create(player_id:'player4',year_id: 2000,wins:7)
    Pitcher.create(player_id:'player5',year_id: 2000,wins:6)
    Pitcher.create(player_id:'player6',year_id: 2000,wins:5)
    Pitcher.create(player_id:'player7',year_id: 2000,wins:4)
    Pitcher.create(player_id:'player8',year_id: 2000,wins:3)
    Pitcher.create(player_id:'player9',year_id: 2000,wins:2)
    Pitcher.create(player_id:'player10',year_id: 2000,wins:1)
    expect(Pitcher.top_ten(2000)).to eq ['player1','player2','player3','player4','player5','player6','player7','player8','player9','player10']
  end
  it '勝利数の重複がある場合'do
    Pitcher.create(player_id:'player1',year_id: 2000,wins:10)
    Pitcher.create(player_id:'player2',year_id: 2000,wins:10)
    Pitcher.create(player_id:'player3',year_id: 2000,wins:10)
    Pitcher.create(player_id:'player4',year_id: 2000,wins:7)
    Pitcher.create(player_id:'player5',year_id: 2000,wins:7)
    Pitcher.create(player_id:'player6',year_id: 2000,wins:7)
    Pitcher.create(player_id:'player7',year_id: 2000,wins:7)
    Pitcher.create(player_id:'player8',year_id: 2000,wins:7)
    Pitcher.create(player_id:'player9',year_id: 2000,wins:7)
    Pitcher.create(player_id:'player10',year_id: 2000,wins:7)
    Pitcher.create(player_id:'player11',year_id: 2000,wins:7)
    Pitcher.create(player_id:'player12',year_id: 2000,wins:7)
    Pitcher.create(player_id:'player13',year_id: 2000,wins:7)
    # top_tenメソッドは、勝利数が多い順に降順に並べ、１０番目のインデックス番号をもつ要素のの勝利数以上の要素をすべて取得するというメソッドなので、
    # このテストだと７勝のplayerを全て取得してしまい、並べるプレイヤーの総数が１０を超える
    expect(Pitcher.top_ten(2000)).to eq ['player1','player2','player3','player4','player5','player6','player7','player8','player9','player10','player11','player12','player13']
  end
  it'対象データが1件以上10件未満の場合'do
    Pitcher.create(player_id:'player1',year_id: 2000,wins:10)
    Pitcher.create(player_id:'player2',year_id: 2000,wins:9)
    Pitcher.create(player_id:'player3',year_id: 2000,wins:8)
    Pitcher.create(player_id:'player4',year_id: 2000,wins:7)
    Pitcher.create(player_id:'player5',year_id: 2000,wins:6)
    Pitcher.create(player_id:'player99',year_id: 2000,wins:99)
    Pitcher.create(player_id:'player6',year_id: 2000,wins:5)
    Pitcher.create(player_id:'player7',year_id: 2000,wins:4)
    expect(Pitcher.top_ten(2000)).to eq ['player99','player1','player2','player3','player4','player5','player6','player7']
  end
  it'対象データが0件の場合'do
    Pitcher.create(player_id:'player1',year_id: 2000,wins:10)
    Pitcher.create(player_id:'player2',year_id: 2000,wins:9)
    Pitcher.create(player_id:'player3',year_id: 2000,wins:8)
    Pitcher.create(player_id:'player4',year_id: 2000,wins:7)
    Pitcher.create(player_id:'player5',year_id: 2000,wins:6)
    Pitcher.create(player_id:'player6',year_id: 2000,wins:5)
    Pitcher.create(player_id:'player7',year_id: 2000,wins:4)
    Pitcher.create(player_id:'player8',year_id: 2000,wins:3)
    Pitcher.create(player_id:'player9',year_id: 2000,wins:2)
    Pitcher.create(player_id:'player10',year_id: 2000,wins:1)
    expect(Pitcher.top_ten(2001)).to eq []
  end
  describe 'ある年に、あるチームの中でもっとも勝利したピッチャーのplayer_idを配列で取得する'do
    it '最多勝利の投手が１人の場合'do
      Pitcher.create(player_id:'player1',team_id:"A",year_id: 2000,wins:10)
      Pitcher.create(player_id:'player2',team_id:"A",year_id: 2000,wins:9)
      Pitcher.create(player_id:'player3',team_id:"A",year_id: 2000,wins:8)
      Pitcher.create(player_id:'player4',team_id:"A",year_id: 2000,wins:7)
      Pitcher.create(player_id:'player5',team_id:"B",year_id: 2000,wins:20)
      expect(Pitcher.most_winners_in_team(2000,"A")).to eq ['player1']
    end
    it '最多勝利が複数人いる場合'do
      Pitcher.create(player_id:'player1',team_id:"A",year_id: 2000,wins:10)
      Pitcher.create(player_id:'player2',team_id:"A",year_id: 2000,wins:10)
      Pitcher.create(player_id:'player3',team_id:"A",year_id: 2000,wins:8)
      Pitcher.create(player_id:'player4',team_id:"A",year_id: 2000,wins:7)
      Pitcher.create(player_id:'player5',team_id:"B",year_id: 2000,wins:20)
      expect(Pitcher.most_winners_in_team(2000,"A")).to eq ['player1','player2']
    end
    it '該当するデータがない場合'do
      Pitcher.create(player_id:'player1',team_id:"A",year_id: 2000,wins:10)
      Pitcher.create(player_id:'player2',team_id:"A",year_id: 2000,wins:10)
      Pitcher.create(player_id:'player3',team_id:"A",year_id: 2000,wins:8)
      Pitcher.create(player_id:'player4',team_id:"A",year_id: 2000,wins:7)
      Pitcher.create(player_id:'player5',team_id:"B",year_id: 2000,wins:20)
      expect(Pitcher.most_winners_in_team(2001,"B")).to eq []
    end
  end
  describe '指定された期間の中でもっとも勝利したピッチャーのplayer_idを配列で取得する'do
    it '最多勝利の投手が１人の場合'do
      Pitcher.create(player_id:'player1',year_id: 2000,wins:10)
      Pitcher.create(player_id:'player2',year_id: 2006,wins:13)
      Pitcher.create(player_id:'player3',year_id: 2005,wins:12)
      Pitcher.create(player_id:'player4',year_id: 2004,wins:7)
      expect(Pitcher.most_winners_in_period(2000,2005)).to eq ['player3']
    end
    it '最多勝利が複数人いる場合'do
      Pitcher.create(player_id:'player1',year_id: 2000,wins:10)
      Pitcher.create(player_id:'player2',year_id: 2006,wins:13)
      Pitcher.create(player_id:'player3',year_id: 2005,wins:12)
      Pitcher.create(player_id:'player4',year_id: 2004,wins:12)
      expect(Pitcher.most_winners_in_period(2000,2005)).to eq ['player3','player4']
    end
    it '該当するデータがない場合'do
      Pitcher.create(player_id:'player1',year_id: 2000,wins:10)
      Pitcher.create(player_id:'player2',year_id: 2006,wins:13)
      Pitcher.create(player_id:'player3',year_id: 2005,wins:12)
      Pitcher.create(player_id:'player4',year_id: 2004,wins:12)
      expect(Pitcher.most_winners_in_period(2007,2012)).to eq []
    end
  end
  describe 'ある年で最も費用対効果が高かった投手のplayer_idを配列で取得する'do
    it '対象の投手が１人の場合'do
      Pitcher.create(player_id:'player1',year_id: 2000,wins:10)
      Pitcher.create(player_id:'player2',year_id: 2000,wins:9)
      Pitcher.create(player_id:'player3',year_id: 2000,wins:8)
      Salary.create(player_id:'player1',year_id: 2000,salary:20000)
      Salary.create(player_id:'player2',year_id: 2000,salary:15000)
      Salary.create(player_id:'player3',year_id: 2000,salary:10000)
      expect(Pitcher.best_deal(2000)).to eq ['player3']
    end
    it '複数人の場合'do
      Pitcher.create(player_id:'player1',year_id: 2000,wins:10)
      Pitcher.create(player_id:'player2',year_id: 2000,wins:9)
      Pitcher.create(player_id:'player3',year_id: 2000,wins:9)
      Salary.create(player_id:'player1',year_id: 2000,salary:20000)
      Salary.create(player_id:'player2',year_id: 2000,salary:15000)
      Salary.create(player_id:'player3',year_id: 2000,salary:15000)
      expect(Pitcher.best_deal(2000)).to eq ['player2','player3']
    end
    it '１人もいない場合'do
      Pitcher.create(player_id:'player1',year_id: 2000,wins:10)
      Pitcher.create(player_id:'player2',year_id: 2000,wins:9)
      Pitcher.create(player_id:'player3',year_id: 2000,wins:9)
      Salary.create(player_id:'player1',year_id: 2000,salary:20000)
      Salary.create(player_id:'player2',year_id: 2000,salary:15000)
      Salary.create(player_id:'player3',year_id: 2000,salary:15000)
      expect(Pitcher.best_deal(2001)).to eq []
      end
  end
end
