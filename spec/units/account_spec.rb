require 'account'

describe Account do
  it { is_expected.to be_instance_of Account }

  it "starts with a balance of 0" do
    expect(subject.balance).to eq 0
  end

  it "starts with empty transaction array" do
    expect(subject.transactions).to be_empty
  end

  describe '#withdraw' do
    it "changes balance by amount withdrawn" do
      expect{ subject.withdraw(10, Time.new(2012-1-10)) }.to change{ subject.balance }.by (-10)
    end

    it "creates new withdrawal transaction" do
      expect{ subject.withdraw(10, Time.new(2012-1-10)) }.to change { subject.transactions.size }.by (1)
    end
  end
end
